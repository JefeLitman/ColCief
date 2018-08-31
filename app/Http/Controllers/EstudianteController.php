<?php

namespace App\Http\Controllers;

use App\Estudiante;

/*@Autor Paola*/
use App\Acudiente; //Pepe no me lo vuelva a borrar 
/**/

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class EstudianteController extends Controller{

    //Funciones publicas de primeros y al final las privadas

    public function index(){
        
    }

    public function create(){
        return view('prueba.estudiante');
    }

    public function store(Request $request){
        // if($this->validar($request)){
        //     Estudiante::create($request->all());
        //     dd('se guardo');
        // }
        // print gettype($request->foto);
        $this->validar($request);
        // dd($request->files());
        // echo $request->discapacidad;
    }

    public function show($pk_estudiante){
        /*@Autor Paola*/
        //En este momento se muestra en la view que se encuentra en Local>Resource>View>estudiantes>verEstudiante.blade.php y allá se reciben todos los datos del respectivo estudiante y acudiente en las variables tipo Object $estudiante, $acudiente.

        $estudiante = Estudiante::where('pk_estudiante', $pk_estudiante)->first()->get()[0];
        $acudiente= Acudiente::where('pk_acudiente', $estudiante->fk_acudiente)->first()->get()[0];
        
        //return $estudiante;
        return view("estudiantes.verEstudiante",['estudiante'=>$estudiante,'acudiente' =>$acudiente] );
    }

    public function edit(Estudiante $estudiante){
        
    }

    public function update(Request $request, $pk_estudiante){
        if($this->validar($request)){
            $estudiante = Estudiante::where('pk_estudiante', $pk_estudiante)->first()->get()[0];
            $estudiante->update($request->all());
        }    
    }
    private function mover(Request $request){
        $request->file('foto')->store('avatar');
        $format = explode('/', $request->file('foto')->getMimeType());
        dd(Storage::move($request->file('foto')->store('avatar'), "avatar/img".$request->pk_estudiante.".".$format[1]));
    }

    private function validar(Request $request){
        $request->validate([
            'pk_estudiante' => 'required|numeric|unique:estudiante',
            'fk_acudiente' => 'required|numeric',
            'nombre' => 'required|string|max:20|',
            'apellido' => 'required|string|max:20',
            'clave' => 'required|string|max:20',
            'fecha_nacimiento' => 'required|date',
            'grado' => 'required|numeric',
            'discapacidad' => 'boolean',
            'estado' => 'boolean',
            'foto'=> 'image|required|mimes:jpeg,bmp,png,jpg',  
        ]);
        $this->mover($request);
    }
}