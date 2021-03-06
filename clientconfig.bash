#!/bin/bash
################################################################################
# Pegasus' Linux Administration Tools	#	  apt cacher client install script #
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
	declare -gr SCRIPT_TITLE="APT Caching Client Install Script"
	declare -gr MAINTAINER="Mattijs Snepvangers"
	declare -gr MAINTAINER_EMAIL="pegasus.ict@gmail.com"
	declare -gr COPYRIGHT="(c)2017-$(date +"%Y")"
	declare -gr VER_MAJOR=0
	declare -gr VER_MINOR=1
	declare -gr VER_PATCH=0
	declare -gr VER_STATE="BETA"
	declare -gr BUILD=20181224
	declare -gr LICENSE="MIT"
	############################################################################
	declare -gr PROGRAM="$PROGRAM_SUITE - $SCRIPT_TITLE"
	declare -gr SHORT_VER="$VER_MAJOR.$VER_MINOR.$VER_PATCH-$VER_STATE"
	declare -gr VER="Ver$SHORT_VER build $BUILD"
}

prep() {
	declare -gr CACHE_SERVER="192.168.2.200"
#	import "BASH_FUNC_LIB/default.inc.bash"
#	create_dir "$LOG_DIR"
#	header
#	goto_base_dir
#	parse_ini $INI_FILE
#	get_args
}

import() {
	local _FILE="$1"
	if [[ -f "$_FILE" ]]
	then
		source "$_FILE"
	else
#		crit_line "File $_FILE not found!"
		exit 1 "File $_FILE not found!"
#		exit 1
	fi
}

### FUNCTIONS ##########
insert_proxy() {
	local _FILE="/etc/apt/apt.conf.d/00aptproxy"
	local _LINE="Acquire::http::Proxy \"http://$CACHE_SERVER:3142\";"
	echo "$_LINE" > "$_FILE"
}

main() {
	insert_proxy
}
######### BOILERPLATE ##############

init
prep
main
