package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import mx.unadm.grp.model.Producto;
import mx.unadm.grp.repository.ProductoRepository;

@WebServlet(name = "BusquedaServlet", urlPatterns = {"/busqueda"})
public class BusquedaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

      
        String q = safeTrim(request.getParameter("q"));
        String categoria = safeTrim(request.getParameter("categoria"));
        String orden = safeTrim(request.getParameter("orden"));
        if (orden.isEmpty()) orden = "nombre";

        String estado = safeTrim(request.getParameter("estado"));     // "" | "activo" | "inactivo"
        String vigencia = safeTrim(request.getParameter("vigencia")); // "" | "con" | "sin"

        int page = 1;
        try { page = Integer.parseInt(request.getParameter("page")); } catch (Exception ignored) {}
        int pageSize = 5;

        List<Producto> base = ProductoRepository.getAll();
        List<Producto> filtrados = new ArrayList<>();

        for (Producto p : base) {

            boolean matchTexto = true;
            if (!q.isEmpty()) {
                String texto = normalize(q);
                String nombre = normalize(p.getNombre());
                String codigo = normalize(p.getCodigo());
                matchTexto = nombre.contains(texto) || codigo.contains(texto);
            }

            // filtrar por categoría (normalizado)
            boolean matchCategoria = true;
            if (!categoria.isEmpty()) {
                matchCategoria = normalize(p.getCategoria()).equals(normalize(categoria));
            }

            // filtrar por estado (normalizado)
            boolean matchEstado = true;
            if (!estado.isEmpty()) {
                matchEstado = normalize(p.getEstado()).equals(normalize(estado));
            }

            // filtrar por vigencia (simulado con garantiaMeses > 0 / <= 0)
            boolean matchVigencia = true;
            if (!vigencia.isEmpty()) {
                if ("con".equalsIgnoreCase(vigencia)) {
                    matchVigencia = p.getGarantiaMeses() > 0;
                } else if ("sin".equalsIgnoreCase(vigencia)) {
                    matchVigencia = p.getGarantiaMeses() <= 0;
                }
            }

            if (matchTexto && matchCategoria && matchEstado && matchVigencia) {
                filtrados.add(p);
            }
        }

        // ---- ordenar ----
        Comparator<Producto> comparator =
                Comparator.comparing(Producto::getNombre, String.CASE_INSENSITIVE_ORDER);

        if ("codigo".equalsIgnoreCase(orden)) {
            comparator = Comparator.comparing(Producto::getCodigo, String.CASE_INSENSITIVE_ORDER);
        } else if ("categoria".equalsIgnoreCase(orden)) {
            comparator = Comparator.comparing(Producto::getCategoria, String.CASE_INSENSITIVE_ORDER)
                    .thenComparing(Producto::getNombre, String.CASE_INSENSITIVE_ORDER);
        }

        filtrados.sort(comparator);

        // ---- paginar ----
        int total = filtrados.size();
        int totalPages = (int) Math.ceil(total / (double) pageSize);
        if (totalPages <= 0) totalPages = 1;

        if (page < 1) page = 1;
        if (page > totalPages) page = totalPages;

        int from = (page - 1) * pageSize;
        int to = Math.min(from + pageSize, total);

        List<Producto> pageList;
        if (total == 0) {
            pageList = new ArrayList<>();
        } else {
            pageList = filtrados.subList(from, to);
        }

        // ---- attributes para JSP ----
        request.setAttribute("resultados", pageList);
        request.setAttribute("total", total);
        request.setAttribute("page", page);
        request.setAttribute("totalPages", totalPages);

        // conservar selections
        request.setAttribute("q", q);
        request.setAttribute("categoria", categoria);
        request.setAttribute("orden", orden);
        request.setAttribute("estado", estado);
        request.setAttribute("vigencia", vigencia);

        request.getRequestDispatcher("/busqueda.jsp").forward(request, response);
    }

    private static String safeTrim(String s) {
        return s == null ? "" : s.trim();
    }

    private static String normalize(String s) {
        String out = s == null ? "" : s.toLowerCase();

        out = out.replace("á", "a").replace("é", "e").replace("í", "i")
                 .replace("ó", "o").replace("ú", "u").replace("ü", "u")
                 .replace("ñ", "n");

        out = out.replaceAll("\\s+", " ");
        return out.trim();
    }
}

