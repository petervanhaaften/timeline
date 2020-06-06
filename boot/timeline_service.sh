#!/bin/bash
echo ***waiting 2sec before timeline boot***
sleep 2
echo ***booting timeline supercollider global host***
sclang -D /home/asterisk/src/timeline/TL_global_host.scd &
#emacs /home/asterisk/Documents/notes/timeline_linux_jan30_march3update.org &
catia &
emacs /home/asterisk/Documents/notes/timeline_linux_jan30_june5.org &
#xfce4-terminal -e, 'bash -c "asterisk -rvvvvv"' &
xfce4-terminal -e, 'bash -c "htop"'
