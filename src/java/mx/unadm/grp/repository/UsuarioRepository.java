package mx.unadm.grp.repository;

import java.util.ArrayList;
import java.util.List;
import mx.unadm.grp.model.Usuario;

public class UsuarioRepository {

    private static final List<Usuario> usuarios = new ArrayList<>();

    static {
        usuarios.add(new Usuario("Josué R", "josuer", "123456", "ADMIN", "ACTIVO"));
        usuarios.add(new Usuario("Supervisor Demo", "supervisor1", "123456", "SUPERVISOR", "ACTIVO"));
        usuarios.add(new Usuario("Agente Demo", "agente1", "123456", "AGENTE", "ACTIVO"));
    }

    public static Usuario validarCredenciales(String usuario, String contrasena) {
        for (Usuario u : usuarios) {
            if (u.getUsuario().equalsIgnoreCase(usuario)
                    && u.getContrasena().equals(contrasena)
                    && u.getEstado().equalsIgnoreCase("ACTIVO")) {
                return u;
            }
        }
        return null;
    }

    public static List<Usuario> getAll() {
        return usuarios;
    }
}
