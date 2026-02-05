<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="mx.unadm.grp.model.Producto"%>
<%@page import="mx.unadm.grp.repository.ProductoRepository"%>

<!DOCTYPE html>
<html>
<head>
    <title>CTPD - Biblioteca de manuales</title>
    <%@include file="WEB-INF/head.jsp" %>
</head>
<body class="bg-light">
<div class="container py-4">

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h1 class="h4 m-0">Biblioteca de manuales</h1>
        <a class="btn btn-sm btn-outline-secondary" href="index.jsp">Inicio</a>
    </div>

    <%
        String codigo = request.getParameter("codigo");
        List<Producto> productos = ProductoRepository.getAll();

        Producto seleccionado = null;
        if (codigo != null && !codigo.trim().isEmpty()) {
            seleccionado = ProductoRepository.findByCodigo(codigo.trim());
        }
    %>

    <div class="card shadow-sm mb-3">
        <div class="card-body">
            <form method="get" action="manuales.jsp" class="row g-2">
                <div class="col-12 col-md-6">
                    <label class="form-label">Código del producto (opcional)</label>
                    <input class="form-control" name="codigo"
                           value="<%= codigo != null ? codigo : "" %>"
                           placeholder="Ej. OLLA-4QT, SARTEN-8, CUCHILLO-5">
                </div>
                <div class="col-12 col-md-3 d-flex align-items-end">
                    <button class="btn btn-primary w-100" type="submit">Buscar</button>
                </div>
                <div class="col-12 col-md-3 d-flex align-items-end">
                    <a class="btn btn-outline-secondary w-100" href="manuales.jsp">Ver todos</a>
                </div>
            </form>
        </div>
    </div>

    <%
        if (seleccionado != null) {
            String pdf = seleccionado.getManualPdf();
            String ruta = "resources/manuales/" + pdf;
    %>
        <div class="card shadow-sm">
            <div class="card-body">
                <div class="mb-2"><b>Producto:</b> <%= seleccionado.getNombre() %> (<%= seleccionado.getCodigo() %>)</div>
                <div class="mb-3"><b>Manual:</b> <%= pdf %></div>

                <div class="d-flex gap-2">
                    <a class="btn btn-outline-primary" target="_blank" href="<%= ruta %>">Ver manual</a>
                    <a class="btn btn-primary" href="<%= ruta %>" download>Descargar PDF</a>
                </div>
            </div>
        </div>
    <%
        } else {
    %>
        <div class="card shadow-sm">
            <div class="card-body">
                <div class="fw-semibold mb-2">Manuales disponibles</div>
                <div class="table-responsive">
                    <table class="table table-sm table-striped align-middle mb-0">
                        <thead>
                        <tr>
                            <th>Código</th>
                            <th>Producto</th>
                            <th>Manual</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            for (Producto p : productos) {
                                String ruta = "resources/manuales/" + p.getManualPdf();
                        %>
                            <tr>
                                <td><%= p.getCodigo() %></td>
                                <td><%= p.getNombre() %></td>
                                <td><%= p.getManualPdf() %></td>
                                <td class="text-end">
                                    <a class="btn btn-sm btn-outline-primary" target="_blank" href="<%= ruta %>">Ver</a>
                                    <a class="btn btn-sm btn-primary" href="<%= ruta %>" download>Descargar</a>
                                </td>
                            </tr>
                        <%
                            }
                        %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    <%
        }
    %>

</div>
</body>
</html>
