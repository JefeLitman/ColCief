<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class Terminal extends Controller{
    public function link(){
        $salida = shell_exec('cd .. && dir');
        return "<pre>".$salida."</pre>";
    }
}