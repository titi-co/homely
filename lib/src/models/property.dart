class Property {
  Property({
    this.id,
    this.name,
    this.description,
    this.street,
    this.district,
    this.city,
    this.state,
    this.image,
  });

  String? id;
  String? name;
  String? description;
  String? street;
  String? district;
  String? city;
  String? state;
  String? image;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'street': street,
      'district': district,
      'city': city,
      'state': state,
      'image': image,
    };
  }

  Property fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      street: json['street'],
      district: json['district'],
      city: json['city'],
      state: json['state'],
      image: json['image'],
    );
  }
}
