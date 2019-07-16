import 'package:flutter/material.dart';
import 'package:peliculas1/src/models/actores_model.dart';
import 'package:peliculas1/src/models/pelicula_model.dart';
import 'package:peliculas1/src/providers/peliculas_providers.dart';

class PeliculaDetalle extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {

    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return  Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            _crearAppbar(pelicula),
            SliverList(
              delegate: SliverChildListDelegate(

                [
                  SizedBox(height: 10.0,),
                  _posterTitulo(pelicula, context),
                  _descripcion(pelicula),
                  _descripcion(pelicula),
                  _descripcion(pelicula),
                  _descripcion(pelicula),
                  _descripcion(pelicula),
                  _crearCasting(pelicula),
                ]
              
              ),
            )
          ],
        ),
      );
  }

  Widget _crearAppbar(Pelicula pelicula){

      return SliverAppBar(
        elevation: 2.0,
        backgroundColor: Colors.indigo,
        expandedHeight: 200.0,
        floating: false,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(
            pelicula.title,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          background: FadeInImage(
            image: NetworkImage(pelicula.getBackgroundImg()),
            placeholder: NetworkImage('https://thumbs.gfycat.com/GenuineIllinformedEmu-size_restricted.gif'),
            // fadeInDuration: Duration(microseconds: 150),
            fit: BoxFit.cover,
          ),
        ),
      );
  }

  Widget _posterTitulo(Pelicula pelicula,BuildContext context){

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
              child: Image(
              image: NetworkImage(pelicula.getPosterImg()),
              height: 150,
            ),
          ),
          SizedBox(width: 20,),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(pelicula.title, style: Theme.of(context).textTheme.title),
                Text(pelicula.originalTitle, style: Theme.of(context).textTheme.subhead),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(pelicula.voteAverage.toString(), style: Theme.of(context).textTheme.subhead)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _descripcion(Pelicula pelicula){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _crearCasting(Pelicula pelicula){

    final peliProvider = new PeliculasProviders();

    return FutureBuilder(
      future: peliProvider.getCast(pelicula.id.toString()),
      builder: ( context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData){
          return _crearActoresPageView (snapshot.data);
        } else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );



  }

  Widget _crearActoresPageView ( List<Actor> actores){

    return SizedBox(
      height: 200,
      child: PageView.builder(
        itemCount: actores.length,
        pageSnapping: false,
        itemBuilder: (cotext, i)=> _actorTarjeta(actores[i]),
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),
      ),
    );
  }

  Widget _actorTarjeta(Actor actor){
    return Container(
      child: Column(
        children: <Widget>[
          FadeInImage(
            image: NetworkImage(actor.getFoto(),),
            placeholder: NetworkImage('https://thumbs.gfycat.com/GenuineIllinformedEmu-size_restricted.gif'),
            
          )
        ],
      ),
    );
  }

}