import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CitySearchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CitySeachScreen();
}

class _CitySeachScreen extends State<CitySearchScreen> {
  final TextEditingController _cityTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter a city'),
      ),
      body: Form(
        child: Row(
          children: [
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: TextFormField(
                controller: _cityTextController,
                decoration: InputDecoration(
                    labelText: 'Enter a city', hintText: 'Example: Chicago'),
              ),
            )),
            IconButton(
                onPressed: () {
                  Navigator.pop(context, _cityTextController.text);
                },
                icon: Icon(Icons.search))
          ],
        ),
      ),
    );
  }
}
