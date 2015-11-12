# jessie-drupal

jessie-drupal cria uma imagem para contêiner Docker com Drupal 8, 
WebServer Apache e PHP 5.6 sobre o Debian 8

Este projeto foi testado com a versão 1.8.2 do Docker

Reiniciando o Boot2Docker

    boot2docker stop
    boot2docker start

Fazendo o Build

    docker build -t parana/jessie-drupal   . 

Verificando

    docker images | grep drupal

Para executar:

    docker run -d --name mysql_db -p 9306:3306 parana/mysql
    docker run --name mydrupal --link mysql_db:mysql -p 80:80 -d parana/jessie-drupal
    open http://dockerhost.local
    docker exec -i-t mysql_db /bin/bash

Váriáveis de ambiente:

    MYSQL_DATABASE
    MYSQL_USER
    MYSQL_PASSWORD

Contêiner mysql

    CREATE DATABASE: my-db 
    CREATE USER: wp
    IDENTIFIED BY: secret
