import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guessthenumber/constants.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // snackbars
  final correctSnack = SnackBar(
    content: Text(
      "A correct guess",
      style: TextStyle(color: Constants.darkColor),
    ),
    backgroundColor: Constants.greenColor,
    duration: const Duration(seconds: 1, milliseconds: 500),
    padding: const EdgeInsets.all(12),
  );
  final wrongSnack = SnackBar(
    content: Text(
      "Wrong guess. Better Luck next time",
      style: TextStyle(color: Constants.borderWhite),
    ),
    backgroundColor: Constants.pinkColor,
    duration: const Duration(seconds: 1, milliseconds: 500),
    padding: const EdgeInsets.all(12),
  );

  int _counter = 0;
  int _dummy = 0;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _randomize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.darkColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Constants.pinkColor,
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Score: $_counter",
                    style: TextStyle(
                      fontSize: 24,
                      color: Constants.borderWhite,
                    )),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        "Try A Number between 0 and 9(both inclusive)"
                            .toUpperCase(),
                        style: TextStyle(
                            color: Constants.orangeColor,
                            fontSize: 30,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Constants.whiteColor),
                          borderRadius: BorderRadius.circular(8)),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'\d')),
                        ],
                        textAlign: TextAlign.center,
                        autofocus: true,
                        controller: _controller,
                        style: TextStyle(
                          color: Constants.yellowColor,
                        ),
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter your intuition",
                            hintStyle: TextStyle(color: Color(0xffade8f4))),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    (MediaQuery.of(context).size.width < 600)
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  _compute();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Constants.greenColor,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "Guess it!",
                                        style: TextStyle(
                                            fontFamily: "UbuntuMono",
                                            color: Constants.darkColor,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Constants.yellowColor,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "Restart",
                                        style: TextStyle(
                                            fontFamily: "UbuntuMono",
                                            color: Constants.darkColor,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  _compute();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Constants.greenColor,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "Guess it!",
                                        style: TextStyle(
                                            fontFamily: "UbuntuMono",
                                            color: Constants.darkColor,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _reset();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Constants.yellowColor,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "Restart",
                                        style: TextStyle(
                                            fontFamily: "UbuntuMono",
                                            color: Constants.darkColor,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _randomize() {
    int rand = Random().nextInt(10);
    setState(() {
      _dummy = rand;
    });
  }

  void _compute() {
    if (_controller.text == _dummy.toString()) {
      setState(() {
        _counter++;
      });
      _randomize();
      ScaffoldMessenger.of(context).showSnackBar(correctSnack);
    } else {
      _randomize();
      ScaffoldMessenger.of(context).showSnackBar(wrongSnack);
    }
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
    _randomize();
  }
}
