import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Flutter McFlutter", home: McFlutterCard());
  }
}

class McFlutterCard extends StatefulWidget {
  const McFlutterCard({
    Key? key,
  }) : super(key: key);

  @override
  State<McFlutterCard> createState() => _McFlutterCardState();
}

class _McFlutterCardState extends State<McFlutterCard> {
  bool isPersonSelected = false;
  bool isIphoneSelected = false;
  bool isAndroidSelected = false;
  bool isTimerSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mc Flutter'),
      ),
      body: Container(
          padding: const EdgeInsets.all(3.0),
          margin: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(children: [Icon(Icons.account_circle, size: 45)]),
              Column(children: [
                Text("Flutter McFlutter"),
                Text("Experienced App Developer", style: TextStyle(fontSize: 8))
              ])
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("123 Sesame Street", style: TextStyle(fontSize: 12.5)),
              Text("(415)3453324", style: TextStyle(fontSize: 12.5))
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              IconButton(
                  onPressed: () {
                    isPersonSelected = true;
                    isIphoneSelected = false;
                    isAndroidSelected = false;
                    isTimerSelected = false;
                    setState(() {});

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Únete a un club con otras personas")));
                  },
                  icon: Icon(Icons.accessibility),
                  color: isPersonSelected ? Colors.indigo : Colors.black),
              IconButton(
                  onPressed: () {
                    isPersonSelected = false;
                    isIphoneSelected = false;
                    isAndroidSelected = false;
                    isTimerSelected = true;
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text("Cuenta regresiva para el evento: 31 días")));
                  },
                  icon: Icon(Icons.timer),
                  color: isTimerSelected ? Colors.indigo : Colors.black),
              IconButton(
                  onPressed: () {
                    isPersonSelected = false;
                    isIphoneSelected = false;
                    isAndroidSelected = true;
                    isTimerSelected = false;
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Llama al número 6666666")));
                  },
                  icon: Icon(Icons.phone_android),
                  color: isAndroidSelected ? Colors.indigo : Colors.black),
              IconButton(
                  onPressed: () {
                    isPersonSelected = false;
                    isIphoneSelected = true;
                    isAndroidSelected = false;
                    isTimerSelected = false;
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Llama al celular 444444")));
                  },
                  icon: Icon(Icons.phone_iphone,
                      color: isIphoneSelected ? Colors.indigo : Colors.black))
            ])
          ])),
    );
  }
}
