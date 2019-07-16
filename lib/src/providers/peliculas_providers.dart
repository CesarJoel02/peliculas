import 'dart:async';
import 'dart:convert';

import 'package:peliculas1/src/models/actores_model.dart';
import 'package:peliculas1/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculasProviders{
  String _apiKey    ='f9b88b252c7b7bacc58fc425fe529c73';
  String _language  ='es-ES';
  String _url       ='api.themoviedb.org';

int _popularesPage = 0;
bool _cargando = false;

List<Pelicula> _populares = new List();

final _popularesStreamControler = StreamController<List<Pelicula>>.broadcast();

Function(List<Pelicula>) get popularesSink => _popularesStreamControler.sink.add;

Stream <List<Pelicula>> get popularesStream => _popularesStreamControler.stream;



void disposeStream(){
  _popularesStreamControler?.close();
}

  Future<List<Pelicula>> _procesarRespuesta(Uri url)async {

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
  

    return peliculas.items;

  }

  Future<List<Pelicula>>  getEnCines()async{

    final url = Uri.https(_url, '3/movie/now_playing',{
      'api_key'   : _apiKey,
      'language'  : _language
    });

  return await _procesarRespuesta(url);

  }

  Future<List<Pelicula>>  getPopulares()async{

    if (_cargando) return [];

    _cargando = true;

    _popularesPage++;
    print('Cargando siguientes...');

    final url = Uri.https(_url, '3/movie/popular',{
      'api_key'   : _apiKey,
      'language'  : _language,
      'page'      : _popularesPage.toString()
    });
  
  final resp = await _procesarRespuesta(url);

  _populares.addAll(resp);
  popularesSink(_populares);
  _cargando = false;

  return resp;
  }

  Future<List<Actor>> getCast( String peliId )async{

    final url = Uri.https(_url, '/movie/$peliId/credits',{
      'api_key'   : _apiKey,
      'language'  : _language,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final cast = new Cast.fromJsonList(decodedData['cast']);
    return cast.actores;

  }

}