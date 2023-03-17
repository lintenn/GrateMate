import 'dart:async';
import 'package:flutter/material.dart';
import '../global_information/colors_palette.dart';
import '../models/recipe.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

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
  Duration time = const Duration();

  late Recipe recipe;
  int currentStepIndex = 0;
  late String currentStep;
  late int numSteps;

  // Each time unit gets an own controller.
  var hourController = TextEditingController();
  var minuteController = TextEditingController();
  var secondController = TextEditingController();

  // The carousel needs a controller for the voice control.
  final carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    recipe = widget.recipe;
    currentStep = recipe.steps[currentStepIndex];
    numSteps = recipe.steps.length;
    resetTimer();
  }

  void resetTimer() {
    setState(() {
      time = defaultTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GrateMate.grayGrateMate,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: FittedBox(
          child: Text(
            "Cooking ${recipe.name}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontFamily: 'MontserratBold',
              wordSpacing: 2,
            ),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(30.0, 40.0, 30, 40.0),
        child: Column(
          children: [
            Container(
              child: Text("${currentStepIndex + 1} out of ${numSteps}"),
            ),
            const SizedBox(height: 10),
            Container(
              width: 200,
              child: LinearProgressIndicator(
                //progress indicator value between 0 and 1
                value: (currentStepIndex + 1) / numSteps,
                color: GrateMate.deepBlueGrateMate,
              ),
            ),
            Expanded(flex: 3, child: const SizedBox()),
            Expanded(
              flex: 8,
              child: SizedBox(
                // With the mediaquery the carousel keeps its original width even when keyboard pulls up.
                width: MediaQuery.of(context).size.width * 0.9,
                child: CarouselSlider(
                  carouselController: carouselController,
                  options: CarouselOptions(
                      enableInfiniteScroll: false,
                      // Next item is not visible.
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentStepIndex = index;
                        });
                      }),
                  // Build carousel items
                  items: widget.recipe.steps
                      .map((item) => Container(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Text(
                                      item,
                                      style: const TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
            const Expanded(flex: 3, child: SizedBox()),
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
            const Expanded(flex: 1, child: SizedBox()),
            Center(child: buildTimerButtons())
          ],
        ),
      ),
    );
  }

  Widget buildTime() {
    // Divide time to hours, minutes, seconds with remainder() func.
    var hours = time.inHours.toString().padLeft(2, '0');
    var minutes = time.inMinutes.remainder(60).toString().padLeft(2, '0');
    var seconds = time.inSeconds.remainder(60).toString().padLeft(2, '0');

    //controller values are given from current time
    hourController.value = TextEditingValue(text: hours);
    minuteController.value = TextEditingValue(text: minutes);
    secondController.value = TextEditingValue(text: seconds);

    // Row of timer input fields.
    return Row(children: [
      buildTimeUnit(hourController),
      buildTimeSeparator(),
      buildTimeUnit(minuteController),
      buildTimeSeparator(),
      buildTimeUnit(secondController),
    ]);
  }

  // One func for building hours, minutes and seconds.
  Container buildTimeUnit(TextEditingController controller) {
    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(5)),
      child: TextField(
        // Cannot be edited or selected when timer started.
        readOnly: timerStarted,
        enableInteractiveSelection: !timerStarted,
        textAlign: TextAlign.center,
        maxLength: 2,
        controller: controller,
        showCursor: false,
        style: const TextStyle(
            fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            counterText: '',
            constraints: BoxConstraints(
                maxWidth: 45, minWidth: 45, maxHeight: 40, minHeight: 40),
            border: OutlineInputBorder(borderSide: BorderSide.none),
            contentPadding: EdgeInsets.all(0)),
        onTap: () {
          //FIXME it is not selecting text anymore when input field first tapped and keyboard pulls up
          if (!timerStarted) {
            controller.selection = TextSelection(
              baseOffset: 0,
              extentOffset: controller.value.text.length,
            );
          } else {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        // Save set time when tapped outside or submitted.
        onTapOutside: (event) {
          setState(() {
            time = Duration(
                hours: int.parse(hourController.text),
                minutes: int.parse(minuteController.text),
                seconds: int.parse(secondController.text));
          });
        },
        onSubmitted: (value) {
          setState(() {
            time = Duration(
                hours: int.parse(hourController.text),
                minutes: int.parse(minuteController.text),
                seconds: int.parse(secondController.text));
          });
        },
      ),
    );
  }

  Widget buildTimeSeparator() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Text(
        ":",
        style: TextStyle(
            fontSize: 30, color: Colors.grey, fontWeight: FontWeight.bold),
      ),
    );
  }

  // If timer not started only start button, when started cancel and pause/resume button.
  Widget buildTimerButtons() {
    if (!timerStarted) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              timerStarted = true;
            });
            runTimer();
            FocusManager.instance.primaryFocus?.unfocus();
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

  // Timer.periodic() runs the callback function every 1 second until timer canceled
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
      makeAlarmSound(context);
    }
  }

  // Use alert dialog and platform specific alarm tone when timer is up.
  Future<void> makeAlarmSound(BuildContext context) async {
    FlutterRingtonePlayer.play(
        asAlarm: true,
        android: AndroidSounds.alarm,
        ios: IosSounds.alarm,
        looping: true);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('Alarm')),
          content: const Text(
            'Time is up!',
            textAlign: TextAlign.center,
          ),
          actions: [
            Center(
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
                child: const Text('OK'),
                onPressed: () {
                  FlutterRingtonePlayer.stop();
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    hourController.dispose();
    minuteController.dispose();
    secondController.dispose();
    super.dispose();
  }
}
