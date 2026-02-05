<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="mx.unadm.grp.model.Producto"%>
<%@page import="mx.unadm.grp.model.Componente"%>
<%@page import="mx.unadm.grp.repository.ProductoRepository"%>
<%@page import="mx.unadm.grp.repository.ComponenteRepository"%>

<!DOCTYPE html>
<html>
<head>
    <title>CTPD - Detalle del producto</title>
    <%@include file="WEB-INF/head.jsp" %>
</head>
<body class="bg-light">

<div class="container py-4">
<%
    // Parámetros para volver a la búsqueda SIN perder filtros
    String qBack   = request.getParameter("q") != null ? request.getParameter("q") : "";
    String catBack = request.getParameter("categoria") != null ? request.getParameter("categoria") : "";
    String ordBack = request.getParameter("orden") != null ? request.getParameter("orden") : "nombre";
    String estBack = request.getParameter("estado") != null ? request.getParameter("estado") : "";
    String vigBack = request.getParameter("vigencia") != null ? request.getParameter("vigencia") : "";
    String pageBack = request.getParameter("page") != null ? request.getParameter("page") : "1";

    // Producto actual
    String codigo = request.getParameter("codigo");
    Producto p = ProductoRepository.findByCodigo(codigo);
%>

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h1 class="h4 m-0">Detalle del producto</h1>

        <div class="d-flex gap-2">
            <a class="btn btn-sm btn-outline-secondary"
               href="busqueda?q=<%= qBack %>&categoria=<%= catBack %>&orden=<%= ordBack %>&estado=<%= estBack %>&vigencia=<%= vigBack %>&page=<%= pageBack %>">
                Volver
            </a>

            <a class="btn btn-sm btn-outline-secondary" href="index.jsp">Inicio</a>

            <%-- Botón Manual SOLO si existe el producto --%>
            <%
                if (p != null) {
            %>
                <a class="btn btn-sm btn-outline-primary"
                   href="manuales.jsp?codigo=<%= p.getCodigo() %>">
                    Manual
                </a>
            <%
                }
            %>
        </div>
    </div>

<%
    if (p == null) {
%>
        <div class="alert alert-warning">Producto no encontrado.</div>
<%
    } else {
        List<Componente> comps = ComponenteRepository.obtenerComponentes(p.getCodigo());
%>

        <div class="card shadow-sm mb-3">
            <div class="card-body">
                <div class="row g-2">
                    <div class="col-12 col-md-6"><b>Código:</b> <%= p.getCodigo() %></div>
                    <div class="col-12 col-md-6"><b>Categoría:</b> <%= p.getCategoria() %></div>
                    <div class="col-12"><b>Nombre:</b> <%= p.getNombre() %></div>
                    <div class="col-12"><b>Garantía:</b> <%= p.getGarantiaMeses() %> meses</div>
                    <div class="col-12"><b>Estado:</b> <%= p.getEstado() %></div>
                </div>
            </div>
        </div>

        <div class="card shadow-sm mb-3">
            <div class="card-body">
                <h2 class="h6 mb-3">Componentes</h2>

                <%
                    if (comps == null || comps.isEmpty()) {
                %>
                    <div class="alert alert-secondary mb-0">
                        No hay componentes registrados para este producto.
                    </div>
                <%
                    } else {
                %>
                    <div class="table-responsive">
                        <table class="table table-sm table-striped align-middle mb-0">
                            <thead>
                                <tr>
                                    <th>Componente</th>
                                    <th class="text-center">Cantidad</th>
                                    <th>Código de refacción</th>
                                </tr>
                            </thead>
                            <tbody>
                            <%
                                for (Componente c : comps) {
                            %>
                                <tr>
                                    <td><%= c.getNombre() %></td>
                                    <td class="text-center"><%= c.getCantidad() %></td>
                                    <td><%= c.getCodigoRefaccion() %></td>
                                </tr>
                            <%
                                }
                            %>
                            </tbody>
                        </table>
                    </div>
                <%
                    }
                %>
            </div>
        </div>

<%
    }
%>
</div>

</body>
</html>



