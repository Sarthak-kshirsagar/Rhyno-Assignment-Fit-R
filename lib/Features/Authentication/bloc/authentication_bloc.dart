import 'dart:async';


import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

//Authentication Bloc to handle the communication between firebase and app
class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  AuthenticationBloc() : super(AuthenticationInitialState()) {
    on<AuthenticationCheck>(_checkUserSignedIn);
    on<AuthenticationInitialEvent>(authenticationIntialFunc);

    on<RegisterationInitialEvent>(registerInitialFunc);

    on<RegisterUserEvent>(registerUserFunc);

    on<LoginAuthenticatedUserEvent>(loginUserFucn);

    on<Logout>(_logOutUser);
  }

  //emitted when user is logged of

  FutureOr<void> authenticationIntialFunc(AuthenticationInitialEvent event, Emitter<AuthenticationState> emit) {
  try {
    print("Authentication initial state");
    emit(AuthenticationInitialState());
  }catch (e){
    print("heyyyyyyy");
    print("Error logging in ${e}");
    emit(LoginFailedState(errorMessage: "${e}"));

  }
  
  }

  //Emitted when the user clicks on register button for the firestime
  FutureOr<void> registerUserFunc(RegisterUserEvent event, Emitter<AuthenticationState> emit) async{
    try{

      print("inside regoster user func");
      await auth.createUserWithEmailAndPassword(email: "${event.emailAddress}", password: "${event.password}");
      emit(UserCreateLoading());
      Future.delayed(Duration(seconds:10));
      emit(RegisterSuccessfulState());
    }catch (e){
      print("error occured while registering");
    emit(RegistrationFailedSatte(errorMessage: "${e}"));
    }

  }

  //Emiited when the user sign in with valid credentials
  FutureOr<void> loginUserFucn(LoginAuthenticatedUserEvent event, Emitter<AuthenticationState> emit) async{

    try{
      await auth.signInWithEmailAndPassword(email: "${event.emailAddress}", password: "${event.password}");

        emit(LoginSuccessState());
    }catch (e){
      print("heyyyyy");
      print("Error occured while logging in");
      emit(LoginFailedState(errorMessage: "${e}"));
      print("emiited");
    }

  }

  FutureOr<void> registerInitialFunc(RegisterationInitialEvent event, Emitter<AuthenticationState> emit) {
  print("Registration initial Scree");
  emit(RegIniti());

  }


  //used to check wheather the user is already logged in,if yes then emits the state and user redirects to dashboard
  FutureOr<void> _checkUserSignedIn(AuthenticationCheck event, Emitter<AuthenticationState> emit) {
        try {
          final user = auth.currentUser;
          if(user!=null){
            emit(LoginSuccessState());
          }else{
            emit(LoginUserPageUiState());
          }
        }  catch (e) {
          print("error occured ${e}");
        }

  }

  //signout the user
  FutureOr<void> _logOutUser(Logout event, Emitter<AuthenticationState> emit) {
        try{
          auth.signOut();
          emit(LoginUserPageUiState());
        }catch(e){
          print("erorr in logging off");
          print(e);
        }

  }
}
