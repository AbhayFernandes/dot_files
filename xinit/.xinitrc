~/.screenlayout/screenlayout.sh 
~/.fehbg &
wal -R &
$(sleep 4s && "$HOME/launch-polybar.sh") &
picom --experimental-backend -b &
dwm 

