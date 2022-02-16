#!/bin/bash
#echo ***waiting 2sec before timeline boot***
#echo ***booting timeline supercollider global host***
#emacs /home/asterisk/Documents/notes/timeline_linux_jan30_march3update.org &
cadence &
sleep 5
catia &
sleep 5
echo | xfce4-terminal --tab --command "sclang /home/asterisk/src/timeline/startup_files/newstartup1.scd -u 57121" --hold --tab --command "sclang /home/asterisk/src/timeline/startup_files/newstartup2.scd -u 57122" --hold --tab --command "sclang /home/asterisk/src/timeline/startup_files/newstartup3.scd -u 57123" --hold

#firefox &
#emacs /home/asterisk/Documents/notes/timeline_linux_jan30_june5.org &
# sclang -D /home/asterisk/src/timeline/TL_global_host.scd &
#scide /home/asterisk/src/timeline/TL_global_host.scd &
#xfce4-terminal -e, 'bash -c "asterisk -rvvvvv"'
# xfce4-terminal -e, 'bash -c "htop"'
#define which workspace applications load onto
#xfce4-terminal -e, 'bash -c "wmctrl -r firefox -t 2"'
#xfce4-terminal -e, 'bash -c "wmctrl -r scide -t 1"' &

