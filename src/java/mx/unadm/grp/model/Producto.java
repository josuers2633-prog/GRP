package mx.unadm.grp.model;

public class Producto {

    private String codigo;
    private String nombre;
    private String categoria;
    private int garantiaMeses;
    private String manualPdf;
    private String estado;

    public Producto(String codigo, String nombre, String categoria,
                    int garantiaMeses, String manualPdf,String estado) {
        this.codigo = codigo;
        this.nombre = nombre;
        this.categoria = categoria;
        this.garantiaMeses = garantiaMeses;
        this.manualPdf = manualPdf;
        this.estado = estado;
    }

    public String getCodigo() { return codigo; }
    public String getNombre() { return nombre; }
    public String getCategoria() { return categoria; }
    public int getGarantiaMeses() { return garantiaMeses; }
    public String getManualPdf() { return manualPdf; }
    public String getEstado() { return estado; }
}
