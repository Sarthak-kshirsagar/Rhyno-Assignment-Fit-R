import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../Settings/Provider/settingsProvder.dart';
import '../../showProgress/Provider/exerciseTracker.dart';


class TimerUi extends StatefulWidget {
  String? name;
  String? exercisePath;
 Map<String,dynamic> quotes;
  TimerUi({required this.quotes,required this.exercisePath,required this.name});

  @override
  State<TimerUi> createState() => _TimerUiState();
}

class _TimerUiState extends State<TimerUi> {
  final AudioPlayer a1 = AudioPlayer();
  final CountdownController _controller = CountdownController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("printing the auotessss");
    print(widget.quotes);
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        a1.stop();
      },
      child: Scaffold(
        body: SafeArea(child:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Image.asset(width: 300,"${widget.exercisePath}")),
              SizedBox(height:30,),
              Text("${widget.name}",style: TextStyle(
                fontWeight: FontWeight.bold,fontSize: 18
              ),),
              SizedBox(height:20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(textAlign: TextAlign.center,"${widget.quotes['quote']}",style:TextStyle(fontStyle: FontStyle.italic) ,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(textAlign: TextAlign.center,"- ${widget.quotes['author']}",style:TextStyle(fontStyle: FontStyle.italic) ,),
              ),
              SizedBox(height:20,),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green),
                  foregroundColor: MaterialStatePropertyAll(Colors.white)
                ),
                onPressed: () async{
                  // Start the timer when the button is clicked
                  var settingsProvider = context.read<SettingsProvider>();
                  if(settingsProvider.backgroundMusicEnabled){
                    // await a1.play(UrlSource("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"));
                    await a1.play(AssetSource("onsong.mp3"));
                  }

                  _controller.restart();

                },
                child: Text("Start Timer",),
              ),
              SizedBox(height: 20,),
              CircleAvatar(
                backgroundColor: Colors.orange,
                radius:35,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius:30,

                  child: Countdown(
                    controller: _controller,
                    seconds:35,
                    build: (BuildContext context, double time) => Text(time.toString()),
                    interval: Duration(seconds: 1),

                    onFinished: () async{
                      print("name is ${widget.name}");
                      await a1.pause();
                      ExerciseTrack exerciseTrack = Provider.of<ExerciseTrack>(context, listen: false);

                      exerciseTrack.addToCompletedExercise(widget.name.toString());

                      print("printing the listt");
                      // print(e1.completedExercises[0]);

                      _showDia(context);
                      Future.delayed(Duration(seconds:5),() {
                        Navigator.pop(context);
                       Future.delayed(Duration(seconds:1),() {
                         Navigator.pop(context);
                       },);
                      },);
                    },
                  ),
                ),
              ),

            ],
          ),
        )),
      ),
    );
  }

  void _showDia(BuildContext context){
   showDialog(useSafeArea: true,context: context, builder: (context) {

      return
        AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2))),

          contentPadding: EdgeInsets.all(0),

          content: Container(
            height:130,
            color: Colors.white,
            child: Column(
              children: [
                Image.asset(width:120,"assets/check.gif"),

                Text("Keep Going",style: TextStyle(
                    fontWeight: FontWeight.bold,fontSize: 16
                ),),
              ],
            ),
          ),
        );
    },);
  }
}
