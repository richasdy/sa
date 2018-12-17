# tools to check internet usage
ifconfig
# cli
sudo apt-get install vnstat
vnsatat -i wlp2s0

# show usage in daily basis
watch -n 5 --differences vnstat -d wlp2s0 # kok error
watch -n 5 --differences vnstat -i wlp2s0

# interactive view, wih pie chart
sudo apt-get install vnstati 
vnstati -vs -i wlp2s0 -o ~/bandwidth_statistics.png 
