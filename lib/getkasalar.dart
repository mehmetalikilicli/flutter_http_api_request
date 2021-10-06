import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pedal_commander/getmotorlar.dart';
import 'dart:async';

import 'models/gonderi.dart';

class getkasalar extends StatefulWidget {
  String geciciMarka;
  String geciciModel;

  getkasalar(this.geciciMarka, this.geciciModel);

  @override
  _getkasalarState createState() =>
      _getkasalarState(this.geciciMarka, this.geciciModel);
}

class _getkasalarState extends State<getkasalar> {
  String? geciciMarka;
  String? geciciModel;
  _getkasalarState(this.geciciMarka, this.geciciModel);

  String url =  //Lutfen api url'nizi giriniz...

  Future<Gonderi> _gonderiGetir(String markaAdi, String modelAdi) async {
    var response = await http.get(
      Uri.parse(url + markaAdi + "/" + modelAdi),
      headers: {  //Lutfen api endpointlerinizi giriniz...

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
        title: Text("Kasalar"),
      ),
      body: Center(
        child: Kasalar(),
      ),
    );
  }

  FutureBuilder<Gonderi> Kasalar() {
    return FutureBuilder(
      future: _gonderiGetir(geciciMarka!, geciciModel!),
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
                      builder: (context) => getmotorlar(geciciMarka!,
                          geciciModel!, snapshot.data!.data[index].toString()),
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
