#!/bin/bash
echo ***waiting 2sec before timeline boot***
sleep 2
echo ***booting timeline supercollider global host***
sclang -D /home/asterisk/src/timeline/TL_global_host.scd &
#emacs /home/asterisk/Documents/notes/timeline_linux_jan30_march3update.org &
catia
# T7#T7sleep 10
#env -u SESSION_MANAGER -u DBUS_SESSION_BUS_ADDRESS vncserver -geometry 1600x1050
