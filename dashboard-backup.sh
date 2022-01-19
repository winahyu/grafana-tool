#!/bin/sh

KEY="your_grafana_key"
HOST="your_grafana_host"

for dash in $(curl --silent -k -H "Authorization: Bearer $KEY" $HOST/api/search\?query\=\& |tr ']' '\n' 2>&1 | grep -v dash-folder | grep uid | awk -F 'uid":"' '{print $2}' | awk -F '","' '{print $1}');
do
   title=$(curl -k --silent -H "Authorization: Bearer $KEY" $HOST/api/dashboards/uid/$dash | jq . | grep slug | awk -F ": \"" '{print $2}' | sed  "s/\",//g")   
   curl -k -H "Authorization: Bearer $KEY" $HOST/api/dashboards/uid/$dash > $title.json
done
