# Check if waybar-disabled file exists
if [ -f $HOME/.cache/waybar-disabled ] ;then 
    killall waybar
    pkill waybar
    exit 1 
fi

# ----------------------------------------------------- 
# Quit all running waybar instances
# ----------------------------------------------------- 
killall waybar
pkill waybar
sleep 0.2

# ----------------------------------------------------- 
# Loading the configuration
# ----------------------------------------------------- 
config_file="config.jsonc"
style_file="style.css"

# Standard files can be overwritten with an existing config-custom or style-custom.css
if [ -f ~/dotfiles/waybar/themes${arrThemes[0]}/config-custom ] ;then
    config_file="config-custom"
fi
if [ -f ~/dotfiles/waybar/themes${arrThemes[1]}/style-custom.css ] ;then
    style_file="style-custom.css"
fi

waybar -c ~/dotfiles/waybar/$config_file -s ~/dotfiles/waybar/$style_file &
