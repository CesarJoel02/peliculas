import 'package:flutter/material.dart';
import 'package:peliculas1/src/providers/peliculas_providers.dart';
import 'package:peliculas1/src/search/search_delegate.dart';
import 'package:peliculas1/src/widgets/card_swiper_widget.dart';
import 'package:peliculas1/src/widgets/movie_horizontal.dart';


class HomePage extends StatelessWidget {
  //const HomePage({Key key}) : super(key: key);

  final peliculasProviders = new PeliculasProviders();

  @override
  Widget build(BuildContext context) {

    peliculasProviders.getPopulares();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Peliculas en cines'),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              showSearch(
                context: context,
                delegate: DataSearch()
                );
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
            _footer(context)
          ],
        ),
      ),
    );
  }

  Widget _swiperTarjetas(){

  return FutureBuilder(
    future: peliculasProviders.getEnCines(),
    builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

    if (snapshot.hasData){
      return CardSwiper( peliculas: snapshot.data,);
    }else{
      return Container(
        height: 400.0,
        child: Center(
          child: CircularProgressIndicator()
        )
      );
    }
  },
);

    //return CardSwiper(
      //peliculas: [1,2,3,4,5],
    //);
  }

Widget _footer(BuildContext context){

  return Container(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left:20.0),
          child: Text('Populares',style: Theme.of(context).textTheme.subhead)
          ),
        SizedBox(height: 5.0,),
        StreamBuilder(
          stream: peliculasProviders.popularesStream,
          
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if(snapshot.hasData){
            return MovieHorizontal(
              peliculas: snapshot.data,
              siguientePagina: peliculasProviders.getPopulares);
            }else{
              return Center(child: CircularProgressIndicator());
            }
            
          },
        ),
      ],
    ),
  );

}

}