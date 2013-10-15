#!/bin/bash
api_key=""
curl -F key=$api_key -F file=@$1 http://dl.rout0r.org/sec/api.php
