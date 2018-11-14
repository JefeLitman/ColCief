<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Nota extends Model
{
    protected $table = 'nota';
    protected $primaryKey = 'pk_nota';
    protected $guarded = [];

    public function MateriaPC()
    {
      return $this->belongsTo('App\MateriaPC','fk_materia_pc','pk_materia_pc');
    }

    public function Division()
    {
      return $this->belongsTo('App\division','fk_division','pk_division');
    }

    // public function NotaEstudiantes()
    // {
    //   return $this->hasMany('App\NotaEstudiante',...);
    // }
}
