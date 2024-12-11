<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Carrito" %> 
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Compra Exitosa</title>
    <link rel="stylesheet" type="text/css" href="styles/styles.css">
</head>
<body>
    <header>
        <h1>¡Compra Exitosa!</h1>
    </header>
    <main>
        <h2>Factura de Compra</h2>
        <p><strong>Nombre del Cliente:</strong> <%= session.getAttribute("nombreCliente").toString() %></p>
        <h3>Productos Comprados:</h3>
        <ul>
            <%
            List<Carrito> productosComprados = (List<Carrito>) request.getAttribute("productosComprados");
            if (productosComprados != null && !productosComprados.isEmpty()) { // Verifica si la lista no es null ni vacía
            	for (Carrito productoComprado : productosComprados) {
            %>
                <li><%= productoComprado.getNombreProducto() %>    -    Precio: <%= productoComprado.getPrecio() %>     -    Cantidad: <%= productoComprado.getCantidad()%> </li>
            <%
                }
            %>
        </ul>
        <p><strong>Total de la Compra:</strong> <%= String.format("%.2f", session.getAttribute("totalCompra"))%></p>
        <p>Gracias por tu compra.</p>
        <% } else { %>
            <h3>No se encontraron productos en tu carrito.</h3>
        <% } %>
        </p>
        <a href="productos" class="button">Volver a la tienda</a>

    </main>
</body>
<footer>
        <p>&copy; 2023 AndyShop. Todos los derechos reservados.</p>
    </footer>
</html>