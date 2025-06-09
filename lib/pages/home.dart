import "package:flutter/material.dart";


class HomePage extends StatelessWidget 
{
  const HomePage({ super.key });

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CEP para Mapa", 
          style: TextStyle(color: Color.fromARGB(255, 240, 240, 240)),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange.shade800,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[],
      ),
    );
  }
}