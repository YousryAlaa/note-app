import"package:flutter/material.dart";
import 'package:notedb/sqldb/sqldb.dart';
class AddNotes extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
      return _AddNotesState ();
  }

}
class _AddNotesState extends State<AddNotes>{
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();
  SqlDb sqldb = SqlDb();

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.red,
       title:Text('Add note') ,
     ),
     body: ListView(
       children: [
         Form(key: formstate,
             child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 TextFormField(
                   controller: title
                   ,decoration: InputDecoration(
                     hintText: 'Title',
                     prefixIcon: Icon(Icons.title)
                   ),
                 ),
                 TextFormField(
                   controller: note
                   ,decoration: InputDecoration(
                     hintText: 'Note',
                     prefixIcon: Icon(Icons.note_add)
                 ),
                 ),
                 SizedBox(height: 40,),
                 MaterialButton(onPressed: () async {
                   int response= await sqldb.insertData('''
                   INSERT INTO 'notes' ('title' , 'note') VALUES ("${title.text}","${note.text}")
                   ''');
                   if (response>0){
                     Navigator.of(context).pushReplacementNamed("home");
                   }
                 },child: Container(
                   height: 50,
                   width: 150,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                     color: Colors.red
                   ),
                   child: Center(
                     child: Text('Add note',style: TextStyle(color: Colors.white,fontSize: 20),),
                   ),
                 ),)
               ],
         ))
       ],
     ),
   );
  }

}