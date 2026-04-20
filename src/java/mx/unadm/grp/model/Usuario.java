package mx.unadm.grp.model;

public class Usuario {

    private String nombreVisible;
    private String usuario;
    private String contrasena;
    private String rol;
    private String estado;

    public Usuario(String nombreVisible, String usuario, String contrasena, String rol, String estado) {
        this.nombreVisible = nombreVisible;
        this.usuario = usuario;
        this.contrasena = contrasena;
        this.rol = rol;
        this.estado = estado;
    }

    public String getNombreVisible() {
        return nombreVisible;
    }

    public String getUsuario() {
        return usuario;
    }

    public String getContrasena() {
        return contrasena;
    }

    public String getRol() {
        return rol;
    }

    public String getEstado() {
        return estado;
    }

    public void setNombreVisible(String nombreVisible) {
        this.nombreVisible = nombreVisible;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
}
