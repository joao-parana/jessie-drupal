# jessie-drupal

jessie-drupal cria uma imagem para contêiner Docker com Drupal 8, WebServer Apache e PHP 5.6 sobre o Debian 8

Este projeto foi testado com a versão 1.8.2 do Docker

Para executar:

    docker run --name some-drupal --link some-mysql:mysql -d drupal

Váriáveis de ambiente:

    MYSQL_DATABASE
    MYSQL_USER
    MYSQL_PASSWORD


