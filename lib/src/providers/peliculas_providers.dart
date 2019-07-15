import 'dart:async';
import 'dart:convert';

import 'package:peliculas1/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculasProviders{
  String _apiKey    ='f9b88b252c7b7bacc58fc425fe529c73';
  String _language  ='es-ES';
  String _url       ='api.themoviedb.org';

int _popularesPage = 0;

List<Pelicula> _populares = new List();

final _popularesStreamControler = StreamController<List<Pelicula>>.broadcast();

Function(List<Pelicula>) get popularesSink => _popularesStreamControler.sink.add;

Stream <List<Pelicula>> get popularesStram => _popularesStreamControler.stream;



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
    _popularesPage++;
    final url = Uri.https(_url, '3/movie/popular',{
      'api_key'   : _apiKey,
      'language'  : _language,
      'page'      : _popularesPage.toString()
    });
  
  final resp = await _procesarRespuesta(url);

  _populares.addAll(resp);
  popularesSink(_populares);

  return resp;
  }
}