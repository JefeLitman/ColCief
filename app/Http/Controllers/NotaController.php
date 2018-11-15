<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\SupraController as SC;
use App\Http\Requests\NotaStoreController;
use App\Nota;
use App\Division;
use App\MateriaPC;

class NotaController extends Controller
{

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $NotasDelProfesor = Nota::select('pk_nota','fk_division','fk_materia_pc','nota.nombre','nota.descripcion','nota.porcentaje')->
        join('materia_pc','nota.fk_materia_pc','=','materia_pc.pk_materia_pc')->
        join('empleado','materia_pc.fk_empleado','=','empleado.cedula')->
        where('empleado.cedula','=',session('user')['cedula'])->get();
        $datos = [];
        foreach ($NotasDelProfesor->all() as $Nota) {
          array_push($datos,$this->arrayzar($Nota));
        }
        return view('notas.verNota',['datos' => $datos]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     * Para que funcione correctamente, las autenticaciones deben servir y se
     * debe de estar logeado.
     *
     * @param $pk_materia
     * Por defecto es null, ergo, se puede acceder a la ruta para crear una nota
     * de cualquier materia o de una en concreto si se le manda el pk.
     */
    public function create($pk_materia=null)
    {
      if (!empty($pk_materia)) {
        $materiasPC = MateriaPC::select('pk_materia_pc','nombre')->where([
          ['pk_materia_pc','=',$pk_materia],
          ['fk_empleado','=',session('user')['cedula']]
          ])->get();
      }else{
        $materiasPC = MateriaPC::select('pk_materia_pc','nombre')->where(
          'fk_empleado','=',session('user')['cedula'])->get();
      }
      if ($materiasPC->count()>0) {
        $divisiones = Division::select('pk_division','nombre')->get();
        if ($divisiones->count()>0) {
          return view('notas.crearNota',['divisiones' => $divisiones, 'materias' => $materiasPC]);
        }
        return 'No hay divisiones existentes para asignar notas';
      }
      return 'La materia no existe o no tiene materias asignadas';
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(NotaStoreController $request)
    {
        $Nota = (new Nota)->fill($request->all());
        $Nota->save();
        return redirect('/notas');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($pk_nota)
    {
        $unidad = Nota::find($pk_nota);
        if (!empty($unidad) and $this->verificarProfesor($unidad,session('user')['cedula'])) {
          $datos = [$this->arrayzar($unidad)];
          return view('notas.verNota',['datos' => $datos]);
        }
        return 'Nota no encontrada';
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($pk_nota)
    {
        $unidad = Nota::find($pk_nota);
        if ($this->verificarProfesor($unidad,session('user')['cedula'])) {
          if (!empty($unidad)) {
            $unidad->delete();
            return 'Nota eliminada';
          }
          return 'Nota no encontrada';
        }
        return 'No tiene permisos para hacer esta acción';
    }

    /**
    * Verifica que al objeto nota solicitado le corresponda el profesor
    * indicado o que en su defecto, sea un usuario administrador
    * @param Nota el objeto nota
    * @param string $cedula_prof Es la cédula del usuario
    * @return boolean
    */
    private function verificarProfesor($nota,$cedula_prof)
    {
        $materiaPC = MateriaPC::find($nota['fk_materia_pc']);
        if ($materiaPC['fk_empleado']==$cedula_prof or session('user')['role']==0) {
          return true;
        }
        return false;
    }

    /**
     * Este método devuelve dos colecciones, una que corresponde a la division y otro a la materia
     * @param Nota el objeto Nota
     * @return Array
     */
    private function inspeccionarNota($Nota)
    {
        return [
          'division' => $Nota->Division,
          'materia' => $Nota->MateriaPC
        ];
    }

    /**
     * Este método devuelve un array que contiene el objeto Nota, Divison y Materia
     * donde Division y Materia están capados a los [nombre,descripcion] y [fk_materia, nombre]
     * @param Nota
     * @return Array
     */
    private function arrayzar($Nota)
    {
      $foraneas = $this->inspeccionarNota($Nota);
      $coleccion = [$Nota,$foraneas['division']->all()[0],$foraneas['materia']->all()[0]];
      return $coleccion;
    }
}