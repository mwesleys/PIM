<?php
$username = $_POST['username'];
$password = $_POST['password'];

try {
    $conn = new PDO('mysql:host=localhost;dbname=bomae', 'root', '', array(PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8"));
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    echo "Erro na conexão com o banco de dados: " . $e->getMessage();
    exit();
}

if (isset($_POST['entrar'])) {
    $query = "SELECT * FROM usuarios WHERE login = :login";
    $stmt = $conn->prepare($query);
    $stmt->bindParam(':login', $username);

    try {
        $stmt->execute();
        $result = $stmt->fetch();

        if ($result === false || !password_verify($password, $result['senha'])) {
            echo "<script language='javascript' type='text/javascript'>
                alert('Login e/ou senha incorretos');window.location
                .href='login.html';</script>";
            exit();
        } else {
            setcookie("login", $username);
            header("Location: index.php");
            exit();
        }
    } catch (PDOException $e) {
        echo "Erro ao executar a consulta: " . $e->getMessage();
        exit();
    }
}
?>