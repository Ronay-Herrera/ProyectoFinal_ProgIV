package modelo;

public class Carrito {
    private int id;
    private int idProducto;
    private String fechaCreacion; // Cambiado a camelCase
    private String nombreProducto; // Cambiado a nombreProducto
    private String descripcionProducto; // Cambiado a descripcionProducto
    private double precio;
    private int cantidad; // Cambiado a cantidad

    // Constructor, getters y setters
    public Carrito(int id, int idProducto, String fechaCreacion, String nombreProducto, String descripcionProducto, double precio, int cantidad) {
        this.id = id;
        this.idProducto = idProducto;
        this.fechaCreacion = fechaCreacion;
        this.nombreProducto = nombreProducto;
        this.descripcionProducto = descripcionProducto;
        this.precio = precio;
        this.cantidad = cantidad;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdProducto() {
		return idProducto;
	}

	public void setIdProducto(int idProducto) {
		this.idProducto = idProducto;
	}

	public String getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(String fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    public String getNombreProducto() {
        return nombreProducto;
    }

    public void setNombreProducto(String nombreProducto) {
        this.nombreProducto = nombreProducto;
    }

    public String getDescripcionProducto() {
        return descripcionProducto;
    }

    public void setDescripcionProducto(String descripcionProducto) {
        this.descripcionProducto = descripcionProducto;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }
}
