import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  final VoidCallback signOut;
  @override
  AdminPage(this.signOut);
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.orange,
        title: Text('Administrator Page'),
        actions: <Widget>[
          new IconButton(
            icon: Icon(Icons.double_arrow),
            color: Colors.white,
            onPressed: () {
              signOut();
            },
          )
        ],
      ),
      body: Center(child: Text("Halaman Admin")),
    );
  }
}
