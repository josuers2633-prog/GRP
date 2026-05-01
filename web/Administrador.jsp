<%-- 
    Document   : Administrador
    Created on : 13 feb. 2026, 16:21:46
    Author     : Joshk
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="mx.unadm.grp.model.Usuario"%>

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
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Panel de administración</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container py-5">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="h4 m-0">Panel de administración</h1>
        <a class="btn btn-outline-secondary btn-sm" href="index.jsp">Volver</a>
    </div>

    <div class="row g-4">

        <div class="col-md-6">
            <div class="card shadow-sm h-100">
                <div class="card-body text-center">
                    <h2 class="h5">Gestión de productos</h2>
                    <p class="text-muted">Administrar catálogo</p>
                    <a class="btn btn-primary" href="GestionProductos.jsp">
                        Entrar
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card shadow-sm h-100">
                <div class="card-body text-center">
                    <h2 class="h5">Gestión de usuarios</h2>
                    <p class="text-muted">Administrar usuarios</p>
                    <a class="btn btn-primary" href="GestionUsuarios.jsp">
                        Entrar
                    </a>
                </div>
            </div>
        </div>

    </div>

</div>

</body>
</html>