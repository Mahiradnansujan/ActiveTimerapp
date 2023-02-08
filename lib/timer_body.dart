import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:timerapp/timer.dart';
import 'package:timerapp/timer_model.dart';
class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
CountDownTimer work = CountDownTimer(workName: "Work", workTime: 30);
CountDownTimer shortBreak = CountDownTimer(workName: "Short Break", workTime: 5);
CountDownTimer longBreak=CountDownTimer(workName: "Long Break", workTime: 15);
List<CountDownTimer> listOfCD = [];
int selectedIndex=0;
String _workName="";
String _workTime="";

Future addWorkTimer(BuildContext context){
  return showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text("Add",style: TextStyle(color: Colors.orange),textAlign: TextAlign.center,),
      content: Container(
        height: 150,
      
        child: Column(
          children: [
            TextField(
              onChanged: (String val){
                setState(() {
                  _workName = val;
                });
              } ,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                hintText: "Work Name",
                filled: true,
                fillColor: Colors.yellowAccent,
                focusColor: Colors.purpleAccent,
              ),
            ),
            SizedBox(height: 20,),
            TextField(
               onChanged: (String val){
                setState(() {
                  _workTime = val;
                });
              } ,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                hintText: "Work Time in Minutes",
                filled: true,
                fillColor: Colors.yellowAccent,
                focusColor: Colors.purpleAccent,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: (){
            if(_workName.isNotEmpty && _workTime.isNotEmpty)
            {
              listOfCD.add(CountDownTimer(
                workName: _workName, workTime:int.parse(_workTime)));
            Navigator.of(context).pop();
            }
            },
          child: Text("Add"),
          ),
          TextButton(
          onPressed: (){Navigator.of(context).pop();},
          child: Text("Cancel"),
          ),
      ],
    );
  });
}

  @override
  void initState() {
    listOfCD=[work, shortBreak, longBreak];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TimerModel>(
      stream: listOfCD.isNotEmpty? listOfCD[selectedIndex].stream():null,
      builder: (context, snapshot) {
        return Column(
          children: [
             Padding(
               padding: const EdgeInsets.all(15),
               child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                    ...listOfCD.
                    map((CountDownTimer CountDown) => 
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: InputChip(
                        onPressed: (){
                          CountDown.StartCountDown();
                          
                          setState(() {
                            selectedIndex=listOfCD.indexWhere(
                              (element) => 
                              element.workName==
                            CountDown.workName && 
                            element.workTime ==
                            CountDown.workTime);
                          });


                          },
                           
                           


                        onDeleted: (){
                          selectedIndex= 0;
                          listOfCD.removeAt(listOfCD.indexWhere(
                              (element) => element.workName==
                            CountDown.workName&& 
                            element.workTime ==
                            CountDown.workTime));
                        },
                        deleteIconColor: Colors.white,
                        label: Text(CountDown.workName,
                        style: TextStyle(fontSize: 20,color: Colors.white),),
                       backgroundColor: Colors.blue,
                   
                       ),
                    ),
                     ).toList(),
                     
                     
                 MaterialButton(
                  onPressed: (){addWorkTimer(context);
                  },
                  child: Icon(Icons.add),
                  color: Colors.white,
                 ),
                   ],
                 ),
               ),
             ),
             snapshot.hasData?
            Expanded(
              child: CircularPercentIndicator (
                lineWidth: 10,
                center: Text(
                  snapshot.data!.time,
                  style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold ),),
                radius: 180.0,
                percent: snapshot.data!.percent,
                
                progressColor: Color.fromARGB(255, 236, 222, 17),
                ),
                ):
              
              Expanded(
              child: CircularPercentIndicator (
                lineWidth: 10,
                center: Text(
                  "00:00",
                  style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold ),),
                radius: 180.0,
                percent: 1,
                
                progressColor: Color.fromARGB(255, 236, 222, 17),
                ),
                ),
    
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                listOfCD[selectedIndex].isActive?
                Expanded(
                  child: MaterialButton(
                    color: Color.fromARGB(255, 42, 212, 4),
                    child: Text("Stop",style: TextStyle(fontSize: 20, color: Colors.white),),
                    onPressed: (){
                      listOfCD[selectedIndex].stop();
                      }
                  ),
                ):
                Expanded(
                  child: MaterialButton(
                    color: Color.fromARGB(255, 42, 212, 4),
                    child: Text(listOfCD[selectedIndex].percent==1? "Start":"Resume",
                    style: TextStyle(fontSize: 20, color: Colors.white),),
                    onPressed: (){
                      listOfCD[selectedIndex].start();
                      }
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: MaterialButton(
                    color: Colors.red,
                    child: Text("Restart",style: TextStyle(fontSize: 20, color: Colors.white),),
                    onPressed: (){listOfCD[selectedIndex].restart();
                    }
                  ),
                ),
               ],
              ),
            ),
    
          ],
        );
      }
    );
  } 
}