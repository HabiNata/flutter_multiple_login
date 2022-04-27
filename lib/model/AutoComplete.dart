class Product {
  String id_barang;
  String nama_barang;
  String harga;

  Product({this.id_barang, this.nama_barang, this.harga});

  factory Product.fromJson(Map<String, dynamic> parsedJson) {
    return Product(
      id_barang: parsedJson["id_barang"],
      nama_barang: parsedJson["nama_barang"] as String,
      harga: parsedJson["harga"] as String,
    );
  }
}
