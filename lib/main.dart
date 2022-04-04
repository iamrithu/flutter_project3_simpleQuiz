import 'package:flutter/material.dart';
import 'package:quiz/questions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int n = 0;
  int score = 0;
  List questionList = [
    Questions("1 . MS Word is a hardware .", false),
    Questions("2 . CPU controls only input data of computer .", false),
    Questions("3 . CPU dtands for Central Processing Unit.", true),
    Questions(
        "4 . Freeware is sofrware that is available for use at no monetary cost.",
        false),
  ];

  void checkAns(bool ans, BuildContext ctx) {
    if (ans == questionList[n].answer) {
      score += 1;
      const snackbar = SnackBar(
        content: Text('Corret Answer'),
        backgroundColor: Colors.green,
        duration: Duration(milliseconds: 500),
      );

      ScaffoldMessenger.of(ctx).showSnackBar(snackbar);
    } else {
      const snackbar = SnackBar(
        content: Text('Wrong Answer'),
        backgroundColor: Colors.red,
        duration: Duration(milliseconds: 500),
      );

      ScaffoldMessenger.of(ctx).showSnackBar(snackbar);
    }

    setState(() {
      if (n < questionList.length - 1) {
        n = n + 1;
      } else {
        final snackbar = SnackBar(
          content: Text('Quiz Completed Score $score/4'),
          backgroundColor: Colors.blue.shade300,
          duration: const Duration(milliseconds: 5000),
        );
        reset();

        ScaffoldMessenger.of(ctx).showSnackBar(snackbar);
      }
    });
  }

  void reset() {
    setState(() {
      n = 0;
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SimpleQuiz'),
        backgroundColor: Colors.brown[400],
        centerTitle: true,
      ),
      body: Builder(
        builder: (ctx) => Container(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Score : $score/4',
                        style: TextStyle(
                            color: Colors.brown[400],
                            fontWeight: FontWeight.w400)),
                    InkWell(
                      onTap: () => reset(),
                      child: Text('Reset',
                          style: TextStyle(
                              color: Colors.red[400],
                              fontWeight: FontWeight.w400)),
                    ),
                  ],
                ),
                Container(
                    height: 100,
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(color: Colors.brown)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(questionList[n].question),
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => checkAns(false, ctx),
                      child: const Text('False'),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          )),
                    ),
                    ElevatedButton(
                      onPressed: () => checkAns(true, ctx),
                      child: const Text('True'),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          )),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
