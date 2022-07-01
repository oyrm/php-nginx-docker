# nginx-php-docker
nginx & php Dockerfile （RockyLinux）

`docker build -t oyrming/php8.1-nginx:1.0.0 -f ./Dockerfile_php8.1 --no-cache .`

`docker system prune --volumes`

`docker run --name php8.1 -p 80:80 -v d:/php-dev/wwwroot:/data/wwwroot -v d:/php-dev/wwwlogs:/data/wwwlogs -v d:/php-dev/nginx/vhost:/data/server/nginx/vhost -d oyrming/php8.1-nginx:1.0.0
`