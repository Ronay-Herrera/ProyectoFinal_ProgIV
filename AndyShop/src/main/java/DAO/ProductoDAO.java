package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import database.DatabaseConnection;
import modelo.Producto;

public class ProductoDAO {
	private static final Logger logger = Logger.getLogger(CarritoDAO.class.getName());

    public List<Producto> getAllProducts(String filtro) throws SQLException {
    	
        List<Producto> productos = new ArrayList<>();
        String query = "EXEC usp_verproductosfiltrados @filtro = ?";

        // Usar try-with-resources para manejar automáticamente el cierre de recursos
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
        		statement.setString(1, filtro);
             ResultSet resultSet = statement.executeQuery();
             
            while (resultSet.next()) {
                Producto producto = new Producto(
                    resultSet.getInt("id_producto"),
                    resultSet.getString("nombre_producto"),
                    resultSet.getString("descripcion"),
                    resultSet.getDouble("precio"),
                    resultSet.getInt("stock"),
                    resultSet.getString("categoria")
                );
                productos.add(producto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }

        return productos;
    }
    
 // Método para agregar un producto al carrito
    public void addProductToCart(int idUsuario, int productoId) throws SQLException {
        String query = "EXEC usp_agregarProductoAlCarrito @Idusuario = ?, @Idproducto = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, idUsuario);
            statement.setInt(2, productoId);

            statement.executeUpdate();
        } catch (SQLException e){
            logger.log(Level.SEVERE, "Error adding product to cart for user ID: " + idUsuario, e);
            throw e; // Relanzar la excepción para que sea manejada en el método que llama
        }
    }
    
 // Método para actualizar la cantidad de un producto en el carrito
    public void updateProductQuantity(int productId) throws SQLException {
        String query = "EXEC usp_actualizarCantidadProducto @id_producto = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, productId);

            statement.executeUpdate();
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error updating product quantity", e);
            throw e; // Relanzar la excepción para que sea manejada en el método que llama
        }
    }
}