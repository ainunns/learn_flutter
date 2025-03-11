import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('My first app'),
        centerTitle: true,
        backgroundColor: Colors.amber[200],
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 20,
          children: [
            Container(
              padding: EdgeInsets.all(30.0),
              color: Colors.cyan[100],
              child: Image.network(
                'https://picsum.photos/200',
                fit: BoxFit.fill
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              color: Colors.pink[100],
              child: Text(
                'What image is that?'
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              color: Colors.amber[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.food_bank,
                      ),
                      Text('Food')
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.umbrella,
                      ),
                      Text('Scenery')
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.people,
                      ),
                      Text('People')
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ),
  ));
}