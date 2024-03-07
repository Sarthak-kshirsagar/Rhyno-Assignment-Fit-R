import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sub1/Features/Authentication/Presentation/Screens/RegisterUser.dart';
import 'package:sub1/Features/Authentication/Presentation/Widgets/textFields.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub1/Features/Dashboard/Presentation/dashboard.dart';

import '../../../Dashboard/Data/Validation/registerValid.dart';
import '../../Bloc/authentication_bloc.dart';
import '../Widgets/LoginHeader.dart';
import '../Widgets/registrationFailed.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {

  //text editing controllers for email and password
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();

  //to validate the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    //created the auth bloc to access all the events,satates
    final AuthenticationBloc authBloc = AuthenticationBloc();

    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      bloc: authBloc,
      listenWhen: (previous, current) => current is AuthenticationActionState,
      buildWhen: (previous, current) => current is! AuthenticationActionState,
      listener: (context, state) {

        // Navigate to register the new user
        if (state is RegIniti) {

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterUser(),));

          //if Authentication details are correct then user will be redirected to the dashboard
        } else if (state is LoginSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Logged In"),backgroundColor: Colors.green,));
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Dashboard(),), (route) => false);
        }


        //If the error occurs while logging in
        else if(state is LoginFailedState){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Credentials"),backgroundColor: Colors.red,));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          default:
            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(

                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [


                        header(),
                        Text(textAlign: TextAlign.center,"Welcome back ! \nPlease login",style: TextStyle(
                          fontWeight: FontWeight.bold,fontSize:16
                        ),),
                        SizedBox(height:20,),

                        SizedBox(height:10,),
                       Form(key: _formKey,child: Column(children: [
                         SizedBox(
                           height: 10,
                         ),
                         inputTextFileds(errorEmailMessage,"Email Address", emailAddress,isValidEmail),
                         inputTextFileds(errorPasswordMessage,"Password", password,isValidPassword),
                         SizedBox(
                           height: 10,
                         ),
                         ElevatedButton(
                           style: ButtonStyle(
                             backgroundColor: MaterialStatePropertyAll(Colors.black),
                            foregroundColor: MaterialStatePropertyAll(Colors.white)
                           ),
                             onPressed: () {
                              if(_formKey.currentState!.validate()){
                                authBloc.add(LoginAuthenticatedUserEvent(
                                  emailAddress: emailAddress.text,
                                  password: password.text,
                                ));

                              }
                             },
                             child: Text("Login")),
                         SizedBox(
                           height: 50,
                         ),


                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [

                             Text("New User?",style: TextStyle(),),
                             SizedBox(width: 20,),
                             InkWell(
                               onTap: (){
                                 authBloc.add(RegisterationInitialEvent());
                               },
                               child: Text("Register Now",style: TextStyle(
                                 fontWeight: FontWeight.bold,color: Colors.blue,fontSize: 16
                               ),),
                             ),

                           ],
                         )
                       ],))
                      ],
                    ),
                  ),
                ),
              ),
            );
        }
      },
    );
  }
}
