package controlador;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import DAO.CarritoDAO;
import modelo.Carrito;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ControladorCarrito extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger logger = Logger.getLogger(ControladorCarrito.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Object userId = session.getAttribute("id");
        
        if (userId == null) {
            response.sendRedirect("login"); // Redirigir al login si no está logueado
            return;
        }

        try {
            CarritoDAO carritoDAO = new CarritoDAO();
            int id = Integer.parseInt(userId.toString());
            List<Carrito> productosCarrito = carritoDAO.getAllProducts(id);
            
            
            request.setAttribute("productosCarrito", productosCarrito);
            
            
            request.getRequestDispatcher("carrito.jsp").forward(request, response);
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error en la conexión a la base de datos", e);
            response.sendRedirect("error"); // Redirige a una página de error si hay un problema con la base de datos
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("method");
        

        if (action == null) {
        	System.out.println("Accion invalida.");
            response.sendRedirect("carrito"); // Redirige si no se recibe una acción válida
            return;
        }

        switch (action) {
            case "removeFromCart":
                removeFromCart(request, response);
                break;
            case "checkout":
                checkout(request, response);
                break;
            default:
                response.sendRedirect("carrito"); // Acción no reconocida
                break;
        }
    }

   private void removeFromCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
    CarritoDAO carritoDAO = new CarritoDAO();
    int productId = Integer.parseInt(request.getParameter("productId"));
    HttpSession session = request.getSession();
    int userId = Integer.parseInt(session.getAttribute("id").toString());

        try {
            carritoDAO.removeProductFromCart(userId, productId);
        	} catch (SQLException e) {
            e.printStackTrace(); // Mejor usar un logger
        }

        response.sendRedirect("carrito");
}


   private void checkout(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
	    CarritoDAO carritoDAO = new CarritoDAO();
	    HttpSession session = request.getSession();
	    int userId = Integer.parseInt(session.getAttribute("id").toString());
	    
		try {
			List<Carrito> productosComprados = carritoDAO.getAllProducts(userId);
			request.setAttribute("productosComprados", productosComprados);
			double total =  Double.parseDouble(request.getParameter("totalCompra"));
		    session.setAttribute("totalCompra", total);
		        try {
		            carritoDAO.checkout(userId);
		        } catch (SQLException e) {
		            e.printStackTrace();
		        }

		        request.getRequestDispatcher("compraExitosa.jsp").forward(request, response);
		        response.sendRedirect("compraExitosa");
		} catch (SQLException e) {

			e.printStackTrace();
		}	    
	    
	}

}