<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use PDF;
use App\Http\Controllers\BoletinController;

class PdfController extends Controller
{
    public function invoiceActual($fk_estudiante){
        return $this->invoice(date('Y'),$fk_estudiante);
    }
    public function invoice($ano,$fk_estudiante){

        $data = (new BoletinController)->showAnoEstudiante($ano,$fk_estudiante,true);
        // $data =["holi"=>"holi"];
        // $data = ['title' => 'Welcome to HDTuto.com'];
        // dd($data);

        $pdf = PDF::loadView('pdf.invoice', $data);
        
        return $pdf->stream('invoice');

    }
}