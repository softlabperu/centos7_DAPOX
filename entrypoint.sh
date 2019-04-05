#!/usr/bin/env bash
set -e

echo '[xdebug]
zend_extension="/usr/lib64/php/modules/xdebug.so"
xdebug.remote_host=172.10.0.1
xdebug.idekey=PHPSTORM
xdebug.remote_enable=on
xdebug.remote_autostart=on
xdebug.remote_connect_back=off
xdebug.remote_handler=dbgp
xdebug.profiler_enable=0
xdebug.profiler_output_dir="/var/www/html"
xdebug.remote_port=9000' >> /etc/php.d/xdebug.ini

# Optional Config
# sed -i "s/memory_limit\ =\ 128M/memory_limit\ =\ 256M/g" /etc/php.ini
# sed -i "s/max_input_time\ =\ 60/max_input_time\ =\ 600/g" /etc/php.ini
# sed -i "s/;\ max_input_vars\ =\ 1000/max_input_vars\ =\ 1000000/g" /etc/php.ini

systemctl enable httpd.service

exec "$@"
