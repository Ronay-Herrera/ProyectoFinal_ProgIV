package controlador;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.InputMismatchException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.CarritoDAO;
import DAO.ProductoDAO;
import database.DatabaseConnection;
import modelo.Carrito;
import modelo.Producto;

public class ControladorProducto extends HttpServlet {
    private static final long serialVersionUID = -2523699235256645073L;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession();
        String action = request.getParameter("method");
        Object userId = session.getAttribute("id");
        
        
        
        
        

        if (action == null) {
        	System.out.println("Accion invalida.");
            response.sendRedirect("carrito"); // Redirige si no se recibe una acción válida
            return;
        }

        switch (action) {
        
            case "agregarProducto":
            	try {
            		int productoId = Integer.parseInt(request.getParameter("productoId"));
    				ProductoDAO productoDAO = new ProductoDAO();
    				productoDAO.addProductToCart(Integer.parseInt(userId.toString()), productoId);
    			} catch (NumberFormatException e) {
    				// TODO Auto-generated catch block
    				e.printStackTrace();
    			} catch (SQLException e) {
    				// TODO Auto-generated catch block
    				e.printStackTrace();
    			}
            	response.sendRedirect("productos");
                    break;
            case "filtrarProductos":
            	try {
            		String filtro = request.getParameter("filtro");
            		session.setAttribute("filtro", filtro);
    				ProductoDAO productoDAO = new ProductoDAO();
    				productoDAO.getAllProducts(filtro);
    			} catch (InputMismatchException e) {
    				// TODO Auto-generated catch block
    				e.printStackTrace();
    			} catch (SQLException e) {
    				// TODO Auto-generated catch block
    				e.printStackTrace();
    			}
            	response.sendRedirect("productos");
            	break;
            	
            default:
                response.sendRedirect("productos");
                break;
        }
    }
    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession();
        System.out.println("Entrando en doGet");

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            System.out.println("Error: No se encontró el driver JDBC");
            e.printStackTrace();
            return;
        }

        try (Connection connection = DriverManager.getConnection(
                "jdbc:sqlserver://localhost:1433;databaseName=SistemaCompras;encrypt=true;trustServerCertificate=true", 
                "User", 
                "157359x")) {

            ProductoDAO productoDAO = new ProductoDAO();
            String filtro = session.getAttribute("filtro").toString();
            List<Producto> productos = productoDAO.getAllProducts(filtro); // Asegúrate de que este método esté implementado correctamente
            request.setAttribute("productos", productos);
            request.getRequestDispatcher("productos.jsp").forward(request, response);
        } catch (SQLException e) {
            System.out.println("Error en la conexión a la base de datos");
            e.printStackTrace();
        }
    }
    
    
    
    
    
 
}
