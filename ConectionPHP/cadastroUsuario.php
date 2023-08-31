<?php
require_once 'pdoconfig.php';
 // Nome do banco de dados

try {
    $conn = new PDO("mysql:host=localhost;dbname=bomae", "root", "");
    // Configura o modo de erro do PDO para exceções
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    echo "Conexão bem-sucedida.";
} catch(PDOException $e) {
    echo "Falha na conexão: " . $e->getMessage();
}

function cadastrarUsuario($username, $password, $email, $nome)
{
    global $conn;
    try {
        // Verifica se o usuário já existe
        $query = "SELECT * FROM usuarios WHERE login = :login";
        $stmt = $conn->prepare($query);
        $stmt->bindParam(':login', $username);
        $stmt->execute();

        if ($stmt->rowCount() > 0) {
            echo "Usuário já existe.";
            return false;
        }

        $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

        // Insere o novo usuário no banco de dados
        $query = "INSERT INTO usuarios (login, senha, email, nome) VALUES (:login, :senha, :email, :nome)";
        $stmt = $conn->prepare($query);
        $stmt->bindParam(':login', $username);
        $stmt->bindParam(':senha', $hashedPassword);
        $stmt->bindParam(':email', $email);
        $stmt->bindParam(':nome', $nome);
        $stmt->execute();

        echo "Usuário cadastrado com sucesso.";
        return true;
    } catch (PDOException $e) {
        echo "Erro ao cadastrar usuário: " . $e->getMessage();
        return false;
    }
}

function estaLogado()
{
    // Inicia a sessão
    session_start();
    // Verifica se a variável de sessão "logged_in" está definida e é verdadeira
    if (isset($_SESSION['logged_in']) && $_SESSION['logged_in'] === true) {
        return true;
    } else {
        return false;
    }
}

if (isset($_POST['cadastrar'])) {
    if (estaLogado()) {
        $username = $_POST['username'];
        $password = $_POST['password'];
        $email = $_POST['email'];
        $nome = $_POST['nome'];

        cadastrarUsuario($username, $password, $email, $nome);
    } else {
        echo "Apenas usuários autenticados podem cadastrar novos usuários.";
    }
}
?>
