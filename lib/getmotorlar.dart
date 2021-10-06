import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:pedal_commander/geturun.dart';

import 'models/gonderi.dart';

class getmotorlar extends StatefulWidget {
  String geciciMarka;
  String geciciModel;
  String geciciKasa;

  getmotorlar(this.geciciMarka, this.geciciModel, this.geciciKasa);

  @override
  _getmotorlarState createState() =>
      _getmotorlarState(this.geciciMarka, this.geciciModel, this.geciciKasa);
}

class _getmotorlarState extends State<getmotorlar> {
  String? geciciMarka;
  String? geciciModel;
  String? geciciKasa;
  _getmotorlarState(this.geciciMarka, this.geciciModel, this.geciciKasa);

  String url =
      //Lutfen api url'nizi giriniz...

  Future<Gonderi> _gonderiGetir(
      String markaAdi, String modelAdi, String kasaAdi) async {
    var response = await http.get(
      Uri.parse(url + markaAdi + "/" + modelAdi + "/" + kasaAdi),
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
        title: Text("Motorlar"),
      ),
      body: Center(
        child: Motorlar(),
      ),
    );
  }

  FutureBuilder<Gonderi> Motorlar() {
    return FutureBuilder(
      future: _gonderiGetir(geciciMarka!, geciciModel!, geciciKasa!),
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
                      builder: (context) => geturun(geciciMarka!, geciciModel!,
                          geciciKasa!, snapshot.data!.data[index].toString()),
                    ),
                  );
                },
              );
            },
          );
          //cardMarkalar();
          //elevatodButtonMarkalar(snapshot);

        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
