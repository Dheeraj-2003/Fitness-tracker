import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class SubsScreen extends StatefulWidget {
  const SubsScreen({super.key});

  @override
  State<SubsScreen> createState() => _SubsScreenState();
}

class _SubsScreenState extends State<SubsScreen> {
  late Razorpay _razorpay;

  void openCheckout(double amount) async {
    amount = amount * 100;
    final options = {
      'key': 'YOUR_KEY',
      'amount': amount,
      'name': 'Weight Tracker',
      'prefill': {
        'contact': '12345678',
        'email': 'test@gmail.com',
      },
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error : $e');
    }
  }

  void onPaymentSuccess(PaymentSuccessResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text("Payment Successful with payment ID: ${response.paymentId}")));
  }

  void onPaymentFailure(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Payment Failed: ${response.message}")));
  }

  void onExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("External Wallet: ${response.walletName}")));
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, onPaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, onPaymentFailure);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, onExternalWallet);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [Icon(Icons.card_membership_rounded)],
        title: const Text("Subscribe"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Icon(Icons.card_giftcard_rounded),
                  title: Text("1 month"),
                  trailing: Text(
                    "₹199.00",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Icon(Icons.card_giftcard_rounded),
                  title: Text("6 months"),
                  trailing: Text(
                    "₹699.00",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Icon(Icons.card_giftcard_rounded),
                  title: Text("12 months"),
                  trailing: Text(
                    "₹1099.00",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                openCheckout(300);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                width: double.infinity,
                child: const Text(
                  "Subscribe",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
