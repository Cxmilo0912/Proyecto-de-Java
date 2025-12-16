package fintrix.dao;

import fintrix.model.Transaccion;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TransaccionDAO {

    public List<Transaccion> listarTransacciones() {
        List<Transaccion> lista = new ArrayList<>();
        String sql = "SELECT id, cuenta_id, categoria_id, fecha, tipo, descripcion, monto, created_at FROM transacciones ORDER BY id";

        try (Connection conn = Conexion.getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Transaccion transaccion = new Transaccion();
                transaccion.setId(rs.getInt("id"));
                transaccion.setCuenta_id(rs.getInt("cuenta_id"));
                transaccion.setCategoria_id(rs.getInt("categoria_id"));
                transaccion.setFecha(rs.getDate("fecha"));
                transaccion.setTipo(rs.getString("tipo"));
                transaccion.setDescripcion(rs.getString("descripcion"));
                transaccion.setMonto(rs.getDouble("monto"));
                transaccion.setCreado_en(rs.getTimestamp("created_at"));
                lista.add(transaccion);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }

    public Transaccion obtenerTransaccionPorId(int id) {
        String sql = "SELECT * FROM transacciones WHERE id = ?";
        Transaccion transaccion = null;

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                transaccion = new Transaccion();
                transaccion.setId(rs.getInt("id"));
                transaccion.setCuenta_id(rs.getInt("cuenta_id"));
                transaccion.setCategoria_id(rs.getInt("categoria_id"));
                transaccion.setFecha(rs.getDate("fecha"));
                transaccion.setTipo(rs.getString("tipo"));
                transaccion.setDescripcion(rs.getString("descripcion"));
                transaccion.setMonto(rs.getDouble("monto"));
                transaccion.setCreado_en(rs.getTimestamp("created_at"));

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return transaccion;
    }

    public boolean crearTransaccion(Transaccion transaccion) {
        String sql = "INSERT INTO transacciones (cuenta_id, categoria_id, fecha, tipo, descripcion, monto) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, transaccion.getCuenta_id());
            pstmt.setInt(2, transaccion.getCategoria_id());
            pstmt.setDate(3, transaccion.getFecha());          // java.sql.Date
            pstmt.setString(4, transaccion.getTipo());
            pstmt.setString(5, transaccion.getDescripcion());
            pstmt.setDouble(6, transaccion.getMonto());
            int filasAfectadas = pstmt.executeUpdate();
            return filasAfectadas > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean actualizarTransaccion(Transaccion transaccion) {
        String sql = "UPDATE transacciones SET cuenta_id = ?, categoria_id = ?, fecha = ?, tipo = ?, descripcion = ?, monto = ? "
                + "WHERE id = ?";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, transaccion.getCuenta_id());
            pstmt.setInt(2, transaccion.getCategoria_id());
            pstmt.setDate(3, transaccion.getFecha());          // java.sql.Date
            pstmt.setString(4, transaccion.getTipo());
            pstmt.setString(5, transaccion.getDescripcion());
            pstmt.setDouble(6, transaccion.getMonto());
            pstmt.setInt(7, transaccion.getId());
            int filasAfectadas = pstmt.executeUpdate();
            return filasAfectadas > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean eliminarTransaccion(int id) {
        String sql = "DELETE FROM transacciones WHERE id = ?";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            int filasAfectadas = pstmt.executeUpdate();
            return filasAfectadas > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

    }

    public List<Transaccion> buscar(String criterio) {
        List<Transaccion> lista = new ArrayList<>();
        String sql = "SELECT * FROM transacciones "
                + "WHERE cuenta_id LIKE ? OR tipo LIKE ? OR descripcion LIKE ? OR monto LIKE ? "
                + "ORDER BY id ";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            String parametro = "%" + criterio + "%";
            pstmt.setString(1, parametro);
            pstmt.setString(2, parametro);
            pstmt.setString(3, parametro);
            pstmt.setString(4, parametro);

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Transaccion transaccion = new Transaccion();
                transaccion.setId(rs.getInt("id"));
                transaccion.setFecha(rs.getDate("fecha"));         // java.sql.Date
                transaccion.setTipo(rs.getString("tipo"));
                transaccion.setDescripcion(rs.getString("descripcion"));
                transaccion.setMonto(rs.getDouble("monto"));
                lista.add(transaccion);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

}
