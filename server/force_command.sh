#force a command for everyone
userid=`id -u`

#only for root or real users
if [ $userid -lt 1000 ] && [ $userid -gt 0 ]; then
	return
fi
declare cur_time=`date +%s`
function show_note() {
	if [[ $cur_time -lt "$(expr `date +%s`-3600)" ]]; then #every 60 minutes show the message
		if [ which task &> /dev/null] && [ -e ~/.taskrc ]; then
			echo "Du hast `task count` Aufgaben."
		fi
		export cur_time=`date +%s`
	fi
}
#declare it read only to prevent changing
declare -r PROMPT_COMMAND="show_note"

if [[ -n "${ZSH_VERSION}" ]]; then
	function precmd() {
		eval "$PROMPT_COMMAND"
	}
fi
