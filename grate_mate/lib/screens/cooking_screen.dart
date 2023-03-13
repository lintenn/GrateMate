import 'dart:async';

import 'package:flutter/material.dart';

import '../global_information/colors_palette.dart';
import '../models/recipe.dart';

class CookingScreen extends StatefulWidget {
  final Recipe recipe;

  const CookingScreen(this.recipe, {super.key});

  @override
  State<CookingScreen> createState() => _CookingScreenState();
}

class _CookingScreenState extends State<CookingScreen> {
  Timer? timer;
  var timerStarted = false;

  final Duration defaultTime = const Duration(hours: 0, minutes: 2, seconds: 0);
  Duration time = Duration();

  var hourController = TextEditingController();
  var minuteController = TextEditingController();
  var secondController = TextEditingController();

  var timeFocusNodes = <FocusNode>[];

  var focusHour = FocusNode();
  var focusMinute = FocusNode();
  var focusSecond = FocusNode();

  var keyBoardActive = false;

  @override
  void initState() {
    super.initState();
    resetTimer();
    timeFocusNodes = [focusHour, focusMinute, focusSecond];

    focusHour.addListener(() {
      if (focusHour.hasFocus) {
        hourController.clear();
        setState(() {
          keyBoardActive = focusHour.hasFocus ||
              focusMinute.hasFocus ||
              focusSecond.hasFocus;
          time = Duration(
              hours: int.parse(hourController.text),
              minutes: time.inMinutes.remainder(60),
              seconds: time.inSeconds.remainder(60));
        });
      }
    });
    focusMinute.addListener(() {
      if (focusMinute.hasFocus) {
        minuteController.clear();
        setState(() {
          keyBoardActive = focusHour.hasFocus ||
              focusMinute.hasFocus ||
              focusSecond.hasFocus;

          time = Duration(
              hours: time.inHours,
              minutes: int.parse(minuteController.text),
              seconds: time.inSeconds.remainder(60));
        });
      }
    });
    focusSecond.addListener(() {
      if (focusSecond.hasFocus) {
        secondController.clear();
        setState(() {
          keyBoardActive = focusHour.hasFocus ||
              focusMinute.hasFocus ||
              focusSecond.hasFocus;
          time = Duration(
              hours: time.inHours,
              minutes: time.inMinutes.remainder(60),
              seconds: int.parse(secondController.text));
        });
      }
    });
  }

  void resetTimer() {
    setState(() {
      time = defaultTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentStep = widget.recipe.steps[0];
    var numSteps = widget.recipe.steps.length;

    return Scaffold(
      backgroundColor: GrateMate.grayGrateMate,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Cooking ${widget.recipe.name}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontFamily: 'MontserratBold',
            wordSpacing: 2,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 0.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // current step out of all steps
              Container(
                child: Text(
                    "${getCurrentStepIndex(currentStep)} out of ${numSteps}"),
              ),
              const SizedBox(height: 10),
              Container(
                width: 200,
                child: LinearProgressIndicator(
                  //value: need value between 0 and 1 for progress indicator
                  value: getCurrentStepIndex(currentStep) / numSteps,
                  color: GrateMate.deepBlueGrateMate,
                ),
              ),
              Visibility(
                  visible: !focusHour.hasFocus,
                  child: const SizedBox(height: 90)),
              Visibility(
                visible: !focusHour.hasFocus,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Text(
                      widget.recipe.steps[1],
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 90),
              Center(
                child: Container(
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildTime(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(child: buildTimerButtons())
            ],
          ),
        ),
      ),
    );
  }

  int getCurrentStepIndex(String currentStep) {
    return widget.recipe.steps.indexOf(currentStep) + 1;
  }

  Widget buildTime() {
    var hours = time.inHours.toString().padLeft(2, '0');
    var minutes = time.inMinutes.remainder(60).toString().padLeft(2, '0');
    var seconds = time.inSeconds.remainder(60).toString().padLeft(2, '0');

    hourController.value = TextEditingValue(text: hours);
    minuteController.value = TextEditingValue(text: minutes);
    secondController.value = TextEditingValue(text: seconds);

    return Row(children: [
      buildTimeUnit(hourController, focusHour),
      const Padding(
        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Text(
          ":",
          style: TextStyle(
              fontSize: 30, color: Colors.grey, fontWeight: FontWeight.bold),
        ),
      ),
      buildTimeUnit(minuteController, focusMinute),
      const Padding(
        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Text(
          ":",
          style: TextStyle(
              fontSize: 30, color: Colors.grey, fontWeight: FontWeight.bold),
        ),
      ),
      buildTimeUnit(secondController, focusSecond),
    ]);
  }

  Container buildTimeUnit(
      TextEditingController controller, FocusNode focusNode) {
    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(5)),
      child: TextField(
        maxLength: 2,
        controller: controller,
        focusNode: focusNode,
        showCursor: true,
        style: const TextStyle(
            fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            counterText: '',
            constraints: BoxConstraints(
                maxWidth: 45, minWidth: 45, maxHeight: 40, minHeight: 40),
            border: OutlineInputBorder(borderSide: BorderSide.none),
            contentPadding: EdgeInsets.all(0)),
        onSubmitted: (value) {
          setState(() {
            time = Duration(
                hours: int.parse(hourController.text),
                minutes: int.parse(minuteController.text),
                seconds: int.parse(secondController.text));

            focusNode.unfocus();
            var currentFocusNodeIndex = timeFocusNodes.indexOf(focusNode);
            if (currentFocusNodeIndex <= 1) {
              FocusScope.of(context)
                  .requestFocus(timeFocusNodes[currentFocusNodeIndex + 1]);
            }
          });
        },
      ),
    );
  }

  Widget buildTimerButtons() {
    if (!timerStarted) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
        child: ElevatedButton(
          onPressed: () {
            print("timer started");
            setState(() {
              timerStarted = true;
            });
            runTimer();
          },
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(GrateMate.deepBlueGrateMate),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
            ),
          ),
          child: Container(
            width: 100,
            alignment: Alignment.center,
            child: const Text(
              'Start',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  timerStarted = false;
                  resetTimer();
                  timer?.cancel();
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                side: MaterialStateProperty.all(const BorderSide(
                    color: GrateMate.deepBlueGrateMate,
                    width: 2,
                    style: BorderStyle.solid)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
              ),
              child: Container(
                width: 100,
                alignment: Alignment.center,
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                      color: GrateMate.deepBlueGrateMate, fontSize: 20),
                ),
              ),
            ),
            buildPauseAndResumeButton(),
          ],
        ),
      );
    }
  }

  Widget buildPauseAndResumeButton() {
    final timerRunning = timer == null ? false : timer!.isActive;

    if (timerRunning) {
      return ElevatedButton(
        onPressed: () {
          setState(() {
            timer?.cancel();
          });
        },
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(GrateMate.yellowNorthFace),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
            )),
        child: Container(
          width: 100,
          alignment: Alignment.center,
          child: const Text(
            'Pause',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: () {
          setState(() {
            timerStarted = true;
          });
          runTimer();
        },
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(GrateMate.deepBlueGrateMate),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
          ),
        ),
        child: Container(
          width: 100,
          alignment: Alignment.center,
          child: const Text(
            'Resume',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      );
    }
  }

  runTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      reduceTime();
    });
  }

  void reduceTime() {
    final timerRunning = timer == null ? false : timer!.isActive;
    final seconds = time.inSeconds - 1;

    if (timerRunning && seconds >= 0) {
      setState(() {
        time = Duration(seconds: seconds);
      });
    } else if (seconds < 0) {
      resetTimer();
      timer?.cancel();
      setState(() {
        timerStarted = false;
      });
      makeAlarmSound();
    }
  }

  //TODO we need some sound to show that timer is up
  void makeAlarmSound() {}

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    hourController.dispose();
    minuteController.dispose();
    secondController.dispose();
    focusHour.dispose();
    focusMinute.dispose();
    focusSecond.dispose();
    super.dispose();
  }
}
