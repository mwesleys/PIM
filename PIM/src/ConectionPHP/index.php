<?php
$login_cookie = $_COOKIE['login'];

if (isset($login_cookie)) {
    echo "Bem vindo";
    // Ler o conteúdo da página home.html
    $conteudo = file_get_contents('../pages/home.html');
    // Imprimir o conteúdo na página
    echo $conteudo;
} else {
    echo "Bloqueadooooo";
}
?>