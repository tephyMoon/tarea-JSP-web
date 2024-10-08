<%-- 
    Document   : index
    Created on : 5/10/2024
    Author     : Maritza Vargas
--%>
<%@page import="modelo.Puesto"%>
<%@page import="modelo.Empleado"%>
<%@page import="java.util.HashMap"%>
<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Empleados</title>
    </head>
    <body>
        <h1>Formulario empleados</h1>
        <button type="button" class="btn btn-info btn-lg" data-bs-toggle="modal" data-bs-target="#modal_empleado" onclick="limpiar()">Nuevo</button>
        
        <div class="container">
            <div class="modal fade" id="modal_empleado" role="dialog">
                <div class="modal-dialog">
    <div class="modal-content">
    <div class="modal-body">
        <form action="sr_empleado" method="post" class="form-group">
                <label for="lbl_id">ID</label>
                <input type="text" name="txt_id" id="txt_id" class="form-control" value="0" readonly>
                <label for="lbl_codigo">Codigo</label>
                <input type="text" name="txt_codigo" id="txt_codigo" class="form-control" placeholder="Ejemplo: E001" required>
                <label for="lbl_nombres">Nombres</label>
                <input type="text" name="txt_nombres" id="txt_nombres" class="form-control" placeholder="1er Nombre 2do Nombre" required>
                <label for="lbl_apellidos">Apellidos</label>
                <input type="text" name="txt_apellidos" id="txt_apellidos" class="form-control" placeholder="1er Apellido 2do Apellido" required>
                <label for="lbl_direccion">Direccion</label>
                <input type="text" name="txt_direccion" id="txt_direccion" class="form-control" placeholder="Guatemala" required>
                <label for="lbl_telefono">Telefono</label>
                <input type="number" name="txt_telefono" id="txt_telefono" class="form-control" placeholder="12345678" required>
                <label for="lbl_fn">Nacimiento</label>
                <input type="date" name="txt_fn" id="txt_fn" class="form-control" placeholder="dd/mm/aaaa" required>
                <label for="lbl_telefono">Puesto</label>
                <select name="drop_puesto" id="drop_puesto" class="form-control">
                    <%
                    Puesto puesto = new Puesto();
                    HashMap<String,String> drop = puesto.drop_sangre();
                    for (String i: drop.keySet()){
                        out.println("<option value='" + i +"'>" + drop.get(i) +"</option>");
                    }
                    %>   
                </select>
                <br/>
                <button  name="btn_agregar" id="btn_agregar" value="agregar" class="btn btn-primary btn-lg">Agregar</button>
                <button  name="btn_modificar" id="btn_modificar" value="modificar" class="btn btn-success btn-lg">Modificar</button>
                <button  name="btn_eliminar" id="btn_eliminar" value="eliminar" class="btn btn-danger btn-lg" onclick="javascript:if(!confirm('Desea eliminar'))return false">Eliminar</button>
                <button type="button" class="btn btn-warning btn-lg" data-bs-dismiss="modal">Cerrar</button>
            </form></div>
</div>               
</div>
</div>
                      
             <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Codigo</th>
                        <th>Nombres</th>
                        <th>Apellidos</th>
                        <th>Direccion</th>
                        <th>Telefono</th>
                        <th>Nacimiento</th>
                        <th>Puesto</th>
                    </tr>
                </thead>
                <tbody id="tbl_empleados">
                    <% 
                    Empleado empleado = new Empleado();
                    DefaultTableModel tabla = new DefaultTableModel();
                    tabla = empleado.leer();
                    for(int t=0;t<tabla.getRowCount();t++){
                        out.println("<tr data-id='" + tabla.getValueAt(t,0) + "' data-id_p='" + tabla.getValueAt(t,8) + "'>");
                        out.println("<td>"+ tabla.getValueAt(t,1) + "</td>");
                        out.println("<td>"+ tabla.getValueAt(t,2) + "</td>");
                        out.println("<td>"+ tabla.getValueAt(t,3) + "</td>");
                        out.println("<td>"+ tabla.getValueAt(t,4) + "</td>");
                        out.println("<td>"+ tabla.getValueAt(t,5) + "</td>");
                        out.println("<td>"+ tabla.getValueAt(t,6) + "</td>");
                        out.println("<td>"+ tabla.getValueAt(t,7) + "</td>");
                        out.println("</tr>");
                    }
                    %>
                </tbody>
            </table>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script type="text/javascript">
    function limpiar(){
        $("#txt_id").val(0);
        $("#txt_codigo").val('');
        $("#txt_nombres").val('');
        $("#txt_apellidos").val('');
        $("#txt_direccion").val('');
        $("#txt_telefono").val('');
        $("#txt_fn").val('');
        $("#drop_puesto").val(1); // Seleccionar el puesto  
    }

    $(document).ready(function() {
        // Evento click para las filas de la tabla
        $('#tbl_empleados').on('click', 'tr', function(evt) {
            var target, id, id_p, codigo, nombres, apellidos, direccion, telefono, nacimiento;
            
            target = $(this); // Cambia a la fila completa (tr)
            
            // Obtener los valores de la fila seleccionada
            id = target.data('id');
            id_p = target.data('id_p');
            codigo = target.find('td').eq(0).html();
            nombres = target.find('td').eq(1).html();
            apellidos = target.find('td').eq(2).html();
            direccion = target.find('td').eq(3).html();
            telefono = target.find('td').eq(4).html();
            nacimiento = target.find('td').eq(5).html();
            
            // Asignar los valores a los inputs
            $("#txt_id").val(id);
            $("#txt_codigo").val(codigo);
            $("#txt_nombres").val(nombres);
            $("#txt_apellidos").val(apellidos);
            $("#txt_direccion").val(direccion);
            $("#txt_telefono").val(telefono);
            $("#txt_fn").val(nacimiento);
            $("#drop_puesto").val(id_p); // Seleccionar el puesto
            $("#modal_empleado").modal('show'); // Mostrar el modal
        });
    });
</script>
    </body>
</html>
