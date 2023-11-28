import"package:flutter/material.dart";
import 'package:notedb/sqldb/sqldb.dart';
class EditNotes extends StatefulWidget{
  EditNotes({this.note,this.title,this.id});
  final note ;
  final title;
  final id;
  @override
  State<StatefulWidget> createState() {
    return _EditNotesState ();
  }

}
class _EditNotesState extends State<EditNotes>{
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();
  SqlDb sqldb = SqlDb();
  @override
  void initState() {
    note.text=widget.note;
    title.text=widget.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title:Text('Edit note') ,
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
                    int response= await sqldb.updateData('''
                   UPDATE 'notes' SET title = "${title.text}", note = "${note.text}"
                   WHERE id = ${widget.id}
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
                      child: Text('Edit note',style: TextStyle(color: Colors.white,fontSize: 20),),
                    ),
                  ),)
                ],
              ))
        ],
      ),
    );
  }

}
