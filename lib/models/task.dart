class TaskModel{
  String? _title;
  DateTime ? _date;
  TaskModel(String title, DateTime date){
    _title = title;
    _date = date;
  }
  get title => _title;
  get date => _date;
  toJson() {
    return {
      "title" : this._title,
      "date" : this._date
    };
  }
}