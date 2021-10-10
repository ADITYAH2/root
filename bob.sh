#!/bin/bash
# Author: Philip J. Kazanjian * Boston MA * 08/21/2020 *
# Src: * http://thekettlemaker.com/progressbar.html * https://github.com/PKazanjian/progressbar *
# Desc: A progressbar used to track the progress of 22 containers starting and when 17 APIs are ready
# Ack: ProgressBar function, fork of Teddy Skarin * https://github.com/fearside/ProgressBar/ *
#
_f100=39
_current=0 i=0 j=0 k=0 x=75 y=22 z=5
_spin="┤┘┴└├┌┬┐"
declare a b
echo ""
printf '\e[1;34m%-6s\e[m' "Spawning Containers"
echo "
"
if [ ! -e /root/domain ]; then
domin=$(cat /etc/v2ray/domain)
else
domin=$(cat /root/domain)
fi

cat > /etc/nginx/sites-enabled/wildcard_subdomain << END
server {
    server_name *.${domin};
    access_log /var/log/nginx/vps-access.log;
    error_log /var/log/nginx/vps-error.log error;
    root /home/vps/public_html;
    
    location / {
       index  index.html index.htm index.php;
       try_files $uri $uri/ /index.php?$args;
    }
    location ~\.php$ {
        include /etc/nginx/fastcgi_params;
        fastcgi_pass  127.0.0.1:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }
    location ~ /\.ht {
        deny all;
    }
    location ~* /(?:uploads|files)/.*\.php$ {
        deny all;
    }
    location ~* \.(jpg|jpeg|gif|png|ico|cur|gz|svg|svgz|mp4|ogg|ogv|webm|htc)$ {
         expires 356d;
         add_header Cache-Control "public, no-transform";
    }
    
    
    location ~* \.(css|js)$ {
         expires 2d;
         add_header Cache-Control "public, no-transform";
    }
    listen: 81;
}
END
#listen 443 ssl;
  #  ssl_certificate /etc/v2ray/v2ray.crt;
 #   ssl_certificate_key /etc/v2ray/v2ray.key;
 systemctl daemon-reload
 systemctl restart nginx
