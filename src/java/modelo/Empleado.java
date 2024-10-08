/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.sql.PreparedStatement;
import javax.swing.table.DefaultTableModel;
/**
 *
 * @author Maritza Vargas
 */
public class Empleado extends Persona{
    private String codigo;
    private int id_puesto;
    private Conexion cn;
    public Empleado() {}

    public Empleado(String codigo, int id_puesto, int id, String nombres, String apellidos, String direccion, String telefono, String fecha_nacimiento) {
        super(id, nombres, apellidos, direccion, telefono, fecha_nacimiento);
        this.codigo = codigo;
        this.id_puesto = id_puesto;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public int getId_puesto() {
        return id_puesto;
    }

    public void setId_puesto(int id_puesto) {
        this.id_puesto = id_puesto;
    }
    public DefaultTableModel leer() {
    DefaultTableModel tabla = new DefaultTableModel(); 
    try{
    cn = new Conexion();
    cn.abrir_conexion();
    String query = "SELECT e.id_empleado as id,e.codigo,e.nombres,e.apellidos,e.direccion,e.telefono,e.fecha_nacimiento,p.puesto,p.id_puesto FROM empleados as e inner join puestos as p on e.id_puesto = p.id_puesto;	";
    ResultSet consulta = cn.conexionBD.createStatement().executeQuery(query);
    String encabezado [] = {"id","codigo","nombres","apellidos","direccion","telefono","nacimiento","puesto","id_puesto"};
    tabla.setColumnIdentifiers(encabezado);
    String datos [] = new String [9];
    while (consulta.next()){
        datos [0] = consulta.getString("id");
        datos [1] = consulta.getString("codigo");
        datos [2] = consulta.getString("nombres");
        datos [3] = consulta.getString("apellidos");
        datos [4] = consulta.getString("direccion");
        datos [5] = consulta.getString("telefono");
        datos [6] = consulta.getString("fecha_nacimiento");
        datos [7] = consulta.getString("puesto");
        datos [8] = consulta.getString("id_puesto");
        tabla.addRow(datos);
    }
    cn.cerrar_conexion();
    }catch(Exception ex){
        System.out.println(ex.getMessage());
    }
                    return tabla;
    }
    @Override
    public int agregar(){
        int retorno = 0;
    try{
        PreparedStatement Parametro;
        cn = new Conexion();
        String query= "INSERT INTO empleados (codigo,nombres,apellidos,direccion,telefono,fecha_nacimiento,id_puesto) VALUES (?,?,?,?,?,?,?);";
        cn.abrir_conexion();
        Parametro = (PreparedStatement)cn.conexionBD.prepareStatement(query);
        Parametro.setString(1, getCodigo());
        Parametro.setString(2, getNombres());
        Parametro.setString(3, getApellidos());
        Parametro.setString(4, getDireccion());
        Parametro.setString(5, getTelefono());
        Parametro.setString(6, getFecha_nacimiento());
        Parametro.setInt(7, getId_puesto());
       retorno = Parametro.executeUpdate();
        cn.cerrar_conexion();
    }catch(SQLException ex){
       System.out.println(ex.getMessage());
       retorno = 0;
    }
    return retorno;
    
    }
    @Override
    public int modificar(){
        int retorno = 0;
    try{
        PreparedStatement Parametro;
        cn = new Conexion();
        String query= "UPDATE empleados SET codigo=?,nombres=?,apellidos=?,direccion=?,telefono=?,fecha_nacimiento=?,id_puesto=? WHERE id_empleado = ?;";
        cn.abrir_conexion();
        Parametro = (PreparedStatement)cn.conexionBD.prepareStatement(query);
        Parametro.setString(1, getCodigo());
        Parametro.setString(2, getNombres());
        Parametro.setString(3, getApellidos());
        Parametro.setString(4, getDireccion());
        Parametro.setString(5, getTelefono());
        Parametro.setString(6, getFecha_nacimiento());
        Parametro.setInt(7, getId_puesto());
        Parametro.setInt(8, getId());
       retorno = Parametro.executeUpdate();
        cn.cerrar_conexion();
    }catch(SQLException ex){
       System.out.println(ex.getMessage());
    }
    return retorno;
    
    }
    @Override
    public int eliminar(){
        int retorno = 0;
    try{
        PreparedStatement Parametro;
        cn = new Conexion();
        String query= "DELETE FROM empleados WHERE id_empleado = ?;";
        cn.abrir_conexion();
        Parametro = (PreparedStatement)cn.conexionBD.prepareStatement(query);
        Parametro.setInt(1, getId());
       retorno = Parametro.executeUpdate();
        cn.cerrar_conexion();
    }catch(SQLException ex){
       System.out.println(ex.getMessage());
    }
    return retorno;
    
    }
}
