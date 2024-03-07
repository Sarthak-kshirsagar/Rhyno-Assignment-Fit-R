import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sub1/Features/Authentication/Presentation/Screens/LoginUser.dart';
import 'package:sub1/Features/Dashboard/Presentation/dashboard.dart';
import 'Data/Repository/QuotesApi/fetch_quotes_bloc.dart';
import 'Features/Authentication/Bloc/authentication_bloc.dart';

import 'Features/Authentication/Provider/userData.dart';
import 'Features/Dashboard/Bloc/dashboard_bloc.dart';
import 'Features/Playaudio/Bloc/play_audio_bloc.dart';
import 'Features/Settings/Provider/settingsProvder.dart';
import 'Features/showProgress/Provider/exerciseTracker.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        MultiBlocProvider(
          providers: [

            //Authentication bloc which hnadles all the communication with firebase
            BlocProvider<AuthenticationBloc>(
                create: (context) => AuthenticationBloc()),
            BlocProvider(create: (context) => FetchQuotesBloc(),),

            /*
            DashboardBloc which the logic to build the dashobard
            and load the required exercises

    */
            BlocProvider<DashboardBloc>(create: (context) => DashboardBloc(),),

            //PlayAudioBloc handles all the logic regarding playing the background audio
            BlocProvider<PlayAudioBloc>(create: (context) => PlayAudioBloc(),)
          ],


          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: WelcomePage()
          ),
        ),

        // Privider to store the user details during first time registration
        ChangeNotifierProvider(create: (context) => UserDetails(),),
        // Exercise Track provider to store and load the exercise completed on dashboard
        ChangeNotifierProvider(create: (context) => ExerciseTrack(),),

        //Settings Provider to handle wheather to play the background music during exercise
        ChangeNotifierProvider(create: (context) => SettingsProvider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WelcomePage(),
      ),
    ),

  );
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final AuthenticationBloc authBloc = AuthenticationBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authBloc.add(AuthenticationCheck());

  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      buildWhen: (previous, current) => current is !AuthenticationActionState,
      listenWhen: (previous, current) => current is AuthenticationActionState,
      bloc: authBloc,
      listener: (context, state) {
        //If the user is already logged in
        if(state is LoginSuccessState){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard(),));
        }


      },
      builder: (context, state) {
        //If the user is not logged in
        switch(state.runtimeType){
          case LoginUserPageUiState:
            return LoginUser();

          default:
            return Dashboard();


        }

      },
    );
  }
}

