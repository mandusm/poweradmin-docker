#!/bin/bash
sed -i 's/db_host = ''/\db_host = '$DB_HOST'/' /usr/share/nginx/html/inc/config.inc.php
sed -i 's/db_user = ''/\db_user = '$DB_USER'/' /usr/share/nginx/html/inc/config.inc.php
sed -i 's/db_pass = ''/\db_pass = '$DB_PASSWORD'/' /usr/share/nginx/html/inc/config.inc.php
sed -i 's/db_port = ''/\db_port = '$DB_PORT'/' /usr/share/nginx/html/inc/config.inc.php

/usr/sbin/nginx