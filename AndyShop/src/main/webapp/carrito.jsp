<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Carrito" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Carrito de Compras - AndyShops</title>
    <link rel="stylesheet" type="text/css" href="styles/styles.css">
</head>
<body>
    <header>
        <h1>Carrito de Compras</h1>
        <nav>
            <a href="index.jsp">Inicio</a>
            <a href="productos">Seguir Comprando</a>
        </nav>
    </header>

    <main>
        <h2>Productos en tu Carrito</h2>

        <%
            // Accediendo correctamente al carrito desde el request
            List<Carrito> productosCarrito = (List<Carrito>) request.getAttribute("productosCarrito");
            if (productosCarrito != null && !productosCarrito.isEmpty()) { // Verifica si la lista no es null ni vacía
        %>
            <table>
                <thead>
                    <tr>
                        <th>Producto</th>
                        <th>Descripción</th>
                        <th>Precio</th>
                        <th>Cantidad</th>
                        <th>Total</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        double total = 0.0;
                        for (Carrito productoCarrito : productosCarrito) {
                            double totalProducto = productoCarrito.getPrecio() * productoCarrito.getCantidad();
                            total += totalProducto;
                    %>
                    <tr>
                        <td><%= productoCarrito.getNombreProducto() %></td>
                        <td><%= productoCarrito.getDescripcionProducto() %></td>
                        <td><%= productoCarrito.getPrecio() %> $</td>
                        <td><%= productoCarrito.getCantidad() %></td>
                        <td><%= totalProducto %> $</td>
                        <td>
                            <form action="${pageContext.request.contextPath}/carrito" method="post">
						        <input type="hidden" name="productId" value="<%= productoCarrito.getIdProducto() %>">
						        <input type="hidden" name="method" value="removeFromCart"> <!-- Asegúrate de que el nombre y el valor sean correctos -->
						        <input type="submit" value="Eliminar">
    						</form>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>

          <h3>Total: <%= String.format("%.2f", total) %> $</h3> 
          
            <form action="${pageContext.request.contextPath}/carrito" method="post">
			    <input type="hidden" name="method" value="checkout"> <!-- Asegúrate de que el nombre y el valor sean correctos -->
			    <input type="hidden" name="totalCompra" value="<%= total %>">
			    <input type="submit" value="Proceder a la Compra">
			</form>
        <% } else { %>
            <h3>No se encontraron productos en tu carrito.</h3>
        <% } %>

    </main>
</body>
<footer>
        <p>&copy; 2023 AndyShop. Todos los derechos reservados.</p>
    </footer>
</html>
