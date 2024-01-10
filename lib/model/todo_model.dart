class ToDoModel {
  String _title;
  String _description;

  ToDoModel(this._title, this._description);

  String get title => _title;
  set title(String titleNew) => _title = titleNew;

  String get description => _description;
  set description(String descriptionNew) => _description = descriptionNew;
}
