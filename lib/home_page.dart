import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              SearchBar(
                leading: Icon(Icons.search),
                hintText: 'Buscar',
                onChanged: (value) {
                  print('Texto de búsqueda: $value');
                },
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey,
                      child: Icon(Icons.woman_outlined),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Top Sellers',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.blue,
                      child: Center(child: Text('Item 1')),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.blue,
                      child: Center(child: Text('Item 2')),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.blue,
                      child: Center(child: Text('Item 3')),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.blue,
                      child: Center(child: Text('Item 4')),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.blue,
                      child: Center(child: Text('Item 5')),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
