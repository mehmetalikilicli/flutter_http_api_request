import 'package:flutter/material.dart';
import 'package:pedal_commander/getmarkalar.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatelessWidget(),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Urunler"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text("Markalar için tiklayiniz"),
              onPressed: () {
                textStyle:
                TextStyle(
                  fontSize: 30,
                );
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => getmarkalar(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void butonCagir() {
    TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
      ),
      onPressed: () {},
      child: Text('TextButton'),
    );
  }
}
