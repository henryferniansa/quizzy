import 'package:flutter/material.dart';
import 'package:quiz/constants.dart';
import 'package:quiz/models/question_model.dart';
import 'package:quiz/widget/question_widget.dart';
import 'package:quiz/widget/next_button.dart';
import 'package:quiz/widget/options_card.dart';
import 'package:quiz/widget/result_box.dart';
import 'package:quiz/widget/timer.dart';
import '../models/connect_db.dart'; // Impor file database

class GenericQuizScreen extends StatefulWidget {
  final String subject;
  final String databaseUrl;

  const GenericQuizScreen({
    Key? key,
    required this.subject,
    required this.databaseUrl,
  }) : super(key: key);

  @override
  _GenericQuizScreenState createState() => _GenericQuizScreenState();
}

class _GenericQuizScreenState extends State<GenericQuizScreen> with TickerProviderStateMixin {
  late DBConnect db;
  late Future<List<Question>> _questions;
  late AnimationController _controller;

  int limitTime = 600;
  int index = 0;
  int score = 0;
  bool isPressed = false;
  bool isAlreadySelected = false;

  @override
  void initState() {
    super.initState();
    db = DBConnect(widget.databaseUrl);
    _questions = db.fetchQuestion();
    initializeController();
  }

  void initializeController() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: limitTime),
    );

    _controller.addListener(() {
      if (_controller.isCompleted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => ResultBox(
            result: score,
            questionLength: 10, // Bisa disesuaikan dengan jumlah soal dinamis
            onPressed: startOver,
          ),
        );
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void nextQuestion(int questionLength) {
    if (index == questionLength - 1) {
      _controller.dispose();
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => ResultBox(
          result: score,
          questionLength: questionLength,
          onPressed: startOver,
        ),
      );
    } else {
      setState(() {
        index++;
        isPressed = false;
        isAlreadySelected = false;
      });
    }
  }

  void checkAnswerAndUpdate(bool value) {
    if (isAlreadySelected) return;
    if (value == true) {
      score++;
    }
    setState(() {
      isPressed = true;
      isAlreadySelected = true;
    });
  }

  void startOver() {
    _controller.dispose();
    setState(() {
      index = 0;
      limitTime = 600;
      score = 0;
      isPressed = false;
      isAlreadySelected = false;
    });
    Navigator.pop(context);
    initializeController();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Question>>(
      future: _questions,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          } else if (snapshot.hasData) {
            var extractedData = snapshot.data!;
            // Tampilan quiz menggunakan extractedData
            return Scaffold(
              appBar: AppBar(
                title: Text(widget.subject, style: const TextStyle(color: Colors.black)),
                centerTitle: true,
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: Colors.transparent,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'Score: $score',
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  )
                ],
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Timer(
                      animation: StepTween(begin: limitTime, end: 0).animate(_controller),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text('Soal ${index + 1}', style: const TextStyle(fontSize: 20)),
                          ),
                          QuestionWidget(
                            indexAction: index,
                            question: extractedData[index].title,
                            totalQuestions: extractedData.length,
                          ),
                          const SizedBox(height: 50),
                          for (int i = 0; i < extractedData[index].options.length; i++)
                            GestureDetector(
                              onTap: () => checkAnswerAndUpdate(
                                extractedData[index].options.values.toList()[i],
                              ),
                              child: OptionCard(
                                option: extractedData[index].options.keys.toList()[i],
                                color: isPressed
                                    ? (extractedData[index].options.values.toList()[i] == true ? correct : incorrect)
                                    : neutral,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              floatingActionButton: GestureDetector(
                onTap: () => nextQuestion(extractedData.length),
                child: const NextButton(),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            );
          }
        } else {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 25),
                Text(
                  'Soal Sedang Disiapkan, Harap Tunggu...',
                  style: TextStyle(color: Colors.white70, decoration: TextDecoration.none, fontSize: 18),
                ),
              ],
            ),
          );
        }
        return const Center(child: Text('no data'));
      },
    );
  }
}