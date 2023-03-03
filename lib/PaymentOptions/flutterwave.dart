import 'package:flutter/material.dart';
import 'package:flutterwave_flutterflow/flutterwave.dart';
import 'package:flutterwave_flutterflow/models/subaccount.dart';
import 'package:uuid/uuid.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage(this.title);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final currencyController = TextEditingController();
  final narrationController = TextEditingController();
  final publicKeyController = TextEditingController();
  final encryptionKeyController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  String selectedCurrency = "UGX";

  bool isTestMode = true;
  final pbk = "PUBLICK_KEY";

  @override
  Widget build(BuildContext context) {
    this.currencyController.text = this.selectedCurrency;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Form(
          key: this.formKey,
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: this.amountController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(hintText: "Amount"),
                  validator: (value) =>
                  value!.isNotEmpty ? null : "Amount is required",
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: this.currencyController,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black),
                  readOnly: true,
                  onTap: this._openBottomSheet,
                  decoration: InputDecoration(
                    hintText: "Currency",
                  ),
                  validator: (value) =>
                  value!.isNotEmpty ? null : "Currency is required",
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: this.emailController,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Email",
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: this.phoneNumberController,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Use Debug"),
                    Switch(
                      onChanged: (value) => {
                        setState(() {
                          isTestMode = value;
                        })
                      },
                      value: this.isTestMode,
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: ElevatedButton(
                  onPressed: this._onPressed,
                  //color: Colors.blue,
                  child: Text(
                    "Make Payment",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _onPressed() {
    if (this.formKey.currentState!.validate()) {
      this._handlePaymentInitialization();
    }
  }

  _handlePaymentInitialization() async {
    final style = FlutterwaveStyle(
      appBarText: "Flutterwave Payment",
      buttonColor: Color.fromARGB(255, 4, 113, 197),
      buttonTextStyle: TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        fontSize: 16,
      ),
      appBarColor: Color.fromARGB(255, 212, 118, 2),
      dialogCancelTextStyle: TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        fontSize: 18,
      ),
      dialogContinueTextStyle: TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        fontSize: 18,
      ),
      mainBackgroundColor: Color.fromARGB(255, 255, 255, 255),
      mainTextStyle: TextStyle(
          color: Color.fromARGB(255, 10, 10, 10),
          fontSize: 19,
          letterSpacing: 2),
      dialogBackgroundColor: Color.fromARGB(255, 251, 173, 7),
      appBarIcon: Icon(Icons.message, color: Colors.purple),
      buttonText: "Pay $selectedCurrency ${amountController.text}",
      appBarTitleTextStyle: TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        fontSize: 18,
      ),
    );

    final Customer customer = Customer(
        name: "FLW Developer",
        phoneNumber: this.phoneNumberController.text,
        email: "customer@customer.com");

    final subAccounts = [
      SubAccount(
          id: "RS_1A3278129B808CB588B53A14608169AD",
          transactionChargeType: "flat",
          transactionPercentage: 25),
      SubAccount(
          id: "RS_C7C265B8E4B16C2D472475D7F9F4426A",
          transactionChargeType: "flat",
          transactionPercentage: 50)
    ];

    final Flutterwave flutterwave = Flutterwave(
        context: context,
        style: style,
        publicKey:
             this.getPublicKey(),
        currency: this.selectedCurrency,
        redirectUrl: "https://google.com",
        txRef: Uuid().v1(),
        amount: this.amountController.text.toString().trim(),
        customer: customer,
        // subAccounts: subAccounts,
        paymentOptions:
        "card, barter,  payattitude,mpesa, mobilemoneyuganda, mobilemoneyrwanda, mobilemoneyzambia,mobilemoneyfranco,mobilemoneyghana, ussd, banktransfer",
        customization: Customization(title: "Test Payment"),
        isTestMode: false);
    final ChargeResponse response = await flutterwave.charge();
  }

  String getPublicKey() {
    return "";
    // "FLWPUBK_TEST-02b9b5fc6406bd4a41c3ff141cc45e93-X";
  }

  void _openBottomSheet() {
    showModalBottomSheet(
        context: this.context,
        builder: (context) {
          return this._getCurrency();
        });
  }

  Widget _getCurrency() {
    final currencies = ["NGN", "RWF", "UGX", "KES", "ZAR", "USD", "GHS", "TZS"];
    return Container(
      height: 250,
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      color: Colors.white,
      child: ListView(
        children: currencies
            .map((currency) => ListTile(
          onTap: () => {this._handleCurrencyTap(currency)},
          title: Column(
            children: [
              Text(
                currency,
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 4),
              Divider(height: 1)
            ],
          ),
        ))
            .toList(),
      ),
    );
  }

  _handleCurrencyTap(String currency) {
    this.setState(() {
      this.selectedCurrency = currency;
      this.currencyController.text = currency;
    });
    Navigator.pop(this.context);
  }

  Future<void> showLoading(String message) {
    return showDialog(
      context: this.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // set up the button
        Widget okButton = ElevatedButton(
          child: Text("OK"),
          onPressed: () {},
        );
        return AlertDialog(
          content: Container(
            margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
            width: double.infinity,
            height: 50,
            child: Text(message),
          ),
          actions: [
            okButton,
          ],
        );
      },
    );
  }
}