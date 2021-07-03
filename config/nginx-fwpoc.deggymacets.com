server {

	server_name fwpoc.deggymacets.com;

	root /var/www/fwpoc.deggymacets.com;
	index index.html;

	location / {
		try_files $uri $uri/ =404;
	}

    listen [::]:443 ssl; # managed by Certbot
    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/fwpoc.deggymacets.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/fwpoc.deggymacets.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}
server {
    if ($host = fwpoc.deggymacets.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


	listen 80;
	listen [::]:80;

	server_name fwpoc.deggymacets.com;
    return 404; # managed by Certbot


}