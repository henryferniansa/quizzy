
import 'package:flutter/material.dart';
class QuestionWidget extends StatelessWidget{
  const QuestionWidget({Key? key, required this.question, required this.indexAction,
  required this.totalQuestions}) :super(key: key);


  final String question;
  final int indexAction;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black54),
              borderRadius: BorderRadius.circular(10)
          ),
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          child: Text(question,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),),
        ),
        // Container(
        //
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       TextButton(onPressed: (){}, child: Icon(Icons.arrow_circle_left, size: 50,),),
        //       Text('Soal ${indexAction+1}', style: TextStyle(fontSize: 32),),
        //       TextButton(onPressed: (){}, child: Icon(Icons.arrow_circle_right, size: 50,),),
        //     ],
        //   ),
        // )
      ],
    );
  }
}