import 'package:flutter/material.dart';
import 'package:zarinpal/zarinpal.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController amount = TextEditingController();
    TextEditingController description = TextEditingController();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("ZarinPal")),
        backgroundColor: Colors.teal,
        body: Center(
          child: Column(
            children: [
              TextField(
                controller: amount,
                decoration: const InputDecoration(hintText: "مبلغ انتقال"),
              ),
              TextField(
                controller: description,
                decoration: const InputDecoration(hintText: "توضیحات"),
              ),
              ElevatedButton(
                  onPressed: () {
                    bank(description.text, amount.text);
                  },
                  child: const Text("پرداخت")),
            ],
          ),
        ),
      ),
    );
  }
}

void bank(String description, String amount) {
  String merchand = 'Merchand code';
  PaymentRequest paymentRequest = PaymentRequest();
  paymentRequest
    ..setIsSandBox(false)
    ..setMerchantID(merchand)
    ..setDescription(description)
    ..setCallbackURL('https://stokecom.ir')
    ..setAmount(int.parse(amount));
  ZarinPal().startPayment(paymentRequest,
      (int? status, String? paymentGatewayUri) {
    if (status == 100) {
      launchUrl(Uri.parse(paymentGatewayUri!));
    } else {
      throw "Error Status $status";
    }
  });
}
