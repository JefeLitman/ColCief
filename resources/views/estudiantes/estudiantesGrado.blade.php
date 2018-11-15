@extends('contenedores.admin')
@section('contenedor_admin')
@section('titulo','Estudiantes/Grado')

<div class="table-responsive" >
    <table class="table table-hover mr-auto" id="myTable">
        <thead>
            <tr>
                <th scope="col" style="color:#00695c">Código</th>
                <th scope="col" style="color:#00695c">Nombre</th>
                <th scope="col" style="color:#00695c">Apellido</th>
                {{-- <th scope="col" style="color:#00695c">Clave</th> --}}
                <th scope="col" style="color:#00695c">Grado</th>
                <th scope="col" style="color:#00695c"></th>
                <th scope="col" style="color:#00695c"></th>
                {{-- <th>Editar</th>
                <th>Eliminar</th> --}}
            </tr>
        </thead>
        <tbody>
                {{-- @php print_r($curso) @endphp --}}
            @foreach ($curso as $c)
            <tr>
                <td>{{$c->pk_estudiante}}</td>
                <td>{{$c->nombre}}</td>
                <td>{{$c->apellido}}</td>
                <td>{{$c->grado}}</td>
                <td><a href="{{ route('estudiantes.edit', $c->pk_estudiante) }}"><i class="fas fa-edit" style="color:#00838f"></i>
                </a></td>
                <td class="delete" ruta="estudiantes" identificador="{{$c->pk_estudiante}}"><i class="fas fa-trash-alt" style="color:#c62828"></i></td>
            </tr>
            @endforeach
        </tbody>
    </table>

</div>
<script src="{{ asset('js/ajax.js') }}"></script>
@endsection