
class UserAccount{
  late String username,password,name,phoneNumber;
  late String id;

  UserAccount(this.username, this.password,this.name,this.phoneNumber);

  UserAccount.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['Password'];
    id = json['id'];
    name=json['name'];

    phoneNumber=json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['Password'] = this.password;
    data['id'] = this.id;
    data['name']=this.name;
    data['phoneNumber']=this.phoneNumber;
    return data;
  }
}