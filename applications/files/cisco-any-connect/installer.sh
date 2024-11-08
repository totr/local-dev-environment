#!/bin/sh

curl -L -o ~/Downloads/cisco-any-connect.dmg  "https://uci.service-now.com/sys_attachment.do?sys_id=d13f7d0c472d92908fd9485c416d43e7"

any_connect_volume=$(hdiutil attach ~/Downloads/cisco-any-connect.dmg | grep /Volumes | tr -s ' ' | awk -F '[ ]' '{print $3 " " $4 " " $5 " " $6}' | xargs)

sudo installer -pkg "$any_connect_volume/Cisco Secure Client.pkg" -applyChoiceChangesXML $@ -target /

hdiutil detach "$any_connect_volume"

rm ~/Downloads/cisco-any-connect.dmg