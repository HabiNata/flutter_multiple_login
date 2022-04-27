import 'package:flutter/material.dart';

class CustomerPage extends StatefulWidget {
  final VoidCallback signOut;
  @override
  CustomerPage(this.signOut);
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
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
        title: Text('Customer Page'),
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
      body: Center(child: Text("Halaman Customer")),
    );
  }
}
