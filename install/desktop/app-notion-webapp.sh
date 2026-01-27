#!/bin/bash

# Create Notion web app
source $OMAKUB_PATH/defaults/bash/functions
web2app 'Notion' https://www.notion.so/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/notion.png
app2folder 'Notion.desktop' WebApps
