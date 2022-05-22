// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';

class PaymentOptions extends StatefulWidget {
  const PaymentOptions({Key? key}) : super(key: key);

  @override
  State<PaymentOptions> createState() => _PaymentOptionsState();
}

class _PaymentOptionsState extends State<PaymentOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text("Payment Screen"));
  }
}
