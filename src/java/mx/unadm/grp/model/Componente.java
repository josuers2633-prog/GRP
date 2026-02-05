package mx.unadm.grp.model;

public class Componente {
    private String nombre;
    private int cantidad;
    private String codigoRefaccion;

    public Componente(String nombre, int cantidad, String codigoRefaccion) {
        this.nombre = nombre;
        this.cantidad = cantidad;
        this.codigoRefaccion = codigoRefaccion;
    }

    public String getNombre() { return nombre; }
    public int getCantidad() { return cantidad; }
    public String getCodigoRefaccion() { return codigoRefaccion; }
}

