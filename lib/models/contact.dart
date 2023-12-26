class Contact {
  //Table Structure
  static const tblContact = 'contacts';
  static const colId = 'id';
  static const colName = 'name';
  static const colMobile = 'mobile';
  static const colEmail = 'email';
  static const colImg = 'img';
  static const colFavorite = 'favorite';

  Contact({this.id, this.name, this.mobile, this.email, this.img});

  int? id;
  String? name;
  String? mobile;
  String? email;
  String? img;
  int? favorite;

  Contact.fromMap(Map<dynamic, dynamic> map) {
    id = map[colId];
    name = map[colName];
    mobile = map[colMobile];
    email = map[colEmail];
    img = map[colImg];
    favorite = map[colFavorite];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      colName: name,
      colMobile: mobile,
      colEmail: email,
      colImg: img,
      colFavorite: favorite
    };
    if (id != null) map[colId] = id;
    return map;
  }
}
