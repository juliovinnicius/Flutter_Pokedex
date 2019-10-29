import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex_project/pages/pokemon_details.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  static const url = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  Future<Map> _getData() async{

    http.Response response;
    response = await http.get(url);

    return json.decode(response.body);
  }


  @override
  void initState() {
    super.initState();
   _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/9/98/International_Pok%C3%A9mon_logo.svg/2000px-International_Pok%C3%A9mon_logo.svg.png"),
      centerTitle: true,
      backgroundColor: Colors.red,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: FutureBuilder(
              future: _getData(),
              builder: ( context, snapshot ){
                switch( snapshot.connectionState ){
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Container(
                      width: 200,
                      height: 200,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 5.0,
                      ),
                    );
                  default:
                    if( snapshot.hasError ){
                      return Container();
                    }
                    else{
                      return _createPokedex( context, snapshot );
                    }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  int _getCount( List data ){
    return data.length;
  }

  Widget _createPokedex(  BuildContext context, AsyncSnapshot snapshot ){
    
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: _getCount( snapshot.data["pokemon"] ),
      itemBuilder: ( context, index ){
        return GestureDetector(
          child: Hero(
            tag: Image.network(
              snapshot.data["pokemon"][index]["img"],
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 3.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 100.0,
                    width: 100.0,
                    child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: snapshot.data["pokemon"][index]["img"],
                    ),
//                    decoration: BoxDecoration(
//                      image: DecorationImage(
//                        image: NetworkImage(snapshot.data["pokemon"][index]["img"])
//                      )
//                    ),
                  ),
                  Text(
                    snapshot.data["pokemon"][index]["name"],
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute( builder: ( context ) => PokemonDetail( snapshot.data["pokemon"][index] ) ),
            );
          },
        );
      },
    );
  }
}


