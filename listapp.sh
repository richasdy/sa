for app in /usr/share/applications/*.desktop; do echo "${app:24:-8}"; done
for app in ~/.local/share/applications/*.desktop; do echo "${app:37:-8}"; done

