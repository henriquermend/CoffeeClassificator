class CoffeBean {
  final String id;
  final String name;
  final String description;
  final String imageUrl;

  CoffeBean({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  factory
 CoffeBean.fromJson(Map<String,dynamic> json){
  return CoffeBean(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    imageUrl: json['imageUrl'],
  );
 } 
}
