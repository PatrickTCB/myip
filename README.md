# My IP
This is a quick little container that just gives out your IP.

It assumes that it'll be sitting behind an nginx reverse proxy. Here's an example config that'll work.
```
server {
    server_name example.server.app;

    location / {
        proxy_pass http://localhost:8083;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    listen 443 ssl; # managed by Certbot
    client_max_body_size 2G;
    ssl_certificate /etc/letsencrypt/live/example.server.app/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/example.server.app/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}
server {
    if ($host = example.server.app) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80;
    server_name example.server.app;
    return 404;
}
```
The important thing to matchup here is X-Real-IP and then in the PHP file `echo $_SERVER['HTTP_X_REAL_IP'];`. 
You can't always trust someones remote IP, but I don't actually care about that. But that's not the point of this app. This lets you know what the server thinks your IP is, and that's always enough for me when I'm debugging. 