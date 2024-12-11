package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import database.DatabaseConnection;
import modelo.Carrito;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CarritoDAO {
    private static final Logger logger = Logger.getLogger(CarritoDAO.class.getName());

    public List<Carrito> getAllProducts(int idUsuario) throws SQLException {
        List<Carrito> productosCarrito = new ArrayList<>();
        String query = "EXEC usp_verCarritoDetalles @Idusuario = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, idUsuario);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Carrito productoCarrito = new Carrito(
                        resultSet.getInt("id_carrito"),
                        resultSet.getInt("id_producto"),
                        resultSet.getString("fecha_creacion"),
                        resultSet.getString("nombre_producto"),
                        resultSet.getString("descripcion_producto"),
                        resultSet.getDouble("precio"),
                        resultSet.getInt("cantidad")
                    );
                    productosCarrito.add(productoCarrito);
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving cart products for user ID: " + idUsuario, e);
            throw e; // Relanzar la excepción para que sea manejada en el método que llama
        }

        return productosCarrito;
    }

    

    // Método para eliminar un producto del carrito
    public void removeProductFromCart(int idUsuario, int productId) throws SQLException {
        String query = "EXEC usp_eliminarProductoDelCarrito @Idusuario = ?, @id_producto = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
        	
            statement.setInt(1, idUsuario);
            statement.setInt(2, productId);
            
         // Log para ver los valores antes de ejecutar la consulta
            System.out.println("Ejecutando consulta con idUsuario: " + idUsuario + " y productId: " + productId);

            statement.executeUpdate();
            System.out.println("Consulta exitosa");
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error removing product from cart for user ID: " + idUsuario, e);
            System.out.println("Consulta fallida");
            throw e; // Relanzar la excepción para que sea manejada en el método que llama
        }
    }
    
    public void checkout(int idUsuario) throws SQLException {
    	String query = "EXEC usp_RegistrarCompra @id_usuario = ?";
    	
    	try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(query)) {

               statement.setInt(1, idUsuario);
               System.out.println("Ejecutando consulta con idUsuario: " + idUsuario);
               statement.executeUpdate();
               System.out.println("Consulta exitosa");
           } catch (SQLException e) {
               logger.log(Level.SEVERE, "Error handling purchase for user ID:" + idUsuario, e);
               System.out.println("Consulta fallida");
               throw e; // Relanzar la excepción para que sea manejada en el método que llama
           }
    }

    
}