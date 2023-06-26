#!/bin/bash
cd /root/src
curl -O https://install.phpcomposer.com/composer.phar
mv composer.phar /usr/local/bin/composer
chmod +x /usr/local/bin/composer