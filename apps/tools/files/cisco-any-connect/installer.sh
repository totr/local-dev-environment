#!/bin/sh

curl -L -o ~/Downloads/cisco-any-connect.dmg  "https://vc.vscht.cz/files/uzel/0026707/0006~~S8yrTM7Py0tNLtHNTUzOL9Y10TM00DMwNzAz1C0oSk1JLcjJr9TNtgQA.dmg?redirected"

any_connect_volume=$(hdiutil attach ~/Downloads/cisco-any-connect.dmg | grep /Volumes | tr -s ' ' | awk -F '[ ]' '{print $3 " " $4}' | xargs)

sudo installer -pkg "$any_connect_volume/AnyConnect.pkg" -applyChoiceChangesXML $@ -target /

hdiutil detach "$any_connect_volume"

rm ~/Downloads/cisco-any-connect.dmg