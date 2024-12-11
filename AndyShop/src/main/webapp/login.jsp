<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Iniciar Sesión - AndyShops</title>
    <link rel="stylesheet" type="text/css" href="styles/styles.css">
</head>
<body>
    <header>
        <h1>Iniciar Sesión</h1>
    </header>
    <main>
        <form action="${pageContext.request.contextPath}/login" method="post">
            <label for="email">Correo Electrónico:</label>
            <input type="email" id="email" name="email" required>
            <br>
            <label for="password">Contraseña:</label>
            <input type="password" id="password" name="password" required>
            <br>
            <input type="submit" value="Iniciar Sesión">
        </form>
    </main>
</body>
<footer>
        <p>&copy; 2023 AndyShop. Todos los derechos reservados.</p>
    </footer>
</html>
