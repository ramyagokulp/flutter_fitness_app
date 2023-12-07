

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  double bmi = 0.0;
  String result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('BMI Calculator',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        backgroundColor: Color.fromARGB(255, 87, 107, 218),
      ),
      body: SingleChildScrollView(
        
        child: Container(
          color: Colors.black,
        
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                      
                  Card(shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black,width: 2,) 
                    ,borderRadius: BorderRadius.circular(20.0),
                  
                  ),
                    color: Colors.indigoAccent[100],
                    
                    elevation: 96,
                    child: Column(
                      
                    children: [SizedBox(height: 10,),
                      Padding(padding: EdgeInsets.all(20,
                  ),child: TextField(
                    controller: weightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      fillColor: Colors.black,
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width:0.5,color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2,color: Colors.white,),
                        
                        
                      borderRadius: BorderRadius.circular(20))
                      ,labelText: 'Weight (kg)',
                      labelStyle: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold)),
                  ),),
                  SizedBox(height: 12),
        
         Padding(padding: EdgeInsets.all(20),
          child:TextField(
                    controller: heightController,
                    keyboardType: TextInputType.number,
                  
                    decoration: InputDecoration(focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width:0.5,
                    color:Colors.white)),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2,color: Colors.white,),borderRadius: BorderRadius.circular(20)),
                      labelText: 'Height (cm)',labelStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),fillColor: Colors.deepOrange[400]),
                  ),),
                 
                  SizedBox(height: 16),],
                  ),),
                  
                  SizedBox(height: 20,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.indigoAccent[100]),
                    onPressed: () => calculateBMI(),
                    child: Text('Calculate BMI',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                  ),
                  SizedBox(height: 16),
                  AnimatedOpacity(
                    opacity: bmi > 0 ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 500),
                    child: Column(
                      children: [
                        Text(
                          'Your BMI: ${bmi.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
                          color: Colors.white
                          ),
                        ),
                        SizedBox(height: 16),
                        CircularPercentIndicator(
                          radius: 150.0,
                          lineWidth: 10.0,
                          percent: bmi / 40.0,
                          center: Text(
                            _getBMIResultMessage(),
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: _getProgressColor(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getProgressColor() {
    if (bmi < 18.5) {
      return Colors.green;
    } else if (bmi < 25) {
      return Colors.yellow;
    } else if (bmi < 30) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  void calculateBMI() {
    double weight = double.tryParse(weightController.text) ?? 0.0;
    double height = double.tryParse(heightController.text) ?? 0.0;

    if (weight > 0 && height > 0) {
      setState(() {
        bmi = weight / ((height / 100) * (height / 100));
        result = _getBMIResultMessage();
      });
    } else {
      setState(() {
        bmi = 0.0;
        result = "Please enter valid weight and height.";
      });
    }
  }

  String _getBMIResultMessage() {
    if (bmi < 16) {
      return "Severely underweight";
    } else if (bmi < 16.9) {
      return "Underweight";
    } else if (bmi < 18.4) {
      return "Mildly underweight";
    } else if (bmi < 24.9) {
      return "Normal";
    } else if (bmi < 29.9) {
      return "Overweight";
    } else if (bmi < 34.9) {
      return "Obese Class I (Moderate)";
    } else if (bmi < 39.9) {
      return "Obese Class II (Severe)";
    } else {
      return "Obese Class III (Very Severe)";
    }
  }
}
