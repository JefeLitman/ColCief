<?php
/*
  SUPRACONTROLLER
  AUTOR: Douglas Ramírez
  VERSIÓN: 0.1
  DESCRIPCIÓN:
  Ésta clase tiene como objetivo agrupar todos los métodos necesarios
  en las demás clases, a modo de no repetir código y cumplir con el
  single responsibility principle.
 */

  namespace App\Http\Controllers;
  use Illuminate\Http\Request;

  class SupraController{
    // public static function subirArchivo(Request $request, String $role){
    //   if($role = "estudiante"){
    //     $nombre = $role.$request->pk_estudiante;
    //   }else if($role = "empleado"){
    //     $nombre = $role.$request->pk_empleado;
    //   }
    //   $nombre .= '.'.$request->file('foto')->clientExtension();
    //   $file = $request->file('foto')->storeAs('public', $nombre);
    //   return $nombre;
    // }
    /*
      SUBIR ARCHIVO:
      Método que sirve para subir cualquier tipo de archivo, es necesario pasarle como parametro
      el request, el nombre del archivo (ya formateado, ej: empleado[PK_Empleado]), y el nombre
      del input del formulario (ej: foto, pdf, ...)
      Autor: Douglas y Pepe
    */
    public static function subirArchivo(Request $request,String $nombre,String $input){
      $nombre .= '.'.$request->file($input)->clientExtension();
      $file = $request->file($input)->storeAs('public', $nombre);
      return $nombre;
    }
    /*
      COMPROBAR REPETICION:
      Método que sirve para comprobar, al actualizar los datos de una fila, que no exista otra fila con
      la misma PK, por lo tanto, genere problemas de sobrescritura o errores de integridad en la BD.
      Recibe como parametro la PK que se quiere asignar, la PK actual (que viene del recurso), el nombre
      del campo de la BD que corresponde a la clave primaria y el modelo.
      Retorna 1 si existe repetición (1:Sí existe repetición)
      Retorna 0 si NO existe repetición (0:No, no se repite)
    */
    public static function comprobarRepeticion($pk_futura,$pk_original,$campo_pk,$Modelo){
      if($pk_futura!=$pk_original){
        $query = $Modelo::where($campo_pk,$pk_futura)->get();
        if(!empty($query[0])){
          return 0; //No existe una fila con ese dato, se viola dicha fila, es decir, SÍ se repite la pk
        }
      }
      return 1; //Sí existe una fila creada con esa PK
    }
  }
?>
