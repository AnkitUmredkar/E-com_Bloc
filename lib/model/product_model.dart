class ProductModel{
  late String name,subTitle;
  late int quantity,price;

  ProductModel({required this.name,required this.subTitle,required this.quantity,required this.price});

  factory ProductModel.fromMap(Map m1){
    return ProductModel(name: m1["name"], subTitle: m1["subtitle"], quantity: m1["quantity"], price: m1["price"], );
  }
}