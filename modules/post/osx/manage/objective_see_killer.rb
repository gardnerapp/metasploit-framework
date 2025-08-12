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

  # TODO figure out the directories for all other apps
  # TODO different versions may have different directory names, figure this out.
  def enumerate
  	# Array of directory names used by Objective See products. These will be in the /Applications/folder.
  	# ex. drwxr-xr-x@  3 root    admin     96 Jun 13  2019 BlockBlock Helper.app
  	# ex. drwxr-xr-x@  3 marvin  admin     96 Jan 29  2019 LuLu.app
  	products = ["BlockBlock Helper.app", "KnockKnock.app", "LuLu.app"].flat_map {|prod| "/Applications/#{prod}"}

  	# get a list of all installed products
  	@installed = {
  		:writable => [],
  		:unwritable => []
  	}

  	# TODO get versions. They are installed in Product.App/Contents/Info.plist
  	# CFBundleVersion is the key in the xml file

  	products.each do |dir| 
  		if is_dir? dir
  			writable? dir ? @installed[:writable] << dir @installed[:unwirtable] << dir
  		end
  	end

  	%i[writable unwritable].each do |status|
  		@installed[status].each do |dir|
  			# TODO read Contents/Info.plist file and get version of each app
  			#plist = dir + "Contents/Info.plist"
  			#file = File.open plist
  			#read = File.read file
  			#doc = Nokogiri::XML::Document.parse read


  			print_good "#{dir} is installed and is #{status}"
  		end 
  	end 


  	@installed
  end

  def disable_LuLu

  end 

  def exploit
  	print_status("Enumerating Objective See security products.")
  	enumerate
  end
end
