import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'chart.dart';

class LineChartWW extends StatefulWidget {
  int? record;
  int? mondayRecord;
  int? tuesdayRecord;
  int? wednesdayRecord;
  int? thursdayRecord;
  int? fridayRecord;
  int? saturdayRecord;
  // int? sundayRecord;
  // String? mon, tue, wed, thu, fri, sat, sun;
  LineChartWW({this.record,
    this.mondayRecord,
    this.tuesdayRecord,
    this.wednesdayRecord,
    this.thursdayRecord,
    this.fridayRecord,
    this.saturdayRecord,
    // this.sundayRecord,
    // this.mon, this.tue, this.wed, this.thu, this.fri, this.sat, this.sun,
    Key? key}) : super(key: key);

  @override
  State<LineChartWW> createState() => _LineChartWWState();
}

class _LineChartWWState extends State<LineChartWW> {

  late List<ChartData> chartdata = [
    ChartData("1-5", widget.mondayRecord??1,),
    ChartData("6-10", widget.tuesdayRecord??1,),
    ChartData("11-15", widget.wednesdayRecord??1,),
    ChartData("16-20", widget.thursdayRecord??1),
    ChartData("21-25", widget.fridayRecord??1,),
    ChartData("26-31", widget.saturdayRecord??1,),
  ];

  @override
  Widget build(BuildContext context) {
    // print(widget.sundayRecord);
    return Container(
      padding: EdgeInsets.only(top: 10,right: 10,left: 10),
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.teal.withOpacity(0.3),
      ),
      child: Center(
        child: Container(
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            series: <ChartSeries>[
              StackedColumnSeries<ChartData,String>(
                dataSource: chartdata,
                xValueMapper: (ChartData ch, _)=> ch.x,
                yValueMapper: (ChartData ch, _)=> ch.y1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
