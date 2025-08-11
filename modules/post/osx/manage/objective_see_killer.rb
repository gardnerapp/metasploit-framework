##
# This module requires Metasploit: https://metasploit.com/download
# Current source: https://github.com/rapid7/metasploit-framework
##

class MetasploitModule < Msf::Post


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

  def enumerate
  	# Array of directory names used by Objective See products. These will be in the /Applications/folder.
  	# ex. drwxr-xr-x@  3 root    admin     96 Jun 13  2019 BlockBlock Helper.app
  	# ex. drwxr-xr-x@  3 marvin  admin     96 Jan 29  2019 LuLu.app

  	# TODO figure out the directories for all other apps
  	# TODO different versions may have different directory names, figure this out.
  	product_directories = ["BlockBlock Helper.app", "KnockKnock.app", "LuLu.app"].flat_map {|prod| "/Applications/#{prod}"}

  	# get a list of all installed products
  	@installed_products = []
  	product_directories.each {|dir| @installed_products << dir if is_dir? dir}
  	# in /Applications/LuLu.app/Contents/Resources/LuLu Uninstaller.app
  end

  def exploit; end
end
