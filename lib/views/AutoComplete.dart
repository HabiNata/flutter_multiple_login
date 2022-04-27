import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multiple_login/model/AutoComplete.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AutoComplete extends StatefulWidget {
  // AutoComplete() : super();

  final String title = "AutoComplete Search Flutter";
  final VoidCallback signOut;
  @override
  AutoComplete(this.signOut);
  State<AutoComplete> createState() => _AutoCompleteState();
}

class _AutoCompleteState extends State<AutoComplete> {
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<Product>> key = new GlobalKey();
  static List<Product> products = new List<Product>();
  bool loading = true;

  void getUsers() async {
    try {
      // final response = await http
      //     .get(Uri.parse("http://mobilelanjutan.my.id/api/data_barang.php"));
      final response = await http.get(Uri.parse(
          "http://192.168.100.75/api_multiple_login/api/autocomplete.php"));
      if (response.statusCode == 200) {
        products = loadUsers(response.body);
        print('Products: ${products.length}');
        setState(() {
          loading = false;
        });
      } else {
        print("Error getting product.");
      }
    } catch (e) {
      print("Error getting data api.");
    }
  }

  static List<Product> loadUsers(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<Product>((json) => Product.fromJson(json)).toList();
  }

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  Widget row(Product product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          product.nama_barang,
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          product.harga,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          loading
              ? CircularProgressIndicator()
              : searchTextField = AutoCompleteTextField<Product>(
                  key: key,
                  clearOnSubmit: false,
                  suggestions: products,
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                    hintText: "Cari Product",
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                  itemFilter: (item, query) {
                    return item.nama_barang
                        .toLowerCase()
                        .startsWith(query.toLowerCase());
                  },
                  itemSorter: (a, b) {
                    return a.nama_barang.compareTo(b.nama_barang);
                  },
                  itemSubmitted: (item) {
                    setState(() {
                      searchTextField.textField.controller.text =
                          item.nama_barang;
                    });
                  },
                  itemBuilder: (context, item) {
                    return row(item);
                  },
                ),
        ],
      ),
    );
  }
}
