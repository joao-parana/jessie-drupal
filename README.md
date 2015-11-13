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


## Passo a passo da configuração

![Escolhendo o Idioma](https://raw.githubusercontent.com/joao-parana/jessie-drupal/master/docs/img/drupal-install-01.png)

![Problema de Rede](https://raw.githubusercontent.com/joao-parana/jessie-drupal/master/docs/img/drupal-install-02.png)

![Escolhendo o Perfil de Instalação](https://raw.githubusercontent.com/joao-parana/jessie-drupal/master/docs/img/drupal-install-03.png)

![Configuração do Database](https://raw.githubusercontent.com/joao-parana/jessie-drupal/master/docs/img/drupal-install-04.png)

![Erro no Database](https://raw.githubusercontent.com/joao-parana/jessie-drupal/master/docs/img/drupal-install-05.png)

![Verificando o endereço IP](https://raw.githubusercontent.com/joao-parana/jessie-drupal/master/docs/img/drupal-install-00.png)

![Configuração do Database Corretamente](https://raw.githubusercontent.com/joao-parana/jessie-drupal/master/docs/img/drupal-install-06.png)

![Instalando ...](https://raw.githubusercontent.com/joao-parana/jessie-drupal/master/docs/img/drupal-install-07.png)

![Configuração do Site](https://raw.githubusercontent.com/joao-parana/jessie-drupal/master/docs/img/drupal-install-08.png)

![Configuração do Site - Continuação ](https://raw.githubusercontent.com/joao-parana/jessie-drupal/master/docs/img/drupal-install-09.png)

![Bemvindo ao Site Drupal 8](https://raw.githubusercontent.com/joao-parana/jessie-drupal/master/docs/img/drupal-install-10.png)
