import 'package:flutter/material.dart';

class PokemonDetail extends StatelessWidget {

  final Map _pokemonData;

  PokemonDetail( this._pokemonData );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pokemonData["name"],
          style: TextStyle(
            color: Colors.white,
            //fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.redAccent,
      body: _detailPokemon( context, _pokemonData ),
    );
  }
}

Widget _detailPokemon( BuildContext context, Map pokemon ){

  return Stack(
    children: <Widget>[
      Positioned(
        height: MediaQuery.of(context).size.height/1.5,
        width: MediaQuery.of(context).size.width-20,
        left: 10.0,
        top: MediaQuery.of(context).size.height*0.1,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(

          ),
        ),
      ),
    ],
  );
}