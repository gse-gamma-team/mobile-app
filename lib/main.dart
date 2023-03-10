import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'PhotoReport.dart';


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
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToPhotoReport,
        tooltip: 'PhotoReport',
        child: const Icon(Icons.report_problem),
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
            bool permission = await _getCurrentPosition();
            if(permission) {
              await showTrashReport(context);
            }
          },
        ),
      ),
    );
  }

  Future<Widget> showTrashReport(BuildContext context) async {

    return await showDialog(
        context: context,
        builder: (context) {
          String? pickup;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text('Trash Bin Report'),
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Selected the trash bin status:"),
                      const SizedBox(height: 10.0,),
                      RadioListTile(
                        title: const Text("Needs Pick Up"),
                        value: "pickup",
                        groupValue: pickup,
                        onChanged: (value) { setState(() { pickup = value.toString(); });},
                      ),
                      RadioListTile(
                        title: const Text("Doesn't Need Pick Up"),
                        value: "no_pickup",
                        groupValue: pickup,
                        onChanged: (value) { setState(() { pickup = value.toString(); });},
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

  Future<bool> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    return hasPermission;
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future navigateToPhotoReport() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const PhotoReport(title: "Photo Report",)));
  }
}


