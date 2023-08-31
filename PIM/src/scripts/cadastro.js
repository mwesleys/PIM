function generateUsername() {
    var nameInput = document.getElementById("name");
    var usernameInput = document.getElementById("username");
    var nameValue = nameInput.value;
    nameValue = nameValue.trim();
    var nameParts = nameValue.split(" ");
    if (nameParts.length > 1) {
        var firstName = nameParts[0];
        var lastName = nameParts[nameParts.length - 1];
        firstName = firstName.toLowerCase();
        lastName = lastName.replace(/\s/g, "").toLowerCase();
        var username = firstName + "." + lastName;
        usernameInput.value = username;
    }
}

function validateForm() {
    var passwordInput = document.getElementById("password");
    var passwordConfirmInput = document.getElementById("passwordconfirm");
    
    var password = passwordInput.value;
    var passwordConfirm = passwordConfirmInput.value;
    
    if (password !== passwordConfirm) {
        alert("As senhas não coincidem. Por favor, verifique novamente.");
        return false;
    }
    
    return true;
}

function validacaoEmail(field) {
    usuario = field.value.substring(0, field.value.indexOf("@"));
    dominio = field.value.substring(field.value.indexOf("@")+ 1, field.value.length);
    
    if ((usuario.length >=1) &&
        (dominio.length >=3) &&
        (usuario.search("@")==-1) &&
        (dominio.search("@")==-1) &&
        (usuario.search(" ")==-1) &&
        (dominio.search(" ")==-1) &&
        (dominio.search(".")!=-1) &&
        (dominio.indexOf(".") >=1)&&
        (dominio.lastIndexOf(".") < dominio.length - 1)) {
    document.getElementById("email").innerHTML="E-mail válido";
    alert("E-mail valido");
    }
    else{
    document.getElementById("msgemail").innerHTML="<font color='red'>E-mail inválido </font>";
    alert("E-mail invalido");
    }
}