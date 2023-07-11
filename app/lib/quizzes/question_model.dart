//All questions in our application will be modeled as a class
class Question{
  //unique identifier for each questio
  final String id;
  final String title; //question

  final Map<String, bool> options; //will be mapped like this: {'1.' : False, '2' : False, '3' : True, '4' : False}
  final bool isTapped = false;
  
  Question({
    required this.id,
    required this.title,
    required this.options,
  });

  //operator overloading(question will print to console when calling this function)
  @override
  String toString() {
    // TODO: implement toString
    return 'Question(id: $id, title: $title, options: $options)';
  }
}