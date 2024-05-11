class UserModel{
  int? userId;
  int? id;
  String? title;
  bool? completed;

  UserModel({this.title,this.completed,this.id,this.userId});

 factory UserModel.fromJson(Map<String,dynamic>mapData){
    return UserModel(
      completed: mapData['completed'],
      id: mapData['id'],
        userId: mapData['userId'],
      title: mapData['title']
    );
  }

  Map<String,dynamic>toJson(){
   return {
     "id":id,
     "userId":userId,
     "completed":completed,
     "title":title
   };
  }
}