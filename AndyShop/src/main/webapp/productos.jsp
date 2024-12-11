<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Producto" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Productos - AndyShops</title>
    <link rel="stylesheet" type="text/css" href="styles/styles.css">
</head>
<body>
    <header>
        <h1>Productos</h1>
        <nav>
            <a href="index.jsp">Inicio</a>
            <a href="carrito">Carrito</a>
        </nav>
    </header>
    <main>
        <h2>Lista de Productos</h2>
         <form action="${pageContext.request.contextPath}/productos" method="post">
        <label for="filtro">Selecciona una opción:</label>
        <select id="filtro" name="filtro">
            <option value="nombre_producto">Nombre</option>
            <option value="precio">Precio</option>
            <option value="stock">Stock</option>
            <option value="categoria">Categoría</option>
        </select>
        <input type="hidden" name="method" value="filtrarProductos"> 
        <button type="submit">Filtrar</button>
    </form>
        <table>
            <tr>
                <th>Nombre</th>
                <th>Descripción</th>
                <th>Precio</th>
                <th>Stock</th>
                <th>Categoría</th>
                <th>Acción</th>
            </tr>
            <%
                List<Producto> productos = (List<Producto>) request.getAttribute("productos");
                if (productos != null && !productos.isEmpty()) { // Verifica si la lista no es null ni vacía
                    for (Producto producto : productos) {
            %>
            <tr>
                <td><%= producto.getName() %></td>
                <td><%= producto.getDescription() %></td>
                <td><%= producto.getPrice() %></td>
                <td><%= producto.getStock() %></td>
                <td><%= producto.getCategory() %></td>
                <td>
				    <form action="${pageContext.request.contextPath}/productos" method="post">
				        <input type="hidden" name="method" value="agregarProducto"> 
				        <input type="hidden" name="productoId" value="<%= producto.getId() %>"> 
				        <input type="submit" value="Añadir al Carrito">
				    </form>
				</td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="5">No se encontraron productos.</td> <!-- Mensaje si no hay productos -->
            </tr>
            <%
                }
            %>
        </table>
    </main>
</body>
<footer>
        <p>&copy; 2023 AndyShop. Todos los derechos reservados.</p>
    </footer>
</html>
