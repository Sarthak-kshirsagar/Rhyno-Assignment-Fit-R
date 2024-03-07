import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Authentication/Provider/userData.dart';


class DisplayUserDataScreen extends StatefulWidget {
  @override
  State<DisplayUserDataScreen> createState() => _DisplayUserDataScreenState();
}

class _DisplayUserDataScreenState extends State<DisplayUserDataScreen> {

  Future<void> loadUserDataLocally() async {
    var userDetails = Provider.of<UserDetails>(context, listen: false);
    await userDetails.loadUserDataLocally();
    // Notify listeners after loading data
    userDetails.notifyListeners();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUserDataLocally();

  }
  @override
  Widget build(BuildContext context) {
    var userDetails = Provider.of<UserDetails>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile',style: TextStyle(
          fontWeight: FontWeight.bold,
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(

                children: [
                  CircleAvatar(
                    radius:50,
                    child: Icon(size:50,Icons.person),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 50,
                      child: InkWell(
                        onTap: () async{
                          await userDetails.loadUserDataLocally();
                          // Notify listeners after loading data
                          userDetails.notifyListeners();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: 50,
                              child: Icon(Icons.refresh),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              width:300,
              child: Column(

                children: [
                  Row(
              mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.person_pin_outlined),
                      SizedBox(width: 40,),
                      Text('${userDetails.name}',style: TextStyle(
                        fontSize:15,letterSpacing:1
                      ),),

                    ],
                  ),
                  Divider()

                ],
              ),
            ),
            Container(
              width:300,
              child: Column(

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.phone),
                      SizedBox(width: 40,),
                      Text('${userDetails.number}',style: TextStyle(
                          fontSize:15,letterSpacing:1
                      ),),

                    ],
                  ),
                  Divider()

                ],
              ),
            ),


            profileFields("assets/message.png","${userDetails.emailAddress}"),
            profileFields("assets/user.png","${userDetails.sex}"),
            profileFields("assets/growth.png","${userDetails.age}"),
            profileFields("assets/weighing-machine.png","${userDetails.weight}"),
            profileFields("assets/height.png","${userDetails.height}"),



          ],
        ),
      ),
    );
  }

  Widget profileFields(imagePath,text){
    return  Container(
      width:300,
      child: Column(

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(width:40,"${imagePath}"),
              SizedBox(width: 20,),
              Text('${text}',style: TextStyle(
                  fontSize:15,letterSpacing:2
              ),),

            ],
          ),
          Divider()

        ],
      ),
    );
  }
}
