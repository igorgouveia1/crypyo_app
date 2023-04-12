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
        percent: cryptoData['quote']['USD']['percent_change_1h'],
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
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
                        leading: Text(cryptoinfo[index].symbol,
                            style: const TextStyle(fontSize: 16)),
                        title: Text(cryptoinfo[index].name),
                        subtitle: Text(
                          (cryptoinfo[index].percent) > 0
                              ? (cryptoinfo[index].percent).toStringAsFixed(2)
                              : (cryptoinfo[index].percent).toStringAsFixed(2),
                          style: TextStyle(
                            color: (cryptoinfo[index].percent) > 0
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                        trailing: Text(
                            'USD\$ ${(cryptoinfo[index].price).toStringAsFixed(2)}'),
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
