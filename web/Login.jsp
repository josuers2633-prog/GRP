<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>CTPD - Iniciar sesión</title>
    <%@include file="WEB-INF/head.jsp" %>
</head>
<body class="bg-light">
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-12 col-md-6 col-lg-4">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h1 class="h4 mb-4 text-center">Iniciar sesión</h1>

                    <%
                        String error = (String) request.getAttribute("error");
                        if (error != null) {
                    %>
                        <div class="alert alert-danger"><%= error %></div>
                    <%
                        }
                    %>

                    <form method="post" action="Login">
                        <div class="mb-3">
                            <label class="form-label">Usuario</label>
                            <input type="text" name="usuario" class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Contraseña</label>
                            <input type="password" name="contrasena" class="form-control" required>
                        </div>

                        <button type="submit" class="btn btn-primary w-100">Entrar</button>
                    </form>

                    <div class="mt-3 small text-muted">
                        Usuarios de prueba:<br>
                        josuer / 123456<br>
                        supervisor1 / 123456<br>
                        agente1 / 123456
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
