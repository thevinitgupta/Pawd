import 'bar.dart';

class Usage{
  final double sunday;
  final double monday;
  final double tuesday;
  final double wednesday;
  final double thursday;
  final double friday;
  final double saturday;
  Usage({
    required this.sunday,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
  });

  List<Bar> barData = [];

  void initialize(){
    barData = [
      Bar(x: 0, y: sunday),
      Bar(x: 1, y: monday),
      Bar(x: 2, y: tuesday),
      Bar(x: 3, y: wednesday),
      Bar(x: 4, y: thursday),
      Bar(x: 5, y: friday),
      Bar(x: 6, y: saturday),
    ];
  }

}
