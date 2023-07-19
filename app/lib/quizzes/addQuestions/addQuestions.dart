import 'package:app/dataBases/db_connect.dart';
import 'package:app/quizzes/question_model.dart';
import 'package:flutter/material.dart';
import 'package:app/constants/colors.dart';
import 'package:table_calendar/table_calendar.dart';

 
// ignore: camel_case_types
class addQuestion extends StatelessWidget {
  const addQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Add Daily Questions'),
        backgroundColor: blueGrey,
      ),
      body:  const Padding(
        padding: EdgeInsets.all(16.0),
        child: QuestionAndAnswersWidget(),
      ),
    );
  }
}


class QuestionAndAnswersWidget extends StatefulWidget {
  const QuestionAndAnswersWidget({super.key});

  @override
  _QuestionAndAnswersWidgetState createState() =>
      _QuestionAndAnswersWidgetState();
}

class _QuestionAndAnswersWidgetState extends State<QuestionAndAnswersWidget> {
  final TextEditingController _questionController = TextEditingController();
  final List<TextEditingController> _answerControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  final List<bool> _isCorrect = [false, false, false, false];
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _questionController.dispose();
    _answerControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Enter your question:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          TextFormField(
            controller: _questionController,
            decoration: const InputDecoration(
              hintText: "Type your question here",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Enter the four answers:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          for (int i = 0; i < 4; i++)
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _answerControllers[i],
                    decoration: InputDecoration(
                      hintText: "Enter answer ${i + 1}",
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                Checkbox(
                  value: _isCorrect[i],
                  onChanged: (value) {
                    setState(() {
                      _isCorrect[i] = value ?? false;
                    });
                  },
                ),
                const Text('Correct'),
              ],
            ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Select the quiz date:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: Text(
              "${_selectedDate.toLocal()}".split(' ')[0],
            ),
            onTap: () => _selectDate(context),
          ),
          ElevatedButton(
            onPressed: () {
              if(getQuestion() == ''){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Please add a title'),
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.symmetric(vertical: 20.0),
                  ));
              }
              else if(emptyAnswer()){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('One or more Answer boxes is missing'),
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.symmetric(vertical: 20.0),
                  ));
              }
              else if(noSolution()){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('No Solution to Problem'),
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.symmetric(vertical: 20.0),
                  ));
              }
              else{
                Question question = Question(title: getQuestion(), answers: getanswerKey());
                DateTime datez = getSelectedDate();
                addToDB(question, datez);
                ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                    content: Text('Questions Successfully added to the daily quiz on ${datez.month}-${datez.day}-${datez.year}'),
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                  ));

              }
              // print(getQuestion());
              // print(getAnswers());
              // print(getCorrectAnswers());
              // print( getSelectedDate());
              // print(getanswerKey());
              // _firebaseService.updateQuiz(
              //   _questionController.text,
              //   _answerControllers.map((controller) => controller.text).toList(),
              //   _isCorrect,
              //   _selectedDate,
              // );
            },
            style:  const ButtonStyle(backgroundColor: MaterialStatePropertyAll(blueGrey)),
            child: const Text('Add Daily Quiz'),

          ),
        ],
      ),
    );
  }

  // You can use these methods to retrieve the entered data if needed.
  String getQuestion() {
    return _questionController.text;
  }

  List<String> getAnswers() {
    return _answerControllers.map((controller) => controller.text).toList();
  }

  List<bool> getCorrectAnswers() {
    return _isCorrect;
  }

  DateTime getSelectedDate() {
    return _selectedDate;
  }

  bool emptyAnswer(){
    List<String> options = getAnswers();
    for(String opt in options){
      if(opt == ''){
        return true;
      }
    }
    return false;
  }

  bool noSolution(){
    List<bool> isCorrect = getCorrectAnswers();
    for(bool ans in isCorrect){
      if(ans){
        return false;
      }
    }
    return true;

  }

  List<Answer> getanswerKey(){
    List<String> opts = getAnswers();
    List<bool> ans = getCorrectAnswers();
    List<Answer>  answerz = [];
    for(int i = 0; i< ans.length; i++){
      answerz.add(Answer(option: opts[i], isCorrect: ans[i]));
    }

    return answerz;
  }
}
