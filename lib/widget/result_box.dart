import 'package:flutter/material.dart';
import 'package:quiz/constants.dart';
import 'package:quiz/matpel.dart';

class ResultBox extends StatelessWidget{
  const ResultBox({Key? key, required this.result, required this.questionLength, required this.onPressed}) :super(key: key);
  final int result;
  final int questionLength;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xffA2B29F),
      content:
      Padding(
          padding: const EdgeInsets.all(50),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
              'Result',
            style: TextStyle(color: neutral, fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          CircleAvatar(
            radius: 70,
            backgroundColor: result == questionLength/2 ? Colors.yellow : result < questionLength/2 ? incorrect : correct,
            child: Text('${result*10}',
            style: const TextStyle(fontSize: 30),),
          ),
          const SizedBox(height: 20,),
          Text( result == questionLength/2 ? 'Bagus' : result < questionLength/2 ? 'Gagal' : 'Sempurna',
          style: const TextStyle(color : neutral),),
          const SizedBox(height: 20,),

          GestureDetector(
            onTap: onPressed,
            child: Container(
              alignment: Alignment.center,
              width: 150,
              height: 50,
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(10)
              ),
              child: const Text('Tes Lagi',
              style: TextStyle(color: Colors.black,
              fontSize: 20,
              letterSpacing: 1),
              ),
            ),
          ),
          const SizedBox(height: 20,),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Container(
              alignment: Alignment.center,
              width: 150,
              height: 50,
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: const Text('Menu',
                style: TextStyle(color: Colors.black,
                    fontSize: 20,
                    letterSpacing: 1),
              ),
            ),
          )

        ],
      ),),
    );
  }
}