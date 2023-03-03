import 'package:flutter/material.dart';
import '../classes/constants.dart';
import '../widgets/reusable_card.dart';
import '../widgets/bottom_button.dart';

class ResultsPage extends StatelessWidget {
  ResultsPage({required this.bmiResults, required this.bmiText, required this.bmiInterpretation});
  final String bmiResults;
  final String bmiText;
  final String bmiInterpretation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI RESULTS'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:<Widget>[
          // SizedBox(
          //   width: double.infinity,
          // ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.bottomCenter,
              child: const Text(
                'RESULTS',
                style: kTitleTextStyle,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: ReusableCard(
              onPress: (){},
              color: kActiveCardColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    bmiText,
                    style: kResultTextStyle,
                  ),
                  Text(
                    bmiResults,
                    style: kBMITextStyle,
                  ),
                  Text(
                    bmiInterpretation,
                    style: kBodyTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          BottomButton(
            buttonTitle: 'RE-CALCULATE',
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}