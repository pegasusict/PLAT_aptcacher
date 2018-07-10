#!/bin/bash
################################################################################
# Pegasus' Linux Administration Tools	#	  apt cacher server install script #
# (C)2017-2018 Mattijs Snepvangers		#				 pegasus.ict@gmail.com #
# License: MIT							#	Please keep my name in the credits #
################################################################################
START_TIME=$(date +"%Y-%m-%d_%H.%M.%S.%3N")
# Making sure this script is run by bash to prevent mishaps
if [ "$(ps -p "$$" -o comm=)" != "bash" ]; then bash "$0" "$@" ; exit "$?" ; fi
# Make sure only root can run this script
if [[ $EUID -ne 0 ]]; then echo "This script must be run as root" ; exit 1 ; fi
echo "$START_TIME ## Starting PostInstall Process #######################"
### FUNCTIONS ###
init() {
	################### PROGRAM INFO ###########################################
	declare -gr PROGRAM_SUITE="Pegasus' Linux Administration Tools"
	declare -gr SCRIPT="${0##*/}"
	declare -gr SCRIPT_DIR="${0%/*}"
	declare -gr SCRIPT_TITLE="APT Caching Server Install Script"
	declare -gr MAINTAINER="Mattijs Snepvangers"
	declare -gr MAINTAINER_EMAIL="pegasus.ict@gmail.com"
	declare -gr COPYRIGHT="(c)2017-$(date +"%Y")"
	declare -gr VER_MAJOR=0
	declare -gr VER_MINOR=0
	declare -gr VER_PATCH=5
	declare -gr VER_STATE="PRE-ALPHA"
	declare -gr BUILD=20180710
	declare -gr LICENSE="MIT"
	############################################################################
	declare -gr PROGRAM="$PROGRAM_SUITE - $SCRIPT_TITLE"
	declare -gr SHORT_VER="$VER_MAJOR.$VER_MINOR.$VER_PATCH-$VER_STATE"
	declare -gr VER="Ver$SHORT_VER build $BUILD"
}

prep() {
	import "BASH_FUNC_LIB/default.inc.bash"
	create_dir "$LOG_DIR"
#	header
#	goto_base_dir
#	parse_ini $INI_FILE
#	get_args $@
	declare -gr AC_CFG="/etc/apt-cacher-ng/acng.conf"
}

import() {
	local _FILE="$1"
	if [[ -f "$_FILE" ]]
	then
		source "$_FILE"
	else
		exit 1  "File $_FILE not found!"
#		crit_line "File $_FILE not found!"
#		exit 1
	fi
}

main() {
	### install apt-cacher
	apt_inst apt-cacher-ng
	edit_line_in_file "CacheDir: /var/cache/apt-cacher-ng" "CacheDir: /var/cache/apt-cacher-ng" "$AC_CFG"
}

##### BOILERPLATE #####
init
prep
main
