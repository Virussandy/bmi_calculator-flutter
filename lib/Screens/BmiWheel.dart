import 'dart:ui';
import 'package:fcheck2/Screens/Video.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_text/circular_text.dart';
import 'package:flutter_circular_text/circular_text/model.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:delayed_display/delayed_display.dart';

class MyResult extends StatefulWidget {
 String gender1;
 double height;
 double weight;
 double age;
 String name;
 String phone;
  MyResult(gen,hei,wei,ag,nam,ph){
   gender1=gen;
   height=hei;
   weight=wei;
   age=ag;
   name=nam;
   phone=ph;

  }
  @override
  _MyResultState createState() => _MyResultState();
}

class _MyResultState extends State<MyResult> {

  double bmi(){
    double h=widget.height;
    double w=widget.weight;
    return ((w) /((h*0.01) * (h*0.01)));
  }

   getBmi(){
    double bmivalue=bmi();
    if(bmivalue <18.5){
      return ["UNDER WEIGHT","Slow and Poor Body Growth","Anemia","Low Immunity","Osteoporosis","Homonal Disbalance","Irregular Menstruation"];
    }
    else if(bmivalue>18.4 && bmivalue<=20.5){
      return ["NEAR UNDERWEIGHT","Low Energy","Weakness","Low BP","Dizziness","Black Out"," Low Immunity"];
    }
    else if(bmivalue>20.5 && bmivalue<=22.5){
      return ["GOOD","Follow Happy","Healthy","Active lifestyle","Good Immunity","Freshness","No Weakness"];
    }
    else if(bmivalue>22.5 && bmivalue<=24.9){
      return ["NEAR OVERWEIGHT", "High BP","Back & Leg Pain","Diabetes","Indigestion","Lethargy","Mood Swing"];
    }
    else if(bmivalue>24.9 && bmivalue<=29.9){
      return ["OVERWEIGHT","High BP","Heart Disease","Hyper Thyroidism","Fatty liver","Kidney Stone","Spondylitis"];
    }
    else{
      return ["OBESE","Stroke or Heart Attact","Cancer ","Insomnia","Polycystic ovary syndrome","Infertility","Gallbladder or Kidney Stone"];
    }

  }

  @override
  Widget build(BuildContext context) {
    //getValue();
    String name1=widget.name;
    String phone1=widget.phone;
    double weight1=widget.weight;
    double height1=widget.height;
    double age1=widget.age;
    String genders=widget.gender1;

    double _value= bmi();
    List a=getBmi();
    String health=a[0];
    String p1=a[1];
    String p2=a[2];
    String p3=a[3];
    String p4=a[4];
    String p5=a[5];
    String p6=a[6];
    return Scaffold(
      backgroundColor: Color.fromRGBO(21, 13, 45, .7),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Color.fromRGBO(21, 13, 45, .4),
        //shadowColor: Colors.black54,
        elevation: 10,
        title: Text("BMI WHEEL"),
        centerTitle: true,
      ),
      drawer: Drawer(),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.40,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: SfRadialGauge(
                  enableLoadingAnimation: true,
                  axes:<RadialAxis> [
                    RadialAxis(
                        minimum: 12,
                        maximum: 35,
                        axisLineStyle: AxisLineStyle(
                          thickness: 132,
                          thicknessUnit: GaugeSizeUnit.logicalPixel,
                          cornerStyle: CornerStyle.bothFlat,
                        ),
                        showLabels: false,
                        showTicks: false,
                        canScaleToFit: true,
                        radiusFactor: 1.15,
                        ranges: <GaugeRange>[
                          GaugeRange(startValue: 12, endValue: 18.4,rangeOffset: 40,startWidth: 92,endWidth: 92,color:Colors.yellowAccent),
                          GaugeRange(startValue: 18.5, endValue: 20.5,rangeOffset: 40,startWidth: 92,endWidth: 92,color:Colors.lightGreenAccent[700]),
                          GaugeRange(startValue: 20.6, endValue: 22.5,rangeOffset: 40,startWidth: 92,endWidth: 92,color:Color.fromRGBO(1,650 , 1, 1)),
                          GaugeRange(startValue: 22.6, endValue: 24.9,rangeOffset: 40,startWidth: 92,endWidth: 92,color:Color.fromRGBO(1, 500, 1, 30)),
                          GaugeRange(startValue: 25.0, endValue: 29.9,rangeOffset: 40,startWidth: 92,endWidth: 92,color:Colors.orange[700]),
                          GaugeRange(startValue: 30, endValue: 38,rangeOffset: 40,startWidth: 92,endWidth: 92,color:Colors.redAccent[700]),
                        ],
                        pointers: <GaugePointer>[
                          NeedlePointer(needleColor: Colors.black,needleLength: 0.5,enableAnimation: true,animationDuration: 150000,animationType: AnimationType.values[6],value: _value,enableDragging: true,knobStyle: KnobStyle(knobRadius: 0.05,borderWidth: 0.03,sizeUnit:GaugeSizeUnit.factor,borderColor: Colors.black,color: Colors.white),
                          ),
                        ],
                        startAngle: 180,
                        endAngle: 360,
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(widget:Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(child: Text("BMI SCORE",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 12),)),
                                Center(child: Text("${_value.toStringAsFixed(1)}",style: TextStyle(color: _value>18.4 && _value<=24.9? Colors.green:Colors.red,fontWeight: FontWeight.w900,fontSize: 20),)),
                              ],
                            ),
                          ),
                            angle: 410,
                            positionFactor: 1.35,
                          ),

                          GaugeAnnotation(widget:Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(child: Text("BMI WHEEL",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 15),)),
                                //Center(child: Text("${_value.toStringAsFixed(1)}",style: TextStyle(color: _value>18.4 && _value<=24.9? Colors.green:Colors.red,fontWeight: FontWeight.w900,fontSize: 20),)),
                              ],
                            ),
                          ),
                            angle: 90,
                            positionFactor: 1.2,
                          ),

                          GaugeAnnotation(widget:Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(child: Text("NAME",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 12),)),
                                Center(child: Text("$name1",style: TextStyle(color: _value>18.4 && _value<=24.9? Colors.green:Colors.red,fontWeight: FontWeight.w900,fontSize: 20),)),
                              ],
                            ),
                          ),
                            angle: 130,
                            positionFactor: 1.35,
                          ),
                          GaugeAnnotation(
                              widget: Transform(
                                  transform: Matrix4.skewX(0),
                                  child: CircularText(children: [
                                    TextItem(text: Text("UNDER WEIGHT",style: TextStyle(fontSize: 11,color: Colors.black,fontWeight: FontWeight.bold),),
                                      direction: CircularTextDirection.clockwise,
                                      space: 2.2,
                                      startAngle: 195,
                                    ),

                                  ],
                                    radius: 180,
                                    position: CircularTextPosition.inside,

                                  )),
                              angle: 200,
                              positionFactor:0.51
                          ),
                          GaugeAnnotation(
                              widget: Transform(
                                  transform: Matrix4.skewX(0),
                                  child: CircularText(children: [
                                    TextItem(text: Text("OVER WEIGHT",style: TextStyle(fontSize: 11,color: Colors.black,fontWeight: FontWeight.bold),),
                                      direction: CircularTextDirection.clockwise,
                                      space: 2.2,
                                      startAngle: 293,
                                    ),

                                  ],
                                    radius: 180,
                                    position: CircularTextPosition.inside,

                                  )),
                              angle: 300,
                              positionFactor:0.51
                          ),
                          GaugeAnnotation(
                              widget: Transform(
                                  transform: Matrix4.skewX(0),
                                  child: CircularText(children: [
                                    TextItem(text: Text("OBESE",style: TextStyle(fontSize: 11,color: Colors.black,fontWeight: FontWeight.bold),),
                                      direction: CircularTextDirection.clockwise,
                                      space: 2.2,
                                      startAngle: 338,
                                    ),

                                  ],
                                    radius: 160,
                                    position: CircularTextPosition.inside,

                                  )),
                              angle: 340,
                              positionFactor:0.5
                          ),
                          GaugeAnnotation(
                              widget: Transform(
                                  transform: Matrix4.skewX(0),
                                  child: CircularText(children: [
                                    TextItem(text: Text("HEALTHY",style: TextStyle(fontSize: 11,color: Colors.black,fontWeight: FontWeight.bold),),
                                      direction: CircularTextDirection.clockwise,
                                      space: 2.2,
                                      startAngle: 250,
                                    ),

                                  ],
                                    radius: 180,
                                    position: CircularTextPosition.inside,

                                  )),
                              angle: 260,
                              positionFactor:0.5
                          ),


                        ]

                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Center(
                  child: Image(
                    image: AssetImage("images/indicator1.png"),
                    fit: BoxFit.cover,
                  ),
                ),

              ),
              SizedBox(
                height: 10,
              ),
              DelayedDisplay(
                delay: Duration(seconds: 1),
                slidingCurve: Curves.easeInOutQuad,
                fadeIn: true,
                slidingBeginOffset: Offset.fromDirection(0),
                fadingDuration: Duration(seconds: 1),
                child: Container(
                  //height: MediaQuery.of(context).size.height*0.25,
                  width: MediaQuery.of(context).size.width*0.98,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(21, 13, 45, .9),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.055,
                          width: MediaQuery.of(context).size.width*0.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            //color: Colors.yellowAccent
                            gradient: LinearGradient(
                              colors: [Colors.yellowAccent,Colors.green,Colors.red],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight
                            )
                          ),
                          child: Center(child: Text("$health",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),)),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.only(left: 0,right: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Container(
                             width:MediaQuery.of(context).size.width*0.49,
                             height: 20,
                             //color: Colors.white,
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Container(
                                   height: 10,
                                   width: 10,
                                   decoration: BoxDecoration(
                                       shape: BoxShape.circle,
                                       color: Colors.white
                                   ),
                                 ),
                                 Text("  "+"$p1",style: TextStyle(color: Colors.white),)
                               ],
                             ),
                           ),
                           Container(
                             width:MediaQuery.of(context).size.width*0.49,
                             height: 20,
                             //color: Colors.white,
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Container(
                                   height: 10,
                                   width: 10,
                                   decoration: BoxDecoration(
                                       shape: BoxShape.circle,
                                       color: Colors.white
                                   ),
                                 ),
                                 Text("  "+"$p2",style: TextStyle(color: Colors.white),)
                               ],
                             ),
                           )
                         ],
                        ),
                      ),
                      SizedBox(height: 10,),


                      Padding(
                        padding: const EdgeInsets.only(left: 0,right: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width:MediaQuery.of(context).size.width*0.49,
                              height: 20,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white
                                    ),
                                  ),
                                  Text(" "+"$p3",style: TextStyle(color: Colors.white),)
                                ],
                              ),
                            ),
                            Container(
                              width:MediaQuery.of(context).size.width*0.49,
                              //color: Colors.white,
                              height: 20,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white
                                    ),
                                  ),
                                  Text(" "+"$p4",style: TextStyle(color: Colors.white),)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),

                      Padding(
                        padding: const EdgeInsets.only(left: 0,right: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width:MediaQuery.of(context).size.width*0.49,
                              height: 20,
                              //color: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white
                                    ),
                                  ),
                                  Text(" "+"$p5",style: TextStyle(color: Colors.white),)
                                ],
                              ),
                            ),
                            Container(
                              width:MediaQuery.of(context).size.width*0.49,
                              height: 20,
                              //color: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white
                                    ),
                                  ),
                                  Text(" "+"$p6",style: TextStyle(color: Colors.white),)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              DelayedDisplay(
                delay: Duration(seconds: 2),
                slidingCurve: Curves.easeInOutQuad,
                fadeIn: true,
                slidingBeginOffset: Offset.fromDirection(-2),
                fadingDuration: Duration(seconds: 0),
                child: GestureDetector(
                  child: Container(
                    height: 35,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(child: Text("BODY CONDITION",style: TextStyle(color: Colors.white,fontSize: 14),)),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyVideo(_value,genders,name1,health)
                    ));
                  },
                ),
              ),
              SizedBox(height: 10,),
            ],
          )
        ],
      ),
    );
  }
}
//rangeOffset:0.2,
// sizeUnit:GaugeSizeUnit.factor