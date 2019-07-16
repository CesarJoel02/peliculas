import 'package:flutter/material.dart';
import 'package:peliculas1/src/models/pelicula_model.dart';


class MovieHorizontal extends StatelessWidget {

final List<Pelicula> peliculas;
final Function siguientePagina;

MovieHorizontal({@required this.peliculas,@required this.siguientePagina});

final _pageController = new PageController(
      initialPage: 1,
      viewportFraction: 0.3 
    );

  @override
  Widget build(BuildContext context) {
    
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener((){
      if (_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200){
        siguientePagina();
      }

    });

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        itemBuilder: (context, i) =>_crearTarjeta(context, peliculas[i]),
      
        // children : _tarjetas(),
      ),
    );
  }

  Widget _crearTarjeta (BuildContext context, Pelicula pelicula){
    final tarjeta =  Container(
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

        return GestureDetector(
          child: tarjeta,
          onTap: (){
            Navigator.pushNamed(context, 'detalle',arguments: pelicula);
          },
        );
  }

    List<Widget> _tarjetas(BuildContext context){

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