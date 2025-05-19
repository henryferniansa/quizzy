

class Question{
  final String id;
  final String title;
  final Map<String, bool> options;

  Question({
    required this.id,
    required this.title,
    required this.options
});
  factory Question.fromJson(String id, Map<String, dynamic>json){
    return Question(id: id, title: json['title'] as String, options: Map<String, bool>.from(json['options'] as Map));
  }

  Map<String, dynamic>toJson(){
    return {
      'title': title,
      'options': options
    };
  }
   @override
  String toString() {

    return 'Question(id:$id, title:$title, options:$options)';
  }
}