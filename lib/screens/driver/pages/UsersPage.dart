import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UsersPage extends StatefulWidget {
  // UsersPage({Key key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {

    Future<List<User>> _getUsers() async{
    

    var data = await http.get("http://brandexcontractorsltd.com/api/generated.json");

    var jsonData = json.decode(data.body);

    List<User> users = [];

    for (var u in jsonData){

      User user = User(u["firstname"], u["lastname"], u["phone"], u["email"], u["dateofbirth"], u["sex"], u["picture"], u["address"], u["stateoforigin"], u["lga"], u["qualification"], u["gname"], u["gaddress"], u["relationship"], u["space"]);

      users.add(user);
    }

    print(users.length);

    return users;
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("User Page"),
      ),
      body: new SafeArea(
          top: false,
          bottom: false,

          child: FutureBuilder(
           future: _getUsers(),
           builder: (BuildContext context, AsyncSnapshot snapshot){

             if(snapshot.data == null){
               return Container(
                 child: Center(
                   child: Text("Loading...")
                   )
               );
             } else {
             return ListView.builder(
               itemCount: snapshot.data.length,
               itemBuilder: (BuildContext context, int index){
                 return ListTile(
                   leading: CircleAvatar(
                     backgroundImage: NetworkImage(
                       snapshot.data[index].picture
                     ),
                   ),
                   title: Text(snapshot.data[index].firstname + (snapshot.data[index].space) + (snapshot.data[index].lastname)),
                   subtitle: Text(snapshot.data[index].email),
                   onTap: (){
                     Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => DetailPage(snapshot.data[index]))
                     );
                   },
                 );
               },
               );
             }
           },
         ),
      ),
    );
  }
}





class DetailPage extends StatelessWidget {

  final User user;

  DetailPage(this.user);


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(user.firstname + user.space + user.lastname),
      ),
      body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
              autovalidate: true,
              child: new ListView(
                // padding: const EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                  child: CircleAvatar(
                      radius: 100,
                      backgroundColor: Color(0xff476cfb),
                      child: ClipOval(
                        child: new SizedBox(
                          width: 180.0,
                          height: 180.0,
                          child: Image.network(
                            user.picture,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                ),

                SizedBox
                  (
                    height: 20.0,
                  ),

                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Full Name',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 17.0)),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(user.firstname + user.space + user.lastname,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox
                  (
                    height: 20.0,
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Phone',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 17.0)),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(user.phone,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox
                  (
                    height: 20.0,
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Date of Birth',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 17.0)),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(user.dateofbirth,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox
                  (
                    height: 20.0,
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Sex',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 17.0)),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(user.sex,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox
                  (
                    height: 20.0,
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Address',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 17.0)),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(user.address,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox
                  (
                    height: 20.0,
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('State of Orgin',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 17.0)),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(user.stateoforigin,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox
                  (
                    height: 20.0,
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('L.G.A',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 17.0)),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(user.lga,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox
                  (
                    height: 20.0,
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Qualification',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 17.0)),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(user.qualification,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox
                  (
                    height: 20.0,
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Guarantor Name',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 17.0)),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(user.gname,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox
                  (
                    height: 20.0,
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Guarantor Address',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 17.0)),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(user.gaddress,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox
                  (
                    height: 20.0,
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Relationship',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 17.0)),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(user.relationship,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox
                  (
                    height: 20.0,
                  ),

                  
                ],
              ))),
    );
  }
}












class User {
  final String firstname;
  final String lastname;
  final String phone;
  final String email;
  final String dateofbirth;
  final String sex;
  final String picture;
  final String address;
  final String stateoforigin;
  final String lga;
  final String qualification;
  final String gname;
  final String gaddress;
  final String relationship;
  final String space;


  User(this.firstname, this.lastname, this.phone, this.email, this.dateofbirth, this.sex, this.picture, this.address, this.stateoforigin, this.lga, this.qualification, this.gname, this.gaddress, this.relationship, this.space);

  
}