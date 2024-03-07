import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sub1/Features/Authentication/Presentation/Screens/LoginUser.dart';
import 'package:sub1/Features/Authentication/Presentation/Screens/userDetailsForm.dart';
import 'package:sub1/Features/Authentication/Presentation/Widgets/textFields.dart';
import 'package:sub1/Features/Authentication/Provider/userData.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

import '../../Bloc/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Widgets/LoginHeader.dart';
import '../Widgets/registrationFailed.dart';
import 'package:sub1/Features/Dashboard/Data/Validation/registerValid.dart';
class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();



  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authBloc = BlocProvider.of<AuthenticationBloc>(context);
    // Accessing the provider in a widget to store the details of the user...

    final userDataProvider = Provider.of<UserDetails>(context);

    //to validate the form
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();




    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listenWhen: (previous, current) =>current is AuthenticationActionState,
      buildWhen: (previous, current) => current is !AuthenticationActionState,
      listener: (context, state) {
        if(state is RegisterSuccessfulState){
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginUser(),));
        }
        if(state is RegistrationFailedSatte){
          // errorAlertDialog(context,state.errorMessage);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to Register"),backgroundColor: Colors.red,));
        }

      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Column(

                  children: [
                  SizedBox(height: 20,),

                    // =============

                    header(),

                    // ===============

                    Text(textAlign: TextAlign.center,"Namaste..!",style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize:16
                    ),),
                  SizedBox(height: 20,),

                    // ==========================

                    Text(textAlign: TextAlign.center,"Register using \n Email Address & Password",style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize:16,color: Colors.grey,fontStyle: FontStyle.italic
                    ),),


                  SizedBox(height: 20,),


                  // ========================================

                  Form(key: _formKey,child: Column(
                    children: [




                      inputTextFileds(errorEmailMessage,"Email Address", emailAddress,isValidEmail),
                      inputTextFileds(errorPasswordMessage,"Password", password,isValidPassword),


                      ElevatedButton(style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.black),
                        foregroundColor: MaterialStatePropertyAll(Colors.white)
                      ),onPressed: () async{
                        if(_formKey.currentState!.validate()){


                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.green,content: Text("Please Fill the above details to complete Registration.")));
                          Navigator.push(context,SwipeablePageRoute(builder: (context) => UserDetailsUi(emailAddress: emailAddress.text.trim(), password: password.text.trim()),));

                        }

                      }, child: Text("Register")),
                    ],
                  )),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text("Already a User ?",style: TextStyle(),),
                        SizedBox(width: 20,),
                        InkWell(
                          onTap: (){

                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginUser(),), (route) => false);
                            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterUser(),));
                          },
                          child: Text("Login",style: TextStyle(
                              fontWeight: FontWeight.bold,color: Colors.blue,fontSize: 16
                          ),),
                        ),

                      ],
                    )



                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }


}
