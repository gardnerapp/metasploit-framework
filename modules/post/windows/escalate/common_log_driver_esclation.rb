# This module requires Metasploit: https://metasploit.com/download
# Current source: https://github.com/rapid7/metasploit-framework
##

# TODO Figure out how exploit works
class MetasploitModule < Msf::Post

	def initialize(info = {})
		super(update_info(
			info,
			'Name' => 'Escelate With Common Log Driver Exploit',
			'Description' => %q{},
			'License' => MSF_LICENSE,
			'Author' => [
				"Marv aka gardnerapp"
			],
			'Platform' => [ 'win' ],
			'SessionTypes' => ['?'],
			)
		)
	end
end 