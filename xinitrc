#export GDK_BACKEND=x11
#export XDG_CURRENT_DESKTOP=GNOME-Flashback:GNOME
#exec gnome-session --session=gnome-flashback-compiz


#[ -f ~/.xprofile ] && source ~/.xprofile
#exec gnome-session --session=gnome-flashback-metacity
#exec openbox-session
#exec gnome-session
#exec startx
#exec dbus-launch --sh-syntax --exit-with-session fusion-icon
#exec fusion-icon
#exec ck-launch-session dbus-launch --sh-syntax --exit-with-session compiz ccp
#exec fusion-icon
exec i3

