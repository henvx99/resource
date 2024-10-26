#!/system/bin/sh
if [ "$(basename "$0")" != "arm64" ]; then
	exit 1
fi

source /storage/emulated/0/VortexModules/webxit/webroot/resource/arm64/input/calibrar.dex

RemoveListerOne() {
    wm size reset
    sleep 1
    wm density 406
}

sensivityOne() {
    am force-stop com.dts.freefireth
    am force-stop com.dts.freefiremax
    sleep 0.8
    wm size 1799x3998
    wm density reset
}

exec 1>/dev/null
exec 2>/dev/null

prev_window_state=""
game_running=""

cmd="cmd notification post -S bigtext -t \"Sensitivity Aim Enhancer\" \"Tag\" \"Version: WEBXIT | Author: Henpeex\""
eval "$cmd"

while true; do
	window_buffer=$(dumpsys window | grep -E 'mCurrentFocus|mFocusedApp' | grep -Eo 'com.dts.freefireth|com.dts.freefiremax')

	if [ -n "$window_buffer" ]; then
		if [ "$prev_window_state" != "active" ]; then
			game_running="open"
			sensivityOne
			wm density "$size"

			cmd="cmd notification post -S bigtext -t \"Sensitivity Aim Enhancer\" \"Tag\" \"Process enhancer something\""
			eval "$cmd"
			sleep 2

			cmd="pgrep -f 'com.dts.freefireth|com.dts.freefiremax'"
			pids=$(eval "$cmd")

			for pid in $pids; do
				t_priorities "$pid"
				sleep 0.7
			done

			cmd="cmd notification post -S bigtext -t \"Sensitivity Aim Enhancer\" \"Tag\" \"Successfully enhancer mode\""
			eval "$cmd"

		fi
		prev_window_state="active"
	else
		if [ "$game_running" = "open" ]; then
		
			proc_buffer=$(pgrep -f 'com.dts.freefireth|com.dts.freefiremax')

			if [ -z "$proc_buffer" ]; then
				game_running=""
				cmd="cmd notification post -S bigtext -t \"Sensitivity Aim Enhancer\" \"Tag\" \"Game Closed\""
				eval "$cmd"
                sleep 1 
				RemoveListerOne
			fi
		fi
		prev_window_state=""
	fi
	sleep 5
done
