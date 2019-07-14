import 'package:flutter/material.dart';
import 'package:peliculas1/src/models/pelicula_model.dart';


class MovieHorizontal extends StatelessWidget {

final List<Pelicula> peliculas;

MovieHorizontal({@required this.peliculas});


  @override
  Widget build(BuildContext context) {
    
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView(
        pageSnapping: false,
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3 
        ),
        children : _tarjetas(),
      ),
    );
  }

    List<Widget> _tarjetas(){

     return peliculas.map((pelicula){
        return Container(
          margin: EdgeInsets.only(right:5.0),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                  child: FadeInImage(
                  image: NetworkImage(pelicula.getPosterImg()),
                  placeholder: NetworkImage('https://media0.giphy.com/media/3oEjI6SIIHBdRxXI40/giphy.gif'),
                  fit: BoxFit.cover,
                  height: 160.0,
                ),
              )
            ],
          ),
        );
     }).toList(); 

    }

}