import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sub1/Features/Authentication/Presentation/Screens/LoginUser.dart';
import 'package:sub1/Features/Authentication/Presentation/Widgets/textFields.dart';
import 'package:sub1/Features/Authentication/Provider/userData.dart';

import '../../Bloc/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Widgets/LoginHeader.dart';
import '../Widgets/registrationFailed.dart';
import 'package:sub1/Features/Dashboard/Data/Validation/registerValid.dart';
class UserDetailsUi extends StatefulWidget {
  String emailAddress = '';
  String password = '';
   UserDetailsUi({required this.emailAddress,required this.password});

  @override
  State<UserDetailsUi> createState() => _UserDetailsUiState();
}

class _UserDetailsUiState extends State<UserDetailsUi> {

  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  String selectedGender = 'Male';



  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authBloc = BlocProvider.of<AuthenticationBloc>(context);
    // Accessing the provider in a widget to store the details of the user...

    final userDataProvider = Provider.of<UserDetails>(context);
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();




    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listenWhen: (previous, current) =>current is AuthenticationActionState,
      buildWhen: (previous, current) => current is !AuthenticationActionState,
      listener: (context, state) {
        if(state is RegisterSuccessfulState){
          // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginUser(),));

          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginUser(),), (route) => false);
        }
        if(state is RegistrationFailedSatte){
          errorAlertDialog(context,state.errorMessage);
        }

      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Column(

                  children: [

                    header(),

                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.center,"One More Step",style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize:16,color: Colors.grey,fontStyle: FontStyle.italic
                    ),),
                    SizedBox(height: 20,),
                    Form(key: _formKey,child: Column(
                      children: [





                        inputTextFileds(errorUsernameMessage,"Name", name,isValidUsername),
                        inputTextFileds(errorMobileNumberMessage,"Mobile Number", number,isValidIndianMobileNumber),



                        inputTextFileds(errorAgeMessage,"Age", age,isValidAge),

                        dropDown(),
                        SizedBox(height: 10,),
                        inputTextFileds(errorHeightMessage,"Height", height,isValidHeight),

                        inputTextFileds(errorWeightMessage,"Weight", weight,isValidWeight),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(Colors.black),
                                foregroundColor: MaterialStatePropertyAll(Colors.white)
                            ),onPressed: () async{
                              if(_formKey.currentState!.validate()){
                                userDataProvider.saveUserData(name: name.text.trim(),emailAddress:widget.emailAddress,password: widget.password,height: double.parse(height.text),age: age.text.trim(),number: number.text.trim(),sex: selectedGender,weight: double.parse(weight.text));

                                authBloc.add(RegisterUserEvent(
                                    emailAddress: widget.emailAddress,password: widget.password
                                ));
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registration Successful"),backgroundColor: Colors.green,));

                                await Provider.of<UserDetails>(context, listen: false).saveUserDataLocally();

                              }

                            }, child: Text("Proceed")),
                            SizedBox(width: 20,),
                            if(state is UserCreateLoading)

                            CircularProgressIndicator(),
                          ],
                        ),


                      ],
                    )),
                    SizedBox(height: 10,),





                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
Widget dropDown(){
    return DropdownButton<String>(
      value: selectedGender,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.black, fontSize: 16),
      underline: Container(
        height: 2,
        color: Colors.blue,
      ),
      onChanged: (String? newValue) {
        setState(() {
          selectedGender = newValue!;
        });
      },
      items: <String>['Male', 'Female', 'Other']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
}

}
