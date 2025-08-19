##
# This module requires Metasploit: https://metasploit.com/download
# Current source: https://github.com/rapid7/metasploit-framework
##

class MetasploitModule < Msf::Post
	require 'nokogiri'


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
  end

  # Holds information on an objective see product. i.e name, installation status user perms, group perms, owner, and location on filesystem.
  class ObjectiveSee

    # Array of products present on system
    @@present = []

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

   class << self
    def present
      @@present
   end 
  end 

  def enumerate
  	products = ["BlockBlock Helper.app", "KnockKnock.app", "LuLu.app"].map {|prod| ObjectiveSee.new prod}.filter_map {|product| product.installed? }



  	# May also need to check if products are enabled 
  	# How do I send a signal to a product and simulate hitting the enable/disable button? 
  	# Is there a way to interact with the command line?

  	# TODO use process monitor. Hit the disable button on LuLu find args, see if you can replicate in module
  	# Check if apps are executable so you can check if you can send disable switch
  	# Remove LuLu's peristence mechanism be it a login item, launch agent, launch daemon etc.
  end

  def disable_LuLu

  end 

  def exploit
  	print_status("Enumerating Objective See security products.")
  	enumerate
  end

end
