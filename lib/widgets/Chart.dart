import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pawd/res/colors.dart';
import 'package:pawd/utils/usage.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<double> weeklySummary = [4, 2, 42, 10, 100, 88, 90];
    Usage chartData = Usage(sunday: weeklySummary[0], monday: weeklySummary[1], tuesday: weeklySummary[2], wednesday: weeklySummary[3], thursday: weeklySummary[4], friday: weeklySummary[5], saturday: weeklySummary[6]);

    chartData.initialize();
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 300,
          width: 350,
          child: BarChart(

              BarChartData(
                  maxY: 150,
                  minY: 0,
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    show: true,
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: getBottomTiles,
                    )),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: getLeftTiles
                      ),

                    )
                  ),
                  gridData: FlGridData(show: false),
                  barGroups: chartData.barData.map((data) => BarChartGroupData(x: data.x, barRods: [BarChartRodData(
                      toY: data.y,
                    color: data.x==4 ? primaryColor : Colors.white24,
                    width: 20,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4), bottomLeft: Radius.zero, bottomRight: Radius.zero)
                  ),
                  ])).toList()
              )
          ),
        ),
      )
    );
  }
}

Widget getLeftTiles(double value, TitleMeta meta){
  const style = TextStyle(
      color: Colors.white,
      fontSize: 8
  );
  Widget text = Text("${value.toInt()}", style: style);
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}

Widget getBottomTiles(double value, TitleMeta meta){
  const style = TextStyle(
    color: Colors.white,
    fontSize: 14
  );
  Widget text;
  switch(value.toInt()){
    case 0:
      text = const Text('Su',style: style,);
      break;
    case 1:
      text = const Text('M',style: style,);
      break;
    case 2:
      text = const Text('T',style: style,);
      break;
    case 3:
      text = const Text('W',style: style,);
      break;
    case 4:
      text = const Text('T',style: style,);
      break;
    case 5:
      text = const Text('F',style: style,);
      break;
    case 6:
      text = const Text('Sa',style: style,);
      break;

    default:
      text = const Text("Day", style: style,);
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}
