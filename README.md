# jessie-drupal

jessie-drupal cria uma imagem para contêiner Docker com Drupal 8, 
WebServer Apache e PHP 5.6 sobre o Debian 8

Este projeto foi testado com a versão 1.8.2 do Docker

Reiniciando o Boot2Docker

    boot2docker stop
    boot2docker start

Fazendo o Build

    docker build -t parana/jessie-drupal . 

Verificando

    docker images | grep drupal

Para executar:

    docker run -d --name mysql_db -p 9306:3306 parana/mysql
    docker run --name mydrupal \
           --link mysql_db:mysql \
           -d -p 80:80
           parana/jessie-drupal
    open http://dockerhost.local
    # Opcionalmente podemos entrar numa seção Bash 
    # do contêiner mysql_db
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

Após iniciar o conteiner MySQL `mysql_db` e o contêiner Drupal 8 `mydrupal` 
podemos abrir no Browser a pagina [http://dockerhost.local](http://dockerhost.local) 
assumindo que `dockerhost.local` está apontando corretamente para o Computador
host rodando o Docker que pode ser uma maquina Virtual, no caso do MAC OSX e Windows
ou `localhost` no caso do Linux.

Abaixo aparecem as telas típicas desse processo.

Inicialmente devemos __Escolher o Idioma__

![Escolhendo o Idioma](https://raw.githubusercontent.com/joao-parana/jessie-drupal/master/docs/img/drupal-install-01.png)

Pode ocorrer __problema de rede__

![Problema de Rede](https://raw.githubusercontent.com/joao-parana/jessie-drupal/master/docs/img/drupal-install-02.png)

Resolvendo eventuais problemas de rede podemos __Escolhendo o Perfil de Instalação__

![Escolhendo o Perfil de Instalação](https://raw.githubusercontent.com/joao-parana/jessie-drupal/master/docs/img/drupal-install-03.png)

E em seguida __Configurar o Database__

![Configuração do Database](https://raw.githubusercontent.com/joao-parana/jessie-drupal/master/docs/img/drupal-install-04.png)

Pode ocorrer erro na Configuração do Database relacionados a endereçamento IP.

![Erro no Database](https://raw.githubusercontent.com/joao-parana/jessie-drupal/master/docs/img/drupal-install-05.png)

Assim __verificamos o IP__ do Contêiner que está rodando o contêiner MySQL. 
Obviamente podemos também usar nome de host em vez de endereço IP. Neste caso 
o nome do host em questão é `mysql_db` definido via parâmetro 
`--link mysql_db:mysql` quando invocamos o contêiner.

![Verificando o endereço IP](https://raw.githubusercontent.com/joao-parana/jessie-drupal/master/docs/img/drupal-install-00.png)

Agora podemos __Configurar o Database Corretamente__

![Configuração do Database Corretamente](https://raw.githubusercontent.com/joao-parana/jessie-drupal/master/docs/img/drupal-install-06.png)

E __Instalar o Drupal__ 

![Instalando ...](https://raw.githubusercontent.com/joao-parana/jessie-drupal/master/docs/img/drupal-install-07.png)

Que pede os dados de __Configuração do Site__

![Configuração do Site](https://raw.githubusercontent.com/joao-parana/jessie-drupal/master/docs/img/drupal-install-08.png)

![Configuração do Site - Continuação ](https://raw.githubusercontent.com/joao-parana/jessie-drupal/master/docs/img/drupal-install-09.png)

Finalmente temos a tela de confirmação : __Bemvindo ao Site Drupal 8__
![Bemvindo ao Site Drupal 8](https://raw.githubusercontent.com/joao-parana/jessie-drupal/master/docs/img/drupal-install-10.png)

### Instalando à partir de um Instalation Profile

Podemos escolher o **Perfil de Instalação** desejado. Neste caso escolhi o **Panopoly**.

![Escolhendo o Perfil de Instalação](https://raw.githubusercontent.com/joao-parana/jessie-drupal/master/docs/img/drupal-install-11.png)

Assim teremos três novos modulos do Framework Panopoly além dos módulos dos quais ele depende.

![https://raw.githubusercontent.com/joao-parana/jessie-drupal/master/docs/img/drupal-install-12.png](https://raw.githubusercontent.com/joao-parana/jessie-drupal/master/docs/img/drupal-install-12.png)

#### Funcionalidade do Panopoly

* Panopoly Foundation
  - panopoly_core
* panopoly_images
  - panopoly_theme
* panopoly_magic
  - panopoly_widgets

## Usando o Drupal Console

Como pode ser observado no Dockerfile, o Drupal Console é instalado 

Para executá-lo faça:
    
    docker exec -i-t  mydrupal /bin/bash

Isso permite que executemos dentro do Contêiner, comandos como este abaixo:

    drupal help site:install
    # Instalando o site via Drupal Console        
    drupal site:install \
              --db-type="mysql" \
              --db-host="mysql_db" \
              --db-name="my-db" \
              --db-user="wp" \
              --db-pass="secret" \
              --db-prefix="d8_" \
              --db-port=3306 \
              --langcode="en" \
              --site-name="Meu Site Drupal 8" \
              --site-mail="joao.parana@gmail.com" \
              --account-name="admin" \
              --account-mail="joao.parana@gmail.com" \
              --account-pass="drupal8admin" "panopoly"  
    drupal site:status

## Links úteis

[Playlist DrupalCon 2015 - Barcelona](https://www.youtube.com/playlist?list=PLpeDXSh4nHjR26Dheb6U1NUSp0aACYGvE)

Para entender a arquitetura do Drupal8:

[Drupal 8 & Symfony](https://www.youtube.com/watch?v=8vwC_01KFLo)
e
[projeto associado no Github](https://github.com/palantirnet/hugs)

## Resolução de Problemas

Atualmente o comando `drupal site:install` do __Drupal Console__ não instala
o Site como especificado se usamos `--langcode="pt_BR"`. Quando usamos 
`--langcode="en"` o __Drupal Console__ instala o Site porém ao tentar usá-lo 
o Apache gera erro 500 e retorna o HTML mostrado abaixo:

    <html>
      <head>
      </head>
      <body>
        The website encountered an unexpected error. 
        Please try again later.
      </body>
    </html>

E no Log do PHP `/var/log/php/php-scripts.log` vemos:

    Uncaught PHP Exception InvalidArgumentException: "No check has been registered for access_check.user.login_status" at /var/www/html/core/lib/Drupal/Core/Access/CheckProvider.php line 99

Desta forma comentei o comando correspondente na Shell `install-or-run-drupal8` 
té que o  __Drupal Console__ esteja mais estável.

Assim é preciso instalar como anteriormente, ou seja, navegando pelo Browser 
interativamente usando `open http://dockerhost.local` e informando os 
parâmetros como necessário.
