
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="mx.unadm.grp.model.Usuario"%>

<%
    Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");

    if (usuarioLogueado == null) {
        response.sendRedirect("Login");
        return;
    }

    String rol = usuarioLogueado.getRol();

    if (!"ADMIN".equalsIgnoreCase(rol)) {
        response.sendRedirect("index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registrar producto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="h4 m-0">Registrar producto</h1>
        <a class="btn btn-outline-secondary btn-sm" href="Administrador.jsp">Volver</a>
    </div>

    <div class="card shadow-sm">
        <div class="card-body">

            <%
                String error = (String) request.getAttribute("error");
                if (error != null) {
            %>
                <div class="alert alert-danger"><%= error %></div>
            <%
                }
            %>

            <form method="post" action="RegistrarProducto">
                <div class="row g-3">

                    <div class="col-md-6">
                        <label class="form-label">Código</label>
                        <input type="text" name="codigo" class="form-control" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Nombre</label>
                        <input type="text" name="nombre" class="form-control" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Categoría</label>
                        <input type="text" name="categoria" class="form-control" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Garantía (meses)</label>
                        <input type="number" name="garantiaMeses" class="form-control" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Manual PDF</label>
                        <input type="text" name="manualPdf" class="form-control">
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Estado</label>
                        <select name="estado" class="form-select" required>
                            <option value="Disponible">Disponible</option>
                            <option value="Descontinuado">Descontinuado</option>
                        </select>
                    </div>

                    <div class="col-12">
                        <button type="submit" class="btn btn-primary">Guardar producto</button>
                    </div>

                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>
