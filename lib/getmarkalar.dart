import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pedal_commander/getmodeller.dart';
import 'package:pedal_commander/models/gonderi.dart';
import 'dart:async';

class getmarkalar extends StatefulWidget {
  getmarkalar({Key? key}) : super(key: key);

  @override
  _getmarkalarState createState() => _getmarkalarState();
}

class _getmarkalarState extends State<getmarkalar> {
  List<Gonderi> tumMarkalar = [];

  String url =
      //Lutfen api url'nizi giriniz...

  Future<Gonderi> _gonderiGetir() async {
    var response = await http.get(
      Uri.parse(url),
      headers: {
        //Lutfen api endpointlerinizi giriniz...
      },
    );
    if (response.statusCode == 200) {
      Gonderi markalarListesi = Gonderi.fromJson(json.decode(response.body));

      return markalarListesi;

      // return (json.decode(response.body) as List)
      //     .map((tekGonderiMap) => Gonderi.fromJson(tekGonderiMap))
      //     .toList();
    } else {
      throw Exception("Bağlanamadı...${response.statusCode}");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _gonderiGetir().then((okunanGonderi) {
    //   gonderi1 = okunanGonderi;
    //   debugPrint("Gelen değer : " + gonderi1!.data.toString());
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Markalar")),
      body: Markalar(),
    );
  }

  FutureBuilder<Gonderi> Markalar() {
    return FutureBuilder(
      future: _gonderiGetir(),
      builder: (context, AsyncSnapshot<Gonderi> snapshot) {
        if (snapshot.hasData) {
          return Modeller();
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        ;
      },
    );
  }

  FutureBuilder<Gonderi> Modeller() {
    return FutureBuilder(
      future: _gonderiGetir(),
      builder: (context, AsyncSnapshot<Gonderi> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.data.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data!.data[index].toString()),
                onTap: () {
                  debugPrint("tıklandı");
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          getmodeller(snapshot.data!.data[index].toString()),
                    ),
                  );
                },
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
