import "package:app/constants/colors.dart";
import 'package:app/dataBases/hive.dart';
import "package:flutter/material.dart";
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.addToData,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.goHome,
    required this.data,
  });
  final bool addToData;
  final int totalQuestions;
  final int correctAnswers;
  final VoidCallback goHome; // Callback to restart the quiz
  final ListData data;
  @override
  Widget build(BuildContext context) {
    return (addToData)
        ? DailyQuizResults(addedData: correctAnswers, goHome: goHome, resultData: data )
        : LevelResultsScreen(
            correctAnswers: correctAnswers,
            goHome: goHome,
            totalQuestions: totalQuestions,
          );
  }
}

class LevelResultsScreen extends StatelessWidget {
  final int totalQuestions;
  final int correctAnswers;
  final VoidCallback goHome; // Callback to restart the quiz

  const LevelResultsScreen({
    super.key,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.goHome,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueDark,
      appBar: AppBar(
        backgroundColor: blueGrey,
        title: const Text('Quiz Results'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Quiz Completed!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20.0,
              ),
              CircleAvatar(
                radius: 70.0,
                backgroundColor: (correctAnswers >= totalQuestions * 0.8)
                    ? correct
                    : incorrect,
                child: Text(
                  '$correctAnswers/$totalQuestions',
                  style: const TextStyle(fontSize: 30.0),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text((correctAnswers <= totalQuestions / 2)
                  ? 'Try Again'
                  : 'Good Job!'),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: goHome,
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(blueGrey)),
                child: const Text('Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultsData extends StatelessWidget {
  const ResultsData(
      {super.key, required this.resultData, required this.addedData});
  final ListData resultData;
  final int addedData;
  @override
  Widget build(BuildContext context) {
    List<GenertateResultData> generateResults() {
      List<GenertateResultData> dataList = [];
      for (int i = 0; i < resultData.integers.length; i++) {
        if (i == addedData) {
          dataList.add(GenertateResultData(i, resultData.integers[i], correct));
        } else {
          dataList.add(GenertateResultData(i, resultData.integers[i], grey));
        }
      }
      return dataList;
    }

    return 
        SizedBox(
          height: 400,
          child: SfCartesianChart(
            
            title: ChartTitle(
              text: 'Score Distribution',
              textStyle: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: grey),
            ),
            
            borderColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            plotAreaBorderColor: Colors.transparent, 
            
            primaryXAxis: NumericAxis(
                
                labelStyle: const TextStyle(color: grey, fontWeight:FontWeight.bold, fontFamily: "iter", fontSize: 15  ),

                minimum: -1,
                visibleMinimum: 0,
                interval: 1,
                axisBorderType: AxisBorderType.withoutTopAndBottom,
                borderColor: Colors.transparent,
                axisLine: const AxisLine(color: Colors.transparent),
                majorGridLines:
                    const MajorGridLines( width: 0, color: Colors.transparent)),
            primaryYAxis: NumericAxis(
                labelStyle: const TextStyle(color: grey),
                interval: 1,
                minimum: -1,
                visibleMinimum: 0,
                isVisible: false,
                majorGridLines:
                    const MajorGridLines(color: Colors.transparent)),
            series: <BarSeries<GenertateResultData, int>>[
              BarSeries<GenertateResultData, int>(
                
                dataSource: generateResults(),
                xValueMapper: (GenertateResultData scoreDistribution, _) =>
                    scoreDistribution.numCorrect,
                yValueMapper: (GenertateResultData scoreDistribution, _) =>
                    scoreDistribution.completed,
                pointColorMapper:
                    (GenertateResultData scoreDistribution, index) =>
                        scoreDistribution.color,
                color: grey,
                dataLabelSettings: const DataLabelSettings(
                    isVisible: true, textStyle: TextStyle(color: grey, fontSize: 15, fontWeight: FontWeight.bold, fontFamily: "iter")),
              )
            ],
          ),
        );

  }
}

class GenertateResultData {
  final int numCorrect;
  final int completed;
  final Color color;

  GenertateResultData(this.numCorrect, this.completed, this.color);
}


class DailyQuizResults extends StatelessWidget {
  const DailyQuizResults({super.key, required this.resultData, required this.addedData, required this.goHome,});
  final ListData resultData;
  final int addedData;
  final VoidCallback goHome;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: blueDark,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 100,
          ),
          const Text("Statistics",
              style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold, color: grey),
              textAlign: TextAlign.left),
          const SizedBox(height: 50),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(children: [
                Text("3",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold, color: grey),
                    textAlign: TextAlign.left),
                Text("Played",
                    style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold, color: grey),
                    textAlign: TextAlign.left),
              ]),
              Column(children: [
                Text("3",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold, color: grey),
                    textAlign: TextAlign.left),
                Text("Win%(over 80%)",
                    style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold, color: grey),
                    textAlign: TextAlign.left),
              ]),
              Column(children: [
                Text("3",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold, color: grey),
                    textAlign: TextAlign.left),
                Text("Current Streak",
                    style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold, color: grey),
                    textAlign: TextAlign.left),
              ]),
              Column(children: [
                Text("3",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold, color: grey),
                    textAlign: TextAlign.left),
                Text("Max Streak",
                    style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold, color: grey),
                    textAlign: TextAlign.left),
              ]),
            ],
          ),
          const SizedBox(height: 30,),
          ResultsData(resultData: resultData, addedData: addedData),
           ElevatedButton(
                  onPressed: goHome,
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(blueGrey)),
                  child: const Text('Home'),
                ),
    
        ],
      ),
    );
  }
}