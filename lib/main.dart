import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('My First App'),
        centerTitle: true,
        backgroundColor: Colors.blue[200],
      ),
      body: Center(
        child: Text(
          "This is body",
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              color: Colors.grey[600],
              fontFamily: 'Poppins'
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { },
        backgroundColor: Colors.blue[200],
        child: const Text('click'),
      ),
    ),
  ));
}