import 'package:flutter/material.dart';

import '../widgets/bottom_button.dart';
import '../widgets/calculator_brain.dart';
import '../widgets/card_child_icon.dart';
import '../widgets/constants.dart';
import '../main.dart';
import 'results_page.dart';
import '../widgets/reusable_card.dart';
import '../widgets/round_icon_button.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  InputPageState createState() => InputPageState();
}

class InputPageState extends State<InputPage> {
  Gender gender = Gender.male;
  int weight = 150;
  int height = 72;
  int age = 25;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('BMI CALCULATOR'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                      color: gender == Gender.male
                          ? kActiveCardColor
                          : kInactiveCardColor,
                      cardChild: cardChildIcon(
                        icon: Icons.male,
                        text: 'MALE',
                      ),
                      onPress: () {
                        setState(() {
                          gender = Gender.male;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      color: gender == Gender.female
                          ? kActiveCardColor
                          : kInactiveCardColor,
                      cardChild: cardChildIcon(
                        icon: Icons.female,
                        text: 'FEMALE',
                      ),
                      onPress: () {
                        setState(() {
                          gender = Gender.female;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ReusableCard(
                color: kActiveCardColor,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('HEIGHT', style: kLabelTextStyle),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          height.toString(),
                          style: kCardTextStyle,
                        ),
                        const Text(
                          'in',
                          style: kLabelTextStyle,
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 15.0),
                        overlayShape:
                        const RoundSliderOverlayShape(overlayRadius: 25.0),
                        activeTrackColor: Colors.white,
                        thumbColor: kBmiTertiary,
                        overlayColor: const Color(0x29EB1555),
                      ),
                      child: Slider(
                        value: height.toDouble(),
                        inactiveColor: const Color(0xFF8D8E98),
                        onChanged: (double newValue) {
                          setState(() {
                            height = newValue.round();
                          });
                        },
                        min: 36.0,
                        max: 96,
                      ),
                    ),
                  ],
                ), onPress: () {  },
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                      color: kActiveCardColor,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'WEIGHT',
                            style: kLabelTextStyle,
                          ),
                          Text(
                            weight.toString(),
                            style: kCardTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RoundIconButton(
                                icon: Icons.arrow_drop_down,
                                onPressed: () {
                                  setState(() {
                                    weight--;
                                  });
                                },
                              ),
                              RoundIconButton(
                                  icon: Icons.arrow_drop_up,
                                  onPressed: () {
                                    setState(() {
                                      weight++;
                                    });
                                  }),
                            ],
                          ),
                        ],
                      ), onPress: () {  },
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      color: kActiveCardColor,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'AGE',
                            style: kLabelTextStyle,
                          ),
                          Text(
                            age.toString(),
                            style: kCardTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RoundIconButton(
                                icon: Icons.arrow_drop_down,
                                onPressed: () {
                                  setState(() {
                                    age--;
                                  });
                                },
                              ),
                              RoundIconButton(
                                icon: Icons.arrow_drop_up,
                                onPressed: () {
                                  setState(() {
                                    age++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ), onPress: () {  },
                    ),
                  ),
                ],
              ),
            ),
            BottomButton(
              onTap: () {
                CalculatorBrain brain = CalculatorBrain(height, weight);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ResultsPage(bmiResults: brain.calculateBmi(), bmiText: brain.getResult(), bmiInterpretation: brain.getInterp(),)));
              },
              buttonTitle: 'CALCULATE BMI',
            ),
          ],
        ));
  }
}