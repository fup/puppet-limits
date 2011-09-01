# Class: limits::params
#
# Description
#   This class is designed to carry default parameters for 
#   Class: limits 
#
# Parameters:
#   $ls_tmp_dir - The temporary directory where the File Fragment will be assembled on the system
#   $ls_output_file - The name of the file created from the File Fragment assembly. To be stored
#                     in /etc/security/limits.d
#
# Actions:
#   This module does not perform any actions.
#
# Requires:
#   This module has no requirements.   
#
# Sample Usage:
#   This method should not be called directly.
class limits::params {
  $ls_tmp_dir     = 'limits.d'
  $ls_output_file = 'puppet-limits-autogen.conf'
}
