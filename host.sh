#!/bin/sh

# Version:    1.6.7
# Author:     Héctor Molinero Fernández <hector@molinero.xyz>
# Repository: https://github.com/hectorm/hblock
# License:    MIT, https://opensource.org/licenses/MIT

set -eu
export LC_ALL=C

# shellcheck disable=SC2039
HOSTNAME=${HOSTNAME-$(uname -n)}

# Check if a program exists
exists() {
	# shellcheck disable=SC2230
	if command -v true; then command -v -- "$1"
	elif eval type type; then eval type -- "$1"
	else which -- "$1"; fi >/dev/null 2>&1
}

# Escape strings in sed
# See: https://stackoverflow.com/a/29613573
quoteRe() { printf -- '%s' "$1" | sed -e 's/[^^]/[&]/g; s/\^/\\^/g; $!a'\\''"$(printf '\n')"'\\n' | tr -d '\n'; }
quoteSubst() { printf -- '%s' "$1" | sed -e ':a' -e '$!{N;ba' -e '}' -e 's/[&/\]/\\&/g; s/\n/\\&/g'; }

# Translate true/false to yes/no
getBoolVal() { [ "$1" = true ] && s='yes' || s='no'; printf -- '%s' "$s"; }

# Print to stdout if quiet mode is not enabled
printStdout() {
	if [ "$quiet" != true ]; then
		# shellcheck disable=SC2059
		printf -- "$@"
	fi
}

# Print to stderr
printStderr() {
	# shellcheck disable=SC2059
	>&2 printf -- "$@"
}

# Print informational message
logInfo() {
	printStdout '   - %s\n' "$@"
}

# Print action message
logAction() {
	if [ "$color" = true ]; then
		printStdout '\033[1;33m + \033[1;32m%s \033[0m\n' "$@"
	else
		printStdout ' + %s \n' "$@"
	fi
}

# Print error message
logError() {
	if [ "$color" = true ]; then
		printStderr '\033[1;33m + \033[1;31m%s \033[0m\n' "$@"
	else
		printStderr ' + %s \n' "$@"
	fi
}

# Create temporary file
createTempFile() {
	if exists mktemp; then mktemp
	else # Since POSIX does not specify mktemp utility, a counter is used as a fallback
		tempCounter=${tempCounter:-9999}
		tempFile="${TMPDIR:-/tmp}/hblock.$((tempCounter+=1))"
		rm -f -- "$tempFile" && touch -- "$tempFile"
		printf -- '%s\n' "$tempFile"
	fi
}

# Print to stdout the contents of a URL
fetchUrl() {
	# If the protocol is "file://" we can omit the download and simply use cat
	if [ "${1#file://}" != "$1" ]; then cat -- "${1#file://}"
	else
		userAgent='Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0'
		if exists curl; then curl -fsSL -A "$userAgent" -- "$1";
		elif exists wget; then wget -qO- -U "$userAgent" -- "$1";
		else
			logError 'Either wget or curl are required for this script'
			exit 1
		fi
	fi
}

# Show help and quit
showHelp() {
	if [ $# -eq 0 ]; then
		printStdout '%s\n' "$(cat <<-'EOF'
			Usage: hblock [options...]
			 -O, --output <FILE>
			        Output file location
			        (default: /etc/hosts)
			 -R, --redirection <REDIRECTION>
			        Redirection for all entries in the blocklist
			        (default: 0.0.0.0)
			 -H, --header <HEADER>
			        Content to be included at the beginning of the file
			        (e.g. "$(cat header.txt)")
			 -F, --footer <FOOTER>
			        Content to be included at the end of the file
			        (e.g. "$(cat footer.txt)")
			 -T, --template <TEMPLATE>
			        POSIX BREs replacement applied to each entry
			        \1 = <DOMAIN>, \2 = <REDIRECTION>
			        (default: \2 \1)
			 -C, --comment <COMMENT>
			        Character used for comments
			        (default: #)
			 -S, --sources <URLS>
			        Sources to be used to generate the blocklist
			        (whitespace separated URLs)
			 -W, --whitelist <ENTRIES>
			        Entries to be removed from the blocklist
			        (whitespace separated POSIX BREs)
			 -B, --blacklist <ENTRIES>
			        Entries to be added to the blocklist
			 -b, --backup [DIRECTORY]
			        Make a time-stamped backup in <DIRECTORY>
			        (default: output file directory)
			 -l, --lenient
			        Match all entries from sources, regardless of their IP
			        (default: 0.0.0.0, 127.0.0.1 or none)
			 -i, --ignore-download-error
			        Do not abort if a download error occurs
			 -c, --color <auto|true|false>
			        Colorize the output
			        (default: auto)
			 -q, --quiet
			        Suppress non-error messages
			 -v, --version
			        Show version number and quit
			 -h, --help
			        Show this help and quit

			Report bugs to: <https://github.com/hectorm/hblock/issues>.
		EOF
		)"
		exit 0
	else
		[ -n "$1" ] && printStderr '%s\n' "Illegal option $1"
		printStderr '%s\n' "Try 'hblock --help' for more information"
		exit 1
	fi
}

# Show version number and quit
showVersion() {
	printStdout '%s\n' '1.6.7'
	exit 0
}

main() {
	output='/etc/hosts'
	redirection='0.0.0.0'
	header=$(cat <<-EOF
		127.0.0.1       localhost $HOSTNAME
		255.255.255.255 broadcasthost
		::1             localhost ip6-localhost ip6-loopback
		fe00::0         ip6-localnet
		ff00::0         ip6-mcastprefix
		ff02::1         ip6-allnodes
		ff02::2         ip6-allrouters
		ff02::3         ip6-allhosts
	EOF
	)
	custom=''
	footer=''
	template='\2 \1'
	comment='#'
	sources=$(cat <<-'EOF'
		https://raw.githubusercontent.com/hectorm/hmirror/master/data/adaway.org/list.txt
		https://raw.githubusercontent.com/hectorm/hmirror/master/data/adblock-nocoin-list/list.txt
		https://raw.githubusercontent.com/hectorm/hmirror/master/data/adguard-simplified/list.txt
		https://raw.githubusercontent.com/hectorm/hmirror/master/data/disconnect.me-ad/list.txt
		https://raw.githubusercontent.com/hectorm/hmirror/master/data/disconnect.me-malvertising/list.txt
		https://raw.githubusercontent.com/hectorm/hmirror/master/data/disconnect.me-malware/list.txt
		https://raw.githubusercontent.com/hectorm/hmirror/master/data/disconnect.me-tracking/list.txt
		https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist/list.txt
		https://raw.githubusercontent.com/hectorm/hmirror/master/data/easyprivacy/list.txt
		https://raw.githubusercontent.com/hectorm/hmirror/master/data/eth-phishing-detect/list.txt
		https://raw.githubusercontent.com/hectorm/hmirror/master/data/fademind-add.2o7net/list.txt
		https://raw.githubusercontent.com/hectorm/hmirror/master/data/fademind-add.dead/list.txt
		https://raw.githubusercontent.com/hectorm/hmirror/master/data/fademind-add.risk/list.txt
		https://raw.githubusercontent.com/hectorm/hmirror/master/data/fademind-add.spam/list.txt
		https://raw.githubusercontent.com/hectorm/hmirror/master/data/kadhosts/list.txt
		https://raw.githubusercontent.com/hectorm/hmirror/master/data/malwaredomainlist.com/list.txt
		https://raw.githubusercontent.com/hectorm/hmirror/master/data/malwaredomains.com-immortaldomains/list.txt
		https://raw.githubusercontent.com/hectorm/hmirror/master/data/malwaredomains.com-justdomains/list.txt
		https://raw.githubusercontent.com/hectorm/hmirror/master/data/matomo.org-spammers/list.txt
		https://raw.githubusercontent.com/hectorm/hmirror/master/data/mitchellkrogza-badd-boyz-hosts/list.txt
		https://raw.githubusercontent.com/hectorm/hmirror/master/data/pgl.yoyo.org/list.txt
		https://raw.githubusercontent.com/hectorm/hmirror/master/data/ransomwaretracker.abuse.ch/list.txt
		https://raw.githubusercontent.com/hectorm/hmirror/master/data/someonewhocares.org/list.txt
		https://raw.githubusercontent.com/hectorm/hmirror/master/data/spam404.com/list.txt
		https://raw.githubusercontent.com/hectorm/hmirror/master/data/stevenblack/list.txt
		https://raw.githubusercontent.com/hectorm/hmirror/master/data/winhelp2002.mvps.org/list.txt
		https://raw.githubusercontent.com/hectorm/hmirror/master/data/zerodot1-coinblockerlists-browser/list.txt
		https://raw.githubusercontent.com/hectorm/hmirror/master/data/zeustracker.abuse.ch/list.txt
		https://hosts-file.net/grm.txt
https://reddestdream.github.io/Projects/MinimalHosts/etc/MinimalHostsBlocker/minimalhosts
https://raw.githubusercontent.com/StevenBlack/hosts/master/data/KADhosts/hosts
https://raw.githubusercontent.com/StevenBlack/hosts/master/data/add.Spam/hosts
https://v.firebog.net/hosts/static/w3kbl.txt
https://v.firebog.net/hosts/BillStearns.txt
http://sysctl.org/cameleon/hosts
https://raw.githubusercontent.com/CHEF-KOCH/BarbBlock-filter-list/master/HOSTS.txt
https://www.dshield.org/feeds/suspiciousdomains_Low.txt
https://www.dshield.org/feeds/suspiciousdomains_Medium.txt
https://www.dshield.org/feeds/suspiciousdomains_High.txt
https://www.joewein.net/dl/bl/dom-bl-base.txt
https://raw.githubusercontent.com/matomo-org/referrer-spam-blacklist/master/spammers.txt
https://hostsfile.org/Downloads/hosts.txt
http://someonewhocares.org/hosts/zero/hosts
https://raw.githubusercontent.com/Dawsey21/Lists/master/main-blacklist.txt
https://raw.githubusercontent.com/vokins/yhosts/master/hosts
http://winhelp2002.mvps.org/hosts.txt
https://hostsfile.mine.nu/hosts0.txt
https://v.firebog.net/hosts/Kowabit.txt
https://adblock.mahakala.is
https://adaway.org/hosts.txt
https://v.firebog.net/hosts/AdguardDNS.txt
https://raw.githubusercontent.com/anudeepND/blacklist/master/adservers.txt
https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt
https://hosts-file.net/ad_servers.txt
https://v.firebog.net/hosts/Easylist.txt
https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts;showintro=0
https://raw.githubusercontent.com/StevenBlack/hosts/master/data/UncheckyAds/hosts
https://raw.githubusercontent.com/CHEF-KOCH/CKs-FilterList/master/HOSTS/CK's-Spotify-HOSTS-FilterList.txt
https://v.firebog.net/hosts/Easyprivacy.txt
https://v.firebog.net/hosts/Prigent-Ads.txt
https://raw.githubusercontent.com/quidsup/notrack/master/trackers.txt
https://raw.githubusercontent.com/StevenBlack/hosts/master/data/add.2o7Net/hosts
https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt
https://v.firebog.net/hosts/Airelle-trc.txt
https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/android-tracking.txt
https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/SmartTV.txt
https://raw.githubusercontent.com/CHEF-KOCH/Canvas-Font-Fingerprinting-pages/master/Canvas.txt
https://raw.githubusercontent.com/CHEF-KOCH/WebRTC-tracking/master/WebRTC.txt
https://raw.githubusercontent.com/CHEF-KOCH/Audio-fingerprint-pages/master/AudioFp.txt
https://raw.githubusercontent.com/CHEF-KOCH/Canvas-fingerprinting-pages/master/Canvas.txt
https://s3.amazonaws.com/lists.disconnect.me/simple_malvertising.txt
https://mirror1.malwaredomains.com/files/justdomains
https://hosts-file.net/exp.txt
https://hosts-file.net/emd.txt
https://hosts-file.net/psh.txt
https://mirror.cedia.org.ec/malwaredomains/immortal_domains.txt
https://www.malwaredomainlist.com/hostslist/hosts.txt
https://bitbucket.org/ethanr/dns-blacklists/raw/8575c9f96e5b4a1308f2f12394abd86d0927a4a0/bad_lists/Mandiant_APT1_Report_Appendix_D.txt
https://v.firebog.net/hosts/Prigent-Malware.txt
https://v.firebog.net/hosts/Prigent-Phishing.txt
https://raw.githubusercontent.com/quidsup/notrack/master/malicious-sites.txt
https://ransomwaretracker.abuse.ch/downloads/RW_DOMBL.txt
https://ransomwaretracker.abuse.ch/downloads/CW_C2_DOMBL.txt
https://ransomwaretracker.abuse.ch/downloads/LY_C2_DOMBL.txt
https://ransomwaretracker.abuse.ch/downloads/TC_C2_DOMBL.txt
https://ransomwaretracker.abuse.ch/downloads/TL_C2_DOMBL.txt
https://zeustracker.abuse.ch/blocklist.php?download=domainblocklist
https://v.firebog.net/hosts/Shalla-mal.txt
https://raw.githubusercontent.com/StevenBlack/hosts/master/data/add.Risk/hosts
https://v.firebog.net/hosts/Airelle-hrsk.txt
https://zerodot1.gitlab.io/CoinBlockerLists/hosts
	EOF
	)
	whitelist=''
	blacklist=''
	backup=false
	lenient=false
	ignoreDownloadError=false
	color=auto
	quiet=false

	# Transform long options to short ones
	for opt in "$@"; do
		shift
		case "$opt" in
			'--output')                set -- "$@" '-O' ;;
			'--redirection')           set -- "$@" '-R' ;;
			'--header')                set -- "$@" '-H' ;;
			'--footer')                set -- "$@" '-F' ;;
			'--template')              set -- "$@" '-T' ;;
			'--comment')               set -- "$@" '-C' ;;
			'--sources')               set -- "$@" '-S' ;;
			'--whitelist')             set -- "$@" '-W' ;;
			'--blacklist')             set -- "$@" '-B' ;;
			'--backup')                set -- "$@" '-b' ;;
			'--lenient')               set -- "$@" '-l' ;;
			'--ignore-download-error') set -- "$@" '-i' ;;
			'--color')                 set -- "$@" '-c' ;;
			'--quiet')                 set -- "$@" '-q' ;;
			'--version')               set -- "$@" '-v' ;;
			'--help')                  set -- "$@" '-h' ;;
			*)                         set -- "$@" "$opt"
		esac
	done
	# Set omitted arguments to empty strings
	for opt in "$@"; do
		shift
		case "$opt" in
			-*b)
				if a="$*"; [ -z "$a" ] || [ "${a#\-}x" != "${a}x" ]
					then set -- "$@" "$opt" ''
					else set -- "$@" "$opt"
				fi
				;;
			*) set -- "$@" "$opt"
		esac
	done
	# Read short options
	OPTIND=1
	while getopts ':O:R:H:F:T:C:S:W:B:b:lic:qvh-:' opt; do
		case "$opt" in
			'O') output="$OPTARG" ;;
			'R') redirection="$OPTARG" ;;
			'H') header="$OPTARG" ;;
			'F') footer="$OPTARG" ;;
			'T') template="$OPTARG" ;;
			'C') comment="$OPTARG" ;;
			'S') sources="$OPTARG" ;;
			'W') whitelist="$OPTARG" ;;
			'B') blacklist="$OPTARG" ;;
			'b') backup=true; backupDir="$OPTARG" ;;
			'l') lenient=true ;;
			'i') ignoreDownloadError=true ;;
			'c') color="$OPTARG" ;;
			'q') quiet=true ;;
			'v') showVersion ;;
			'h') showHelp ;;
			'-') showHelp "--$OPTARG" ;;
			*)   showHelp "-$OPTARG"
		esac
	done

	# Check color support
	if [ "$color" = auto ]; then
		[ -t 1 ] && color=true || color=false
	fi

	logAction 'Configuration:'

	logInfo "Output: $output"
	logInfo "Redirection: $redirection"
	logInfo "Backup: $(getBoolVal "$backup")"
	logInfo "Lenient: $(getBoolVal "$lenient")"
	logInfo "Ignore download error: $(getBoolVal "$ignoreDownloadError")"

	# Create temporary blocklist file
	blocklist=$(createTempFile)
	rmtemp() { rm -f -- "$blocklist" "$blocklist.aux"; }
	trap rmtemp EXIT

	logAction 'Downloading lists...'

	for url in $sources; do
		logInfo "$url"
		fetchUrl "$url" >> "$blocklist" && exitCode=0 || exitCode=$?
		if [ "$exitCode" -ne 0 ] && [ "$ignoreDownloadError" != true ]; then
			logError 'Download failed'
			exit 1
		fi
	done

	logAction 'Parsing lists...'

	if [ -s "$blocklist" ]; then
		logInfo 'Remove carriage return'
		tr -d '\r' \
			< "$blocklist" > "$blocklist.aux" \
			&& mv -f -- "$blocklist.aux" "$blocklist"

		logInfo 'Transform to lowercase'
		tr '[:upper:]' '[:lower:]' \
			< "$blocklist" > "$blocklist.aux" \
			&& mv -f -- "$blocklist.aux" "$blocklist"

		logInfo 'Remove comments'
		sed -e 's/#.*//' \
			-- "$blocklist" > "$blocklist.aux" \
			&& mv -f -- "$blocklist.aux" "$blocklist"

		logInfo 'Trim spaces'
		sed -e 's/^[[:blank:]]*//' \
			-e 's/[[:blank:]]*$//' \
			-- "$blocklist" > "$blocklist.aux" \
			&& mv -f -- "$blocklist.aux" "$blocklist"

		logInfo 'Match hosts lines'
		if [ "$lenient" = true ]; then
			# This regex would be ideal, but it is not POSIX-compliant.
			# ipOctetRegex='\(25[0-5]\|2[0-4][0-9]\|[01]\{0,1\}[0-9][0-9]\{0,1\}\)'
			# ipRegex="\\($ipOctetRegex\\.$ipOctetRegex\\.$ipOctetRegex\\.$ipOctetRegex\\)"
			ipRegex='\([0-9]\{1,3\}\.\)\{3\}[0-9]\{1,3\}'
		else
			# Same as above.
			# ipRegex='\(\(0\.0\.0\.0\)\|\(127\.0\.0\.1\)\)'
			ipRegex='\(0\.0\.0\.0\)\{0,1\}\(127\.0\.0\.1\)\{0,1\}'
		fi
		domainRegex='\([0-9a-z_-]\{1,63\}\.\)\{1,\}[a-z][0-9a-z_-]\{1,62\}'
		sed -n \
			-e "/^\\(${ipRegex}[[:blank:]]\\{1,\\}\\)\\{0,1\\}$domainRegex$/p" \
			-- "$blocklist" > "$blocklist.aux" \
			&& mv -f -- "$blocklist.aux" "$blocklist"

		logInfo 'Remove reserved TLDs'
		sed -e '/\.example$/d' \
			-e '/\.invalid$/d' \
			-e '/\.local$/d' \
			-e '/\.localdomain$/d' \
			-e '/\.localhost$/d' \
			-e '/\.test$/d' \
			-- "$blocklist" > "$blocklist.aux" \
			&& mv -f -- "$blocklist.aux" "$blocklist"

		logInfo 'Remove destination IPs'
		sed -e 's/^.\{1,\}[[:blank:]]\{1,\}//' \
			-- "$blocklist" > "$blocklist.aux" \
			&& mv -f -- "$blocklist.aux" "$blocklist"

		if [ -n "$whitelist" ]; then
			logInfo 'Apply whitelist'
			for domain in $whitelist; do
				sed -e "/$domain/d" \
					-- "$blocklist" > "$blocklist.aux" \
					&& mv -f -- "$blocklist.aux" "$blocklist"
			done
		fi
	fi

	if [ -n "$blacklist" ]; then
		logInfo 'Apply blacklist'
		for domain in $blacklist; do
			printf -- '%s\n' "$domain" >> "$blocklist"
		done
	fi

	# This domain is used to check if hBlock is enabled
	printf -- '%s\n' 'hblock-check.molinero.xyz' >> "$blocklist"

	logInfo 'Sort entries'
	sort -- "$blocklist" | uniq | sed -e '/^$/d' > "$blocklist.aux" \
		&& mv -f -- "$blocklist.aux" "$blocklist"

	# Count blocked domains
	blocklistCount=$(wc -l -- "$blocklist" | cut -d' ' -f1)

	logInfo 'Apply format template'
	sed -e "s/$/\\t$(quoteSubst "$redirection")/" \
		-e "s/^\\(.*\\)\\t\\(.*\\)$/$template/" \
		-- "$blocklist" > "$blocklist.aux" \
		&& mv -f -- "$blocklist.aux" "$blocklist"

	# Define "C" variable for convenience
	C=$comment

	if [ "$output" != - ] && [ -f "$output" ]; then
		# Get custom section
		if [ -n "$C" ]; then
			logAction 'Reading custom section...'
			custom=$(sed -e "/^$C.*<custom>/,/^$C.*<\\/custom>/!d;/^$C.*<\\(\\/\\|\\)custom>/d" -- "$output")
		fi

		# Backup procedure
		if [ "$backup" = true ]; then
			logAction 'Backing up original file...'
			[ -z "$backupDir" ] && backupDir=$(dirname -- "$output")
			backupOutput="$backupDir/$(basename -- "$output").$(date +%s).bak"
			if touch -- "$backupOutput" >/dev/null 2>&1; then
				cp -af -- "$output" "$backupOutput"
			elif exists sudo; then
				sudo cp -af -- "$output" "$backupOutput"
			else
				logError "Cannot write '$backupOutput': permission denied"
				exit 1
			fi
		fi
	fi

	logAction 'Generating output file...'

	printOutputFile() {
		if [ -n "$C" ]; then
			printf -- '%s\n' "$(cat <<-EOF
				$C Author:          Héctor Molinero Fernández <hector@molinero.xyz>
				$C Repository:      https://github.com/hectorm/hblock
				$C Last updated:    $(date -u)
				$C Blocked domains: $blocklistCount
			EOF
			)"
		fi
		if [ -n "$header" ]; then
			if [ -n "$C" ]; then printf -- '\n%s\n' "$C <header>"; fi
			printf -- '%s\n' "$header"
			if [ -n "$C" ]; then printf -- '%s\n' "$C </header>"; fi
		fi
		if [ -n "$custom" ]; then
			if [ -n "$C" ]; then printf -- '\n%s\n' "$C <custom>"; fi
			printf -- '%s\n' "$custom"
			if [ -n "$C" ]; then printf -- '%s\n' "$C </custom>"; fi
		fi
		if [ -n "$blocklist" ]; then
			if [ -n "$C" ]; then printf -- '\n%s\n' "$C <blocklist>"; fi
			cat -- "$blocklist"
			if [ -n "$C" ]; then printf -- '%s\n' "$C </blocklist>"; fi
		fi
		if [ -n "$footer" ]; then
			if [ -n "$C" ]; then printf -- '\n%s\n' "$C <footer>"; fi
			printf -- '%s\n' "$footer"
			if [ -n "$C" ]; then printf -- '%s\n' "$C </footer>"; fi
		fi
	}

	# Print to stdout if the output value is equal to -
	if [ "$output" = - ]; then
		printOutputFile
	else
		if [ -d "$output" ]; then
			logError "Cannot write '$output': is a directory"
			exit 1
		elif touch -- "$output" >/dev/null 2>&1; then
			printOutputFile > "$output"
		elif exists sudo && exists tee; then
			printOutputFile | sudo tee -- "$output" >/dev/null
		else
			logError "Cannot write '$output': permission denied"
			exit 1
		fi
	fi

	logAction "$blocklistCount blocked domains!"
}

main "$@"
