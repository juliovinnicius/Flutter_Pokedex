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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Hero(
                  tag: pokemon["img"],
                  child: Container(
                    height: 150.0,
                    width: 150.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage( pokemon["img"] ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                pokemon["name"],
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(
                "Height: ${pokemon["height"]}",
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(
                "Weight: ${pokemon["weight"]}",
              ),
              Text(
                "Type",
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pokemon["type"].map<Widget>((t) => FilterChip(
                      backgroundColor: Colors.amber,
                      label: Text(t),
                      onSelected: (b) {}))
                    .toList(),
              ),
              Text(
                "Weaknesses",
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pokemon["weaknesses"].map<Widget>((t) => FilterChip(
                    backgroundColor: Colors.red,
                    label: Text(
                      t,
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    onSelected: (b) {}))
                    .toList(),
              ),
              Text(
                "Next Evolution",
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pokemon["next_evolution"] == null ? <Widget>[Text("Final Evolution")] : pokemon["next_evolution"].map<Widget>((n) => FilterChip(
                  backgroundColor: Colors.green,
                  label: Text(
                    n["name"],
                    style: TextStyle(color: Colors.white),
                  ),
                  onSelected: (b) {},
                ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}