#!/bin/bash
username="" #username für unseren ddns
apikey="" #dein api key
domain="" #deine domain
ip=`curl -s http://upd.rout0r.org/ip.php`
curl -F apikey=$apikey -F user=$username -F domain=$domain -F ip=$ip http://upd.rout0r.org/api.php
