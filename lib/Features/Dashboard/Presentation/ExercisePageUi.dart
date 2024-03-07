import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub1/Features/Playaudio/Presentation/timerUi.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../Data/Models/exercise.dart';
import '../../../Data/Repository/QuotesApi/fetch_quotes_bloc.dart';

class ExercisePage extends StatefulWidget {
  List<Exercise> exercises = [];

  ExercisePage({required this.exercises});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  final AudioPlayer a1 = AudioPlayer();

  final CountdownController _controller = CountdownController();
  final FetchQuotesBloc _quotes = FetchQuotesBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _quotes.add(StartFetchingQuotesEvent());
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FetchQuotesBloc, FetchQuotesState>(
      bloc: _quotes,
      buildWhen: (previous, current) => current is FetchQuotesState,
  listener: (context, state) {

  },
  builder: (context, state) {

    switch (state.runtimeType){

      case FailedFetchedQuotesState:
        return Scaffold(
          body: Center(child: Text("Please Ensure your internet is working")),
        );

      case SuccessfullyFetchedQuotesState:
        List<Map<String, dynamic>> quotes = (state as SuccessfullyFetchedQuotesState).quotes;
        return Scaffold(
          body: SafeArea(child:Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20,),
                  Text("Start you Workout",style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize:25
                  ),),
                  SizedBox(height: 20,),
                  Container(
                    height: 800,
                    child: ListView.builder(itemCount: widget.exercises.length,itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => TimerUi(quotes:quotes[index],name:widget.exercises[index].exerciseName,exercisePath: widget.exercises[index].exerciseGif,),));
                            },
                            child: Container(width:MediaQuery.of(context).size.width-20,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey
                                  ),
                                  borderRadius: BorderRadius.circular(20)

                              )


                              ,child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("${widget.exercises[index].exerciseName}",style: TextStyle(
                                          fontWeight: FontWeight.bold,fontSize:18
                                      ),),
                                      SizedBox(width:30,),
                                      Image.asset(fit: BoxFit.cover,width:150,"${widget.exercises[index].exerciseGif}")
                                    ],
                                  ),

                                ],
                              ),),
                          ),
                          SizedBox(height: 20,),
                        ],
                      );
                    },),
                  ),
                  InkWell(onTap: (){
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => TimerUi(name: widget.exercises[0].exerciseName,),));
                  },child: Text("${widget.exercises[0].exerciseName}")),



                ],
              ),
            ),
          )),
        );

      default:
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
    }
  },
);
  }
}
