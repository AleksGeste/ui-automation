#!/usr/bin/env bash

# Read input variables
COMPONENT=$1
STATUS=$2

echo $STATUS

# Default message
MESSAGE=""$COMPONENT" failed :no_entry:"
if [ $STATUS = 0 ]; then
    MESSAGE=""$COMPONENT" passed :white_check_mark:"
fi

# Send notification
curl -X POST \
  # https://discordapp.com/api/webhooks/651765119101042689/JhoCn787dYW2s8c9CkqdYYizHTgUx9VT5pX65iCMfwYnC63C3Lc3tDGJsq0pnem3CD7B \
  # https://discordapp.com/api/webhooks/921929436314603531/JhoCn787dYW2s8c9CkqdYYizHTgUx9VT5pX65iCMfwYnC63C3Lc3tDGJsq0pnem3CD7B \
  https://discord.com/api/webhooks/921934267976663051/O2iAAxirYAZBLO7WWoq7uNrbMhtG94MAiyZhaM7Z-BrNVxEzRvLjahjT-OZsq2QC8Ffh \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -d '{
	"content":"'"$MESSAGE"'"
}'


# #!/bin/bash

# # update the TOKEN and the CHANNELID, rest is optional
# # you may need to connect with a websocket the first time you run the bot
# #   use a library like discord.py to do so

# curl -v \
# -H "Authorization: Bot OTIxOTMwMzE5MzI4ODU0MDg3.Yb6EhA.y1h2bV1yCBgxBiXZsYMIIruHRf4" \
# -H "User-Agent: myBotThing (http://some.url, v0.1)" \
# -H "Content-Type: application/json" \
# -X POST \
# -d '{"content":"Posting as a bot"}' \
# https://discordapp.com/api/channels/921934267976663051/messages