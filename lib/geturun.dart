import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'models/gonderi.dart';

class geturun extends StatefulWidget {
  String geciciMarka;
  String geciciModel;
  String geciciKasa;
  String geciciMotor;

  geturun(
      this.geciciMarka, this.geciciModel, this.geciciKasa, this.geciciMotor);

  @override
  _geturunState createState() => _geturunState(

      this.geciciMarka, this.geciciModel, this.geciciKasa, this.geciciMotor);
}

class _geturunState extends State<geturun> {
  String? geciciMarka;
  String? geciciModel;
  String? geciciKasa;
  String? geciciMotor;
  _geturunState(
      this.geciciMarka, this.geciciModel, this.geciciKasa, this.geciciMotor);

  String url =
      //Lutfen api url'nizi giriniz...toStringShort()

  Future<Gonderi> _gonderiGetir(
      String markaAdi, String modelAdi, String kasaAdi, String motorAdi) async {
    var response = await http.get(
      Uri.parse(
          url + markaAdi + "/" + modelAdi + "/" + kasaAdi + "/" + motorAdi),
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
        title: Text("Urun"),
      ),
      body: Center(
        child: Urun(),
      ),
    );
  }

  FutureBuilder<Gonderi> Urun() {
    return FutureBuilder(
      future:
          _gonderiGetir(geciciMarka!, geciciModel!, geciciKasa!, geciciMotor!),
      builder: (context, AsyncSnapshot<Gonderi> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.data.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data!.data[index].toString()),
                onTap: () {
                  debugPrint("tıklandı");
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
