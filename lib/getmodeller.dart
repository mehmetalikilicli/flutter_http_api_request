import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pedal_commander/getkasalar.dart';
import 'dart:async';

import 'models/gonderi.dart';

class getmodeller extends StatefulWidget {
  String geciciMarka;

  getmodeller(this.geciciMarka);

  @override
  _getmodellerState createState() => _getmodellerState(geciciMarka);
}

class _getmodellerState extends State<getmodeller> {
  String? geciciMarka;

  _getmodellerState(this.geciciMarka);

  String url =  //Lutfen api url'nizi giriniz...

  Future<Gonderi> _gonderiGetir(String markaAdi) async {
    var response = await http.get(
      Uri.parse(url + markaAdi),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modeller"),
      ),
      body: Center(
        child: Kasalar(),
      ),
    );
  }

  FutureBuilder<Gonderi> Kasalar() {
    return FutureBuilder(
      future: _gonderiGetir(geciciMarka!),
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
                      builder: (context) => getkasalar(
                          geciciMarka!, snapshot.data!.data[index].toString()),
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
