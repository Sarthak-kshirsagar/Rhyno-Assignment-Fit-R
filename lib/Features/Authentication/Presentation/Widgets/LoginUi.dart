// import 'package:flutter/material.dart';
// import 'package:sub1/Features/Authentication/Presentation/Widgets/textFields.dart';
//
// class LoginPageUi extends StatefulWidget {
//   const LoginPageUi({super.key});
//
//   @override
//   State<LoginPageUi> createState() => _LoginPageUiState();
// }
//
// class _LoginPageUiState extends State<LoginPageUi> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: SafeArea(
//         child: Column(
//           children: [
//             Text("Welcome back! Please login"),
//             inputTextFileds("Email Address", emailAddress),
//             SizedBox(
//               height: 10,
//             ),
//             inputTextFileds("Password", password),
//             SizedBox(
//               height: 10,
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   authBloc.add(LoginAuthenticatedUserEvent(
//                     emailAddress: emailAddress.text,
//                     password: password.text,
//                   ));
//                 },
//                 child: Text("Login")),
//             SizedBox(
//               height: 10,
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   authBloc.add(RegisterationInitialEvent());
//                 },
//                 child: Text("New User? Register"))
//           ],
//         ),
//       ),
//     );;
//   }
// }
