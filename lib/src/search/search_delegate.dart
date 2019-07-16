import 'package:flutter/material.dart';
import 'package:peliculas1/src/models/pelicula_model.dart';
import 'package:peliculas1/src/providers/peliculas_providers.dart';

class DataSearch extends SearchDelegate {

  final peliculasProviders = new PeliculasProviders();
  String seleccion = '';

  final peliculas =[
    'Spiderman',
    'Aquaman',
    'Shazam!',
    'IronMan',
    'Capitan America',
    'Superman',
    'IronMan 2',
    'IronMan 3',
    'IronMan 4',
    'IronMan 5',


  ];

  final peliculasRecientes = [
    'Spiderman',
    'Capitan America'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
   //las acciones de nuestro AppBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
         query='';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //icono a la izquierda del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que se van a mostrar
    return Center(
      child: Container(
        height: 100,
        width: 100,
        color: Colors.indigo,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe

    if(query.isEmpty){
      return Container();
    }

    return FutureBuilder(
      future: peliculasProviders.buscarpelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if(snapshot.hasData){
          final peliculas = snapshot.data;



          return ListView(
            children: peliculas.map((pelicula){
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(pelicula.getPosterImg()),
                  placeholder: NetworkImage('https://thumbs.gfycat.com/GenuineIllinformedEmu-size_restricted.gif'),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: (){
                  close(context, null);
                  pelicula.uniqueId = '';
                  Navigator.pushNamed(context, 'detalle',arguments: pelicula);
                },
              );
            }).toList()
            );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );

    // return Container();


  }


  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   // Son las sugerencias que aparecen cuando la persona escribe

  //   final listaSugerida = (query.isEmpty) ? peliculasRecientes :peliculas.where(  
  //     (p)=> p.toLowerCase().startsWith(query.toLowerCase()) ).toList(); 


  //   return ListView.builder(
  //     itemCount: listaSugerida.length,
  //     itemBuilder: (context,i){
  //       return ListTile(
  //         leading: Icon(Icons.movie),
  //         title:Text(listaSugerida[i]),
  //         onTap: (){},
  //       );
  //     },
  //   );
  // }

}