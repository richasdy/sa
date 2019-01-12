less /etc/passwd
awk -F: '{ print $1}' /etc/passwd
cut -d: -f1 /etc/passwd
