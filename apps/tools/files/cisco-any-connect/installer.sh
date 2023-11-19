#!/bin/sh

curl -L -o ~/Downloads/cisco-any-connect.dmg  "https://uci.service-now.com/sys_attachment.do?sys_id=7cd4a94b1b2179546d7bb99f034bcb93"

any_connect_volume=$(hdiutil attach ~/Downloads/cisco-any-connect.dmg | grep /Volumes | tr -s ' ' | awk -F '[ ]' '{print $3 " " $4}' | xargs)

sudo installer -pkg "$any_connect_volume/AnyConnect.pkg" -applyChoiceChangesXML $@ -target /

hdiutil detach "$any_connect_volume"

rm ~/Downloads/cisco-any-connect.dmg