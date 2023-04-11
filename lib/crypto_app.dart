import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypyo_app/src/models/currency_model.dart';
import 'package:flutter/material.dart';

class CryptoApp extends StatelessWidget {
  CryptoApp({super.key});
  final cryptoinfo = [];
  final queryParameters = {
    'limit': '10',
  };

  Future getCrypto() async {
    var response = await http.get(
        Uri.https('pro-api.coinmarketcap.com',
            '/v1/cryptocurrency/listings/latest', queryParameters),
        headers: {'X-CMC_PRO_API_KEY': '8bc10f50-1a79-4095-884e-cf6d4518f5be'});

    var jsonData = jsonDecode(response.body);

    for (var cryptoData in jsonData['data']) {
      final crypto = Currency(
        name: cryptoData['name'],
        price: cryptoData['quote']['USD']['price'],
        symbol: cryptoData['symbol'],
      );

      cryptoinfo.add(crypto);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CryptoApp',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: getCrypto(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: cryptoinfo.length,
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(cryptoinfo[index].symbol),
                        subtitle: Text(cryptoinfo[index].name),
                        trailing: Text((cryptoinfo[index].price).toString()),
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
