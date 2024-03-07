import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sub1/Features/Authentication/Presentation/Screens/LoginUser.dart';
import 'package:sub1/Features/Authentication/Provider/userData.dart';
import 'package:sub1/Features/Dashboard/Presentation/ExercisePageUi.dart';
import 'package:sub1/Features/Dashboard/Presentation/userProfile.dart';
import 'package:sub1/Features/showProgress/Provider/exerciseTracker.dart';

import '../../Authentication/Bloc/authentication_bloc.dart';
import '../../Authentication/Presentation/Screens/RegisterUser.dart';
import '../../Authentication/bloc/authentication_bloc.dart';
import '../../Settings/Presentation/Screens/seetingsUi.dart';
import '../Bloc/dashboard_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub1/Data/Models/ExerciseCategory.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final DashboardBloc dashboardBloc = DashboardBloc();
  late UserDetails userDetails;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Now, you can use completedExercises as needed in your initState
    userDetails = UserDetails();
    userDetails.loadUserDataLocally();
    dashboardBloc.add(DashboardInitialEvent(exerciseCategory: listone));
  }

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserDetails>(context);

    return BlocConsumer<DashboardBloc, DashboardState>(
      bloc: dashboardBloc,
      listenWhen: (previous, current) => current is DashboardActionState,
      buildWhen: (previous, current) => current is! DashboardActionState,
      listener: (context, state) {
        if (state is LoadExercises) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ExercisePage(exercises: state.exercisesRelatedToCategory),
              ));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case DashboardLoaded:
            final dashboardState = state as DashboardLoaded;
            ExerciseTrack exerciseTrack = Provider.of<ExerciseTrack>(context);

            return Scaffold(
                backgroundColor: Colors.grey.shade50,
                appBar: AppBar(
                  title: Row(
                    children: [
                      SizedBox(
                        width: 60,
                      ),
                      Text(
                        "Home",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 23),
                      ),
                      SizedBox(
                        width: 90,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DisplayUserDataScreen(),
                              ));
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                drawer: Drawer(
                  backgroundColor: Colors.white,
                  child: ListView(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            child: ListTile(
                              trailing: Icon(Icons.home),
                              title: Text(
                                "Home",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          child: ListTile(
                            trailing: Icon(Icons.settings),
                            title: Text(
                              "Settings",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: SettingsPage()),
                      Divider(),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          // _authenticationBloc.add(Logout());
                          final auth = FirebaseAuth.instance;
                          auth.signOut();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Logged Off"),backgroundColor: Colors.green,));
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginUser(),), (route) => false);

                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            child: ListTile(
                              trailing: Icon(Icons.logout),
                              title: Text(
                                "Log Out",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                ),
                body: SafeArea(
                    child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      //dashboard header
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hi ${userDetails.name} ,",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "     Get in Shape",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),

                      //yoga widget
                      Center(
                        child: Container(
                          child: Column(
                            children: [
                              Image.asset(
                                  width: 600, height: 250, "assets/yoga.gif"),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Yoga is a skill in action-The Bhagavad Gita.",
                                style: TextStyle(
                                    fontSize: 16, fontStyle: FontStyle.italic),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                  style: ButtonStyle(
                                      foregroundColor: MaterialStatePropertyAll(
                                          Colors.white),
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.black)),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ExercisePage(
                                            exercises: Yoga,
                                          ),
                                        ));
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Get Started",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Icon(Icons.arrow_forward)
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),

                      // ====popular exercies=====
                      Container(
                        width: 450,
                        height: 300,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Popular Exercises",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                color: Colors.grey.shade50,
                                height: 200,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: listone.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Material(
                                            elevation: 10,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: InkWell(
                                              onTap: () {
                                                dashboardBloc.add(
                                                    exerciseCateoryClickedEvent(
                                                        exercisesRelatedToCategory:
                                                            dashboardState
                                                                .categories[
                                                                    index]
                                                                .categoryWiseExercise));
                                              },
                                              child: Container(
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: Colors.white),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.white,
                                                            blurRadius: 3,
                                                            spreadRadius: 3)
                                                      ]),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Image.asset(
                                                            width: 50,
                                                            "${listone[index].imagePath}"),
                                                        Text(
                                                          "${listone[index].categoryName}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          "${listone[index].ExercisesCount} Workouts",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(Icons
                                                                .watch_later),
                                                            Text("1 hr 20 min")
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      // =========dashobaord stats
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "List of Exercise completed so far..",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            SizedBox(height:15,),
                            Consumer<ExerciseTrack>(
                              builder: (context, provider, child) {
                                return Container(
                                    height: 500,
                                    child: ListView.builder(
                                      itemCount: provider
                                          .completedExercisesByDate.length,
                                      itemBuilder: (context, index) {
                                        String date = provider
                                            .completedExercisesByDate.keys
                                            .elementAt(index);
                                        List<String> exercises = provider
                                            .completedExercisesByDate[date]!;

                                        return Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  width: 300,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Date: $date",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16),
                                                      ),
                                                      Divider(
                                                        color: Colors.orange,
                                                        thickness: 5,
                                                      ),
                                                      for (String exercise
                                                          in exercises)
                                                        Container(
                                                          height: 80,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade100,
                                                                  width: 2.5)),
                                                          child: Center(
                                                            child: ListTile(
                                                              title: Text(
                                                                exercise,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                              trailing: Icon(
                                                                Icons.check,
                                                                color: Colors
                                                                    .green,
                                                                size: 30,
                                                              ),
                                                              // Add more ListTile customization if needed
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ));
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )));
          case LoadExercises:
            final exerciseState = state as LoadExercises;
            return Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    Text("${exerciseState.exercisesRelatedToCategory[0]}")
                  ],
                ),
              ),
            );
          default:
            return Scaffold(
              body: SafeArea(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    // Center(child: Text("Welcome to dashboard,")),
                    // SizedBox(height: 50,),
                    // Text("${userDataProvider.emailAddress}"),
                    // SizedBox(height: 20,),
                    // Container(
                    //   height: 500,
                    //   child:   Consumer<ExerciseTrack>(
                    //     builder: (context, exerciseTrack, child) {
                    //       return Text("Completed Exercises: ${exerciseTrack.completedExercises[0]}");
                    //     },
                    //   ),
                    // )
                  ],
                ),
              )),
            );
        }
      },
    );
  }
}
