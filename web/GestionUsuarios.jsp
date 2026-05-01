<%-- 
    Document   : GestionUsuarios
    Created on : 30 abr. 2026, 17:01:21
    Author     : Joshk
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="mx.unadm.grp.model.Usuario"%>
<%@page import="mx.unadm.grp.repository.UsuarioRepository"%>

<%
    Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");

    if (usuarioLogueado == null) {
        response.sendRedirect("Login");
        return;
    }

    if (!"ADMIN".equalsIgnoreCase(usuarioLogueado.getRol())) {
        response.sendRedirect("index.jsp");
        return;
    }

    List<Usuario> usuarios = UsuarioRepository.getAll();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestión de usuarios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container py-4">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="h4 m-0">Gestión de usuarios</h1>

        <!-- 🔥 AQUÍ ESTÁ LA CORRECCIÓN -->
        <a class="btn btn-outline-secondary btn-sm" href="Administrador.jsp">Volver</a>
    </div>

    <!-- FORMULARIO -->
    <div class="card shadow-sm mb-4">
        <div class="card-body">
            <h2 class="h5 mb-3">Registrar usuario</h2>

            <form method="post" action="RegistrarUsuario">

                <div class="row g-3">

                    <div class="col-md-4">
                        <label class="form-label">Usuario</label>
                        <input type="text" name="usuario" class="form-control" required>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Contraseña</label>
                        <input type="password" name="contrasena" class="form-control" required>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Rol</label>
                        <select name="rol" class="form-select">
                            <option>ADMIN</option>
                            <option>SUPERVISOR</option>
                            <option>AGENTE</option>
                        </select>
                    </div>

                </div>

                <div class="mt-3">
                    <button type="submit" class="btn btn-primary btn-sm">
                        Guardar usuario
                    </button>
                </div>

            </form>

        </div>
    </div>

    <!-- TABLA -->
    <div class="card shadow-sm">
        <div class="card-body">
            <h2 class="h5 mb-3">Usuarios actuales</h2>

            <div class="table-responsive">
                <table class="table table-striped table-bordered align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>Usuario</th>
                            <th>Rol</th>
                            <th>Estado</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Usuario u : usuarios) { %>
                            <tr>
                                <td><%= u.getUsuario() %></td>
                                <td><%= u.getRol() %></td>
                                <td><%= u.getEstado() %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

        </div>
    </div>

</div>

</body>
</html>