import 'package:flutter/material.dart';

enum AmountPropina { diez, quince, veinte }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var cantidad;
  bool roundOrNot = false;
  double tip = 0.0;
  var cost_service = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 6, 99, 22),
        title: Text('Tip time'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 14),
          ListTile(
            leading:
                Icon(Icons.room_service, color: Color.fromARGB(255, 6, 99, 22)),
            title: Padding(
              padding: EdgeInsets.only(right: 24),
              child: TextField(
                  controller: cost_service,
                  cursorColor: Color.fromARGB(255, 6, 99, 22),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 6, 99, 22))),
                      border: const OutlineInputBorder(),
                      labelText: "Cost of Service"),
                    keyboardType: TextInputType.number),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dinner_dining,
                color: Color.fromARGB(255, 6, 99, 22)),
            title: Text("How was the service?"),
          ),
          ListTile(
              title: const Text('Okay 10%'),
              leading: Radio(
                activeColor: Color.fromARGB(255, 6, 99, 22),
                value: AmountPropina.diez,
                groupValue: cantidad,
                onChanged: (Object? value) {
                  setState(() {
                    cantidad = value;
                  });
                },
              )),
          ListTile(
              title: const Text('Good 15%'),
              leading: Radio(
                activeColor: Color.fromARGB(255, 6, 99, 22),
                value: AmountPropina.quince,
                groupValue: cantidad,
                onChanged: (Object? value) {
                  setState(() {
                    cantidad = value;
                  });
                },
              )),
          ListTile(
              title: const Text('Amazing 20%'),
              leading: Radio(
                activeColor: Color.fromARGB(255, 6, 99, 22),
                value: AmountPropina.veinte,
                groupValue: cantidad,
                onChanged: (Object? value) {
                  setState(() {
                    cantidad = value;
                  });
                },
              )),
          ListTile(
            leading:
                Icon(Icons.credit_card, color: Color.fromARGB(255, 6, 99, 22)),
            title: Text("Round up tip?"),
            trailing: Switch(
              value: roundOrNot,
              activeColor: Colors.blue,
              onChanged: (bool value) {
                setState(() {
                  roundOrNot = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: ElevatedButton(
              child: Text("CALCULATE"),
              style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 6, 99, 22)),
              onPressed: () {
                _tipCalculation();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Tip amount: \$${tip}",
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  void _tipCalculation() {
    if (roundOrNot) {
      if (cantidad == AmountPropina.diez) {
        tip = (double.parse(cost_service.text) * 0.10).ceil() * 1.0;
      } else if (cantidad == AmountPropina.quince) {
        tip = (double.parse(cost_service.text) * 0.15).ceil() * 1.0;
      } else {
        tip = (double.parse(cost_service.text) * 0.20).ceil() * 1.0;
      }
    } else {
      if (cantidad == AmountPropina.diez) {
        tip = double.parse(cost_service.text) * 0.10;
      } else if (cantidad == AmountPropina.quince) {
        tip = double.parse(cost_service.text) * 0.15;
      } else {
        tip = double.parse(cost_service.text) * 0.20;
      }
    }
    setState(() {});
  }
}
