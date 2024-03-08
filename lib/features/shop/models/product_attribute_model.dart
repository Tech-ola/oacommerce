class ProductAttributeModel {
  String? name;
  final List<String>? values;

  ProductAttributeModel({this.name, this.values});

  // JSON format 
  toJson(){
    return {'Name' : name, 'Values' : values};
  }

  // Map JSON oriented document 
  factory ProductAttributeModel.fromJson(Map<String, dynamic> document){
    final data = document;

    if(data.isEmpty) return ProductAttributeModel();

    return ProductAttributeModel(
      name: data.containsKey('Name') ? data['Name'] : '',
      values: List<String>.from(data['Values']),
    );
  }
}