import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'MyHome.dart';

class BMIScore extends StatefulWidget {
  String na;
  String he;
  double bmi;
  BMIScore(n,h,b){
    na=n;
    he=h;
    bmi=b;
  }
  @override
  _BMIScoreState createState() => _BMIScoreState();
}

class _BMIScoreState extends State<BMIScore> {
  getDate(){
     final DateTime now = DateTime. now();
     final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter. format(now);
    return formatted;
  }

  getResult(){
    String rehealth=widget.he;
    if(rehealth=="UNDER WEIGHT"){
      return ["can lead to problems such as Osteoporosis (Brittle Bones), Skin, Hair and Teeth issues. You are at risk to develop Brain, Liver and Heart problems if you fail to provide the right and adequate amount of Proteins, Vitamins, Carbohydrates and Minerals to your body.",
        "Family History, High Rate of Metabolism, High Level of Physical activity, Chronic Diseases, Diabetes, Thyroid and digestive conditions, mental depression and Anxiety or maybe consumption of alcohol or smoking cigarette.",
        "For overcoming the situation please follow a nutritional food system and healthy lifestyle. For remedial process and consultation please speak to your Feonnaa Consultants or Feonnaa Doctors. Strictly avoid alcohol and smoking."
      ];
    }
    else if(rehealth=="NEAR UNDERWEIGHT"){
      return ["can lead to various problems and put you at risk to develop Liver and Heart problems. If you fail to provide the right and adequate amount of Proteins, Vitamins, Carbohydrates and Minerals to your body the organs will dysfunction and create major health issues.",
      "The issue could be caused due to High Rate of Metabolism, High Level of Physical activity, Chronic Diseases, Diabetes, Thyroid and digestive problems or maybe consumption of alcohol or smoking cigarette.",
      " For overcoming the situation please follow a nutritional food system and healthy lifestyle. For remedial process and consultation please speak to your Feonnaa Consultants or Feonnaa Doctors. Please avoid alcohol and smoking."
      ];
    }
    else if(rehealth=="GOOD"){
      return ["Weight suggests a Healthy body condition but need to maintain a healthy daily lifestyle and food habits. Provide your body with right amount of nutrients on daily basis.",
      "None analysed.",
      "Maintain a healthy lifestyle and nutritional food practice. Follow a good exercise routine or regular yoga."
      ];
    }
    else if(rehealth=="NEAR OVERWEIGHT"){
      return ["a healthy body condition but can put you at risk to develop Heart, Kidney and Lung problems. Maintain a continuous check on your food habits and your lifestyle.",
      "The issue could be caused due to Slower Rate of Metabolism, Less Physical activity, maybe Chronic Diseases, Diabetes, Thyroid and digestive problems.",
      "For overcoming the situation please follow a nutritional food system and healthy lifestyle. For remedial process and consultation please speak to your Feonnaa Consultants or Feonnaa Doctors."
      ];
    }
    else if(rehealth=="OVER WEIGHT"){
      return ["can lead to serious problems related to Liver, Kidney, and Heart or even intestines. It is best suggested that you immediately perform further pathological tests in order to avoid increase of any acute illness related to internal organs.",
      "The issue could be caused due to slow Rate of Metabolism, No Physical activity, Chronic Diseases, Diabetes, Thyroid and digestive problems.",
      "For overcoming the situation please follow a nutritional food system and healthy lifestyle. For remedial process and consultation please speak to your Feonnaa Consultants or Feonnaa Doctors."
      ];
    }
    else if(rehealth=="OBESE"){
      return ["is a challenging and a difficult health condition that can lead to serious problems related to Liver, Kidney, and Heart and other internal organs. It is best suggested that you immediately perform further pathological tests in order to avoid increase of any acute illness related to internal organs.",
      "The issue could be caused due to slow Rate of Metabolism, No Physical activity, Chronic Diseases, Diabetes, Thyroid and digestive problems.",
      "For overcoming the situation please follow a nutritional food system and healthy lifestyle. For remedial process and consultation please speak to your Feonnaa Consultants or Feonnaa Doctors."
      ];
    }
  }

File file;
  String path;
  Future<void> _createPDF() async {
    String name=widget.na;
    String health=widget.he;
    double bmiScore=widget.bmi;
    //Create a PDF document.
    PdfDocument document = PdfDocument();
    PdfPage page = document.pages.add();
    PdfGraphics graphics = page.graphics;
    //Add page and draw text to the page.
    PdfStringFormat drawFormat = new PdfStringFormat();
    drawFormat.wordWrap = PdfWordWrapType.word;
    drawFormat.alignment = PdfTextAlignment.justify;
    drawFormat.lineAlignment = PdfVerticalAlignment.top;

//Set the font.
    PdfFont font = new PdfStandardFont(PdfFontFamily.helvetica, 10);

//Create a solid brush.
   // PdfBrush brush = new PdfSolidBrush(new PdfColor(Colors.teal));
   // RectangleF bounds = new RectangleF(new PointF(10, 10), new Size(page.graphics.clientSize.width - 30, page.graphics.clientSize.height - 20));

// Draw the string one after another.
    graphics.drawString('$name', PdfStandardFont(PdfFontFamily.helvetica, 18),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: Rect.fromLTWH(0, 0, 500, 30),);
    // graphics.drawString('hello', PdfStandardFont(PdfFontFamily.helvetica, 18),
    //     brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    //     bounds: Rect.fromLTWH(0, 0, 500, 30),
    //     );


    //Save the document
    var bytes = document.save();
    // Dispose the document
    document.dispose();
    //Get external storage directory
    Directory directory = (await getExternalStorageDirectory());
//Get directory path
     path =directory.path;
//Create an empty file to write PDF data
    file=File('$path/$name.pdf');
//Write PDF data
    await file.writeAsBytes(bytes,flush:true);
//Open the PDF document in mobile
    OpenFile.open('$path/$name.pdf');
    PdfGrid getGrid() {
      //Create a PDF grid
      final PdfGrid grid = PdfGrid();
      //Secify the columns count to the grid.
      grid.columns.add(count: 5);
    }
  }


  Future<void> _sharePDF() async {
    String name=widget.na;
    try {
      final ByteData bytes = await rootBundle.load('assets/$path/$name.pdf');
      await Share.file(
          '$name', '$name.pdf', bytes.buffer.asUint8List(), 'text/pdf');
    } catch (e) {
      print('error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    //_createPDF();
    List b=getResult();
    String rf=b[0];
    String c=b[1];
    String t=b[2];
    String name=widget.na;
    String health=widget.he;
    double bmiScore=widget.bmi;
    String date=getDate();
    return Scaffold(
      backgroundColor: Color.fromRGBO(21, 13, 45, .7),
      appBar: AppBar(
        leading: Container(
        ),
        toolbarHeight: 80,
        backgroundColor: Color.fromRGBO(21, 13, 45, .4),
        //shadowColor: Colors.black54,
        elevation: 20,
        title: Text("YOUR BMI SCORE"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                //height: MediaQuery.of(context).size.height*.3,
                //width: MediaQuery.of(context).size.width*1,
                //color: Colors.yellow,
                child: Stack(children: [
                  Center(child: Image(image: AssetImage("images/colors.png"),fit: BoxFit.cover,)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10,),
                      Center(child: Text("NAME:"+ " ""$name",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                      SizedBox(height: 15,),
                      Text("BMI SCORE",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900,fontSize:30,letterSpacing: .05),),
                      Text("${bmiScore.toStringAsFixed(1)}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize:60),),
                      Container(
                        height: MediaQuery.of(context).size.height*0.03,
                        width: MediaQuery.of(context).size.width*0.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.yellowAccent
                        ),
                        child: Center(
                          child: Text("Report Generated:"+" "+"$date"),
                        ),
                      ),
                    ],
                  )
                ]
                ),
              ),
              Center(child: Text("RESULT:",style: TextStyle(color: Colors.pinkAccent,fontSize: 20,fontWeight: FontWeight.bold),)),
              SizedBox(height: 5,),
              Text("As per BMI Calculations, Your Health\nis Categorized As -",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
              SizedBox(
                height: 5,
              ),
              Container(
                //height: MediaQuery.of(context).size.height*0.04,
                //width: MediaQuery.of(context).size.width*0.4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.yellowAccent
                ),
                child: Center(
                  child: Text("$health.",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w900)),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                //height: MediaQuery.of(context).size.height*0.90,
                width: MediaQuery.of(context).size.width*0.95,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                   color: Color.fromRGBO(21, 13, 45, .2)
                  //color: Colors.white
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Center(child: Text("Risk Factors:",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                          ),
                          SizedBox(height: 1,),
                          Container(
                            width: MediaQuery.of(context).size.width*.9,
                            // decoration: BoxDecoration(
                            //   border:Border.all(color: Colors.black)
                            // ),
                            child: Card(color: Color.fromRGBO(21, 13, 45, 1),child: Center(child: Text("\nBeing"+" "+"${health.toLowerCase()}"+" "+"$rf\n",style: TextStyle(color: Colors.white),))),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Center(child: Text("Causes:",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                          ),
                          SizedBox(height: 1,),
                          Container(
                            width: MediaQuery.of(context).size.width*.9,
                            // decoration: BoxDecoration(
                            //   border:Border.all(color: Colors.black)
                            // ),
                            child: Card(color: Color.fromRGBO(21, 13, 45, 1),child: Center(child: Text("\n$c\n",style: TextStyle(color: Colors.white),))),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Center(child: Text("Treatement:",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                          ),
                          SizedBox(height: 1,),
                          Container(
                            width: MediaQuery.of(context).size.width*.9,
                            // decoration: BoxDecoration(
                            //   border:Border.all(color: Colors.black)
                            // ),
                            child: Card(color: Color.fromRGBO(21, 13, 45, 1),child: Center(child: Text("\n$t\n",style: TextStyle(color: Colors.white),))),
                          ),

                        ],
                      ),
                    )

    //                 Container(
    //                   Column(
    //                     mainAxisAlignment: MainAxisAlignment.start,
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     children: [
    //                       Container(
    //                         child:Center(child: Text("Risk Factors:",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
    // ,
    //                        // Text("Risk Factors:",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
    //                         //Center(child: Text("Being"+" "+"${health.toLowerCase()}"+" "+"can lead\nto problems such as Osteoporosis\n(Brittle Bones), Skin, Hair\nand Teeth issues.\nYou are at risk to develop Brain,\nLiver and Heart problems\nif you fail to provide the\nright and adequate amount of\nProteins, Vitamins, Carbohydrates and\nMinerals to your body.",style: TextStyle(color: Colors.white),)),
    //                       ),
    //                     ],
    //                   )
    //                 ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     Text("Causes:",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
                    //     Center(child: Text("Family History, High Rate\nof Metabolism, High Level of \nPhysical activity, Chronic Diseases,\nDiabetes, Thyroid and digestive\nconditions, mental depression and\nAnxiety or maybe consumption of\nalcohol or smoking cigarette.",style: TextStyle(color: Colors.white),))
                    //   ],
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     Text("Treatment:",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
                    //     Center(child: Text("For overcoming the situation\nplease follow a nutritional food\nsystem and healthy lifestyle.\nFor remedial process and consultation\nplease speak to your Feonnaa\nConsultants or Feonnaa Doctors. \nStrictly avoid alcohol and smoking.",style: TextStyle(color: Colors.white),))
                    //   ],
                    // )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (){
                      _createPDF();

    },
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHome()));
                      //Navigator.of(context).popUntil((route) => route.settings.name == '/page2');
                      //Navigator.popUntil(context, ModalRoute.withName('/page2'));

                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        height: 35,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.pink,
                        ),
                        child: Center(
                          child: Text("Share",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHome()));
                      //Navigator.of(context).popUntil((route) => route.settings.name == '/page2');
                      //Navigator.popUntil(context, ModalRoute.withName('/page2'));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        height: 35,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.pink,
                        ),
                        child: Center(
                          child: Text("Recalculate",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Container(
              //   height: 250,
              //   width: 250,
              //   color: Colors.white,
              // )

            ],
          )
        ],
      ),
    );
  }
}
