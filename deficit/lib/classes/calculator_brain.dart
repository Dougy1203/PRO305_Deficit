import 'dart:math';

class CalculatorBrain{
  CalculatorBrain(this.height, this.weight);
  final int height;
  final int weight;
  late double _bmi;

  String calculateBmi(){
    _bmi =  (weight / pow(height, 2)) * 703;
    return _bmi.toStringAsFixed(1);
  }
  String getResult(){
    if(_bmi >= 25) {
      return "Overweight";
    } else if(_bmi > 18.5) {
      return "Normal";
    } else {
      return "Underweight";
    }
  }
  String getInterp(){
    if(_bmi >= 25) {
      return "Lose Weight. Fatty";
    } else if(_bmi > 18.5) {
      return "You Good";
    } else {
      return "Eat some food you underweight piece of human garbage";
    }
  }
}