package mx.unadm.grp.repository;

import java.util.ArrayList;
import java.util.List;
import mx.unadm.grp.model.Producto;

public class ProductoRepository {

    private static final List<Producto> productos = new ArrayList<>();

    static {
        productos.add(new Producto("SARTEN-8", "Sartén 8 pulgadas", "Sartenes", 12, "Sarten8.pdf", "Disponible"));
        productos.add(new Producto("SARTEN-10", "Sartén 10 pulgadas", "Sartenes", 12, "Sarten10.pdf", "Disponible"));
        productos.add(new Producto("OLLA-8QT", "Olla 8 cuartos", "Ollas", 24, "Olla8.pdf", "Disponible"));
        productos.add(new Producto("OLLA-4QT", "Olla 4 cuartos", "Ollas", 24, "Olla4.pdf", "Disponible"));
        productos.add(new Producto("CUCHILLO-5", "Cuchillo 5 pulgadas", "Cuchillería", 0, "Cuchillo8.pdf", "Descontinuado")); // (0 meses para probar HU021)

    }

    public static Producto findByCodigo(String codigo) {
        for (Producto p : productos) {
            if (p.getCodigo().equalsIgnoreCase(codigo)) {
                return p;
            }
        }
        return null;
    }

    public static List<Producto> getAll() {
        return productos;
    }
}
