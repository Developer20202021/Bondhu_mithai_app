import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PerDaySalesHistoryChart extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  PerDaySalesHistoryChart({Key? key}) : super(key: key);
 
  @override
  PerDaySalesHistoryChartState createState() => PerDaySalesHistoryChartState();
}
 
class PerDaySalesHistoryChartState extends State<PerDaySalesHistoryChart> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;
  double myValue = 1412;


     void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
      // TODO: implement your code here

      dynamic value = args.value;
      
      print(value);
    }
 
  @override
  void initState() {
    data = [
      _ChartData('23/12/2023', 1112),
  


    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:  AppBar(
        
        iconTheme: IconThemeData(color: Colors.purple),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),

        title: const Text("Today Sales History", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
       actions: [
        IconButton(onPressed: (){


          showModalBottomSheet(
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[


          Container(
                child: SfDateRangePicker(
                  onSelectionChanged: _onSelectionChanged,
                  selectionMode: DateRangePickerSelectionMode.range,
                  todayHighlightColor: Colors.purple,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 150,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.purple),
                  ),
                ),
              )
        
        ],
      );
    });

        }, icon: Icon(Icons.date_range, color: Colors.purple,))

      ],
        
      ),


      
        body: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(minimum: 0, maximum: myValue, interval: 1000),
            tooltipBehavior: _tooltip,
            series: <ChartSeries<_ChartData, String>>[
              ColumnSeries<_ChartData, String>(
                 borderRadius: BorderRadius.all(Radius.circular(5)),
                  dataSource: data,
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  name: 'টাকা',
                  color: Colors.purple)
            ]));
  }
}
 
class _ChartData {
  _ChartData(this.x, this.y);
 
  final String x;
  final double y;
}




