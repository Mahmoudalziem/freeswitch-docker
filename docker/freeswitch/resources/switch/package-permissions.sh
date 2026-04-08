#default permissions
chown -R www-data:www-data /etc/freeswitch
chown -R www-data:www-data /var/lib/freeswitch
chown -R www-data:www-data /usr/share/freeswitch
chown -R www-data:www-data /var/log/freeswitch
chown -R www-data:www-data /var/run/freeswitch
chown -R www-data:www-data /usr/local/freeswitch
chown -R www-data:www-data /usr/local/freeswitch/run
mkdir -p /usr/local/freeswitch/run
chown -R www-data:www-data /usr/local/freeswitch/run


find /etc/freeswitch -type d -exec chmod 770 {} \;
find /var/lib/freeswitch -type d -exec chmod 770 {} \;
find /var/log/freeswitch -type d -exec chmod 770 {} \;
find /usr/share/freeswitch -type d -exec chmod 770 {} \;
find /etc/freeswitch -type f -exec chmod 664 {} \;
find /var/lib/freeswitch -type f -exec chmod 664 {} \;
find /var/log/freeswitch -type f -exec chmod 664 {} \;
find /usr/share/freeswitch -type f -exec chmod 664 {} \;

#update xml_cdr url, user and password
# xml_cdr_username=$(dd if=/dev/urandom bs=1 count=12 2>/dev/null | base64 | sed 's/[=\+//]//g')
# xml_cdr_password=$(dd if=/dev/urandom bs=1 count=12 2>/dev/null | base64 | sed 's/[=\+//]//g')
# sed -i /etc/freeswitch/autoload_configs/xml_cdr.conf.xml -e s:"{v_http_protocol}:http:"
# sed -i /etc/freeswitch/autoload_configs/xml_cdr.conf.xml -e s:"{domain_name}:127.0.0.1:"
# sed -i /etc/freeswitch/autoload_configs/xml_cdr.conf.xml -e s:"{v_project_path}::"
# sed -i /etc/freeswitch/autoload_configs/xml_cdr.conf.xml -e s:"{v_user}:$xml_cdr_username:"
# sed -i /etc/freeswitch/autoload_configs/xml_cdr.conf.xml -e s:"{v_pass}:$xml_cdr_password:"
sed -i 's|<load module="mod_av"/>|<!-- <load module="mod_av"/> -->|' /etc/freeswitch/autoload_configs/modules.conf.xml
sed -i 's|<load module="mod_signalwire"/>|<!-- <load module="mod_signalwire"/> -->|' /etc/freeswitch/autoload_configs/modules.conf.xml
sed -i 's/value="::"/value="127.0.0.1"/g' /etc/freeswitch/autoload_configs/event_socket.conf.xml

