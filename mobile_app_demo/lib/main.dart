import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'GSE Gamma Team Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
          alignment: Alignment.topLeft,
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/map.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            trashButton(190.0, 105.0),
            trashButton(85.0, 230.0),
            trashButton(250.0, 350.0),
            trashButton(185.0, 330.0),
            trashButton(100.0, 460.0),
            trashButton(280.0, 460.0),
            Padding(
              padding: const EdgeInsets.only(left: 230.0, top: 340.0),
              child: Container(
                width: 40.0,
                height: 40.0,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/location.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ]
      ),
    );
  }

  Widget trashButton(x, y) {

    return Padding(
      padding: EdgeInsets.only(left: x, top: y),
      child: SizedBox(
        height: 40.0,
        width: 40.0,
        child: IconButton(
          icon: Image.asset('assets/trash_bin.png'),
          iconSize: 35,
          onPressed: () async {
            await showPopUpUp(context);
          },
        ),
      ),
    );
  }

  Future<Widget> showPopUpUp(BuildContext context) async {

    return await showDialog(
        context: context,
        builder: (context) {
          String? fullness;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text('Trash Bin Report'),
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Selected the trash bin status:"),
                      RadioListTile(
                        title: const Text("Empty"),
                        value: "empty",
                        groupValue: fullness,
                        onChanged: (value) { setState(() { fullness = value.toString(); });},
                      ),
                      RadioListTile(
                        title: const Text("Almost empty"),
                        value: "almost_empty",
                        groupValue: fullness,
                        onChanged: (value) { setState(() { fullness = value.toString(); });},
                      ),
                      RadioListTile(
                        title: const Text("Half full"),
                        value: "half_empty",
                        groupValue: fullness,
                        onChanged: (value) { setState(() { fullness = value.toString(); });},
                      ),
                      RadioListTile(
                        title: const Text("Almost full"),
                        value: "almost_full",
                        groupValue: fullness,
                        onChanged: (value) { setState(() { fullness = value.toString(); });},
                      ),
                      RadioListTile(
                        title: const Text("Full"),
                        value: "full",
                        groupValue: fullness,
                        onChanged: (value) { setState(() { fullness = value.toString(); });},
                      ),
                    ],
                  )
              ),
              actions: <Widget>[
                TextButton (
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.green[600], // Text Color
                  ),
                  child: const Text('Send'),
                ),
                TextButton (
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    primary: Theme.of(context).primaryColor, // Text Color
                  ),
                  child: const Text('Close'),
                ),
              ],
            );}
          );}
    );
  }
}


