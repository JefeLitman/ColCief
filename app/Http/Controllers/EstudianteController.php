<?php

namespace App\Http\Controllers;

use App\Estudiante;

/*@Autor Paola*/
use App\Acudiente; //Pepe no me lo vuelva a borrar
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Requests\EstudianteStoreController;
use App\Http\Requests\EstudianteUpdateController;
use App\Http\Controllers\SupraController;
use Illuminate\Support\Facades\Hash;



class EstudianteController extends Controller{

    //Funciones publicas de primeros y al final las privadas

    public function __construct(){ 
        $this->middleware('admin:administrador'); //restringir el acceso a los usuarios
    }
    
    public function index(){
        $estudiante = Estudiante::all();
        return view('estudiantes.listaEstudiante', ['estudiante' => $estudiante]);
    }

    public function create(){
        return view('estudiantes.crearEstudiante');
    }

    public function store(EstudianteStoreController $request){    
        $acudiente = (new Acudiente)->fill(
            SupraController::minuscula(
                $request->all(), 
                "nombre",
                "apellido",
                "grado",
                "fecha_nacimiento",
                "discapacidad",
                "foto" //datos q no quiere guardar
            )
        );
        $acudiente->save(); // se guarda el acudiente 
        $estudiante = (new Estudiante)->fill(
            SupraController::minuscula($request->all(), 
                "nombre_acu_1",
                "direccion_acu_1",
                "telefono_acu_1",
                "nombre_acu_2",
                "direccion_acu_2",
                "telefono_acu_2" //datos q no quiere guardar
            )
        );
        $estudiante->fk_acudiente = $acudiente->pk_acudiente;
        $estudiante->password = Hash::make('clave');
        
        if($request->hasFile('foto')){ // se guarda la imagen 
          $nombre = 'estudiante'.$estudiante->pk_estudiante;
          $estudiante->foto = SupraController::subirArchivo($request,$nombre,'foto');
        }
        $estudiante->save();
         // se guarda el estudiante
        return redirect(route('estudiantes.show', $estudiante->pk_estudiante));
    }
    
    public function show($pk_estudiante){
        /*@Autor Paola C.*/
        //En este momento se muestra en la view que se encuentra en Local>Resource>View>estudiantes>verEstudiante.blade.php y allá se reciben todos los datos del respectivo estudiante y acudiente en las variables tipo Object $estudiante, $acudiente.
        $estudiante = Estudiante::where('pk_estudiante', $pk_estudiante)->get();
        if(empty($estudiante[0])){
            return "No se ha encontrado el estudiante.";
        }else{
            $acudiente= Acudiente::where('pk_acudiente', $estudiante[0]->fk_acudiente)->get();
            if(empty($acudiente[0])){
                return "No se ha encontrado al respectivo acudiente.";
            }else{
                return view("estudiantes.verEstudiante",[
                   'estudiante'=>$estudiante[0],
                   'acudiente' =>$acudiente[0]
                ]); 
            }
        }
    }

    public function edit($pk_estudiante){
        $estudiante = Estudiante::findOrFail($pk_estudiante);
        $acudiente = Acudiente::findOrFail($estudiante->fk_acudiente);
        return view('estudiantes.editarEstudiante', [
            'estudiante' => $estudiante, 
            'acudiente'=> $acudiente
        ]);
    }

    public function update(EstudianteUpdateController $request, $pk_estudiante){
        $estudiante = Estudiante::findOrFail($pk_estudiante)->fill(
            SupraController::minuscula($request->all(),
                "nombre_acu_1",
                "direccion_acu_1",
                "telefono_acu_1",
                "nombre_acu_2",
                "direccion_acu_2",
                "telefono_acu_2" //datos q no quiere guardar
            )
        );
        $acudiente = Acudiente::findOrFail($estudiante->fk_acudiente)->fill(
            SupraController::minuscula($request->all(),
                "nombre",
                "apellido",
                "grado",
                "fecha_nacimiento",
                "discapacidad",
                "foto" //datos q no quiere guardar
            )
        );
        if($request->hasFile('foto')){
            $nombre = 'estudiante'.$estudiante->pk_estudiante;
            $estudiante->foto = SupraController::subirArchivo($request,$nombre,'foto'); //cambie el metodo mientras pienso como solucionarlo xD, este metodo llama al metodo de subir archivo, lo unico es retorna la direccion completa, esto para poder mostrar las imagenes en el servidor (Solucion Temporal)
        }
        $estudiante->password= Hash::make('clave');
        $acudiente->save();
        $estudiante->save();
        return redirect(route('estudiantes.show', $estudiante->pk_estudiante));
    }

    public function destroy(Request $request, $pk_estudiante){
        if($request->ajax()){
            $estudiante = Estudiante::findOrFail($pk_estudiante);
            $estudiante->delete();

            return response()->json([
                'mensaje' => $estudiante->nombre.' '.$estudiante->apellido. ' Fue eliminado'
            ]);
        }
    }
}
