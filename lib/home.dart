import 'package:flutter/material.dart';
import 'package:notedb/editnote/editnote.dart';
import 'package:notedb/sqldb/sqldb.dart';
class MyHomePage extends StatefulWidget {


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List notes = [];
  bool isloading = true ;
  SqlDb sqldb =new SqlDb();
    readData()async{
    List<Map> response = await sqldb.readData('SELECT * FROM notes');

    if(this.mounted) {
      setState(() {
        notes.addAll(response);
        isloading = false;

      });
    }

  }
  @override
  void initState() {
    readData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.red,
      ),
      body: isloading == true ? Center(child: Text('loading....'),) : ListView(
        children: [
          // MaterialButton(onPressed: ()async{
          //   await sqldb.mydeletedatabase();
          // },child: Text('Delete Database'),),

               ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: notes.length,
                  itemBuilder: (context,i){
                return Card(
                  child: ListTile(

                    title: Text('${notes[i]['title']}',style: TextStyle(color: Colors.red)),
                    subtitle: Text('${notes[i]['note']}',style: TextStyle(color: Colors.black)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: () async {
                          int response = await sqldb.deleateData('''
                      DELETE FROM 'notes' WHERE id = '${notes[i]['id']}'
                      ''');
                          if(response>0){
                            setState(() {
                              notes.removeWhere((element) => element['id'] == notes[i]['id']);
                            });
                          }
                        }, icon: Icon(Icons.delete),color: Colors.red,),
                        IconButton(onPressed: ()  {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditNotes(
                            id:  notes[i]['id'],
                            title:  notes[i]['title'],
                            note:  notes[i]['note'],)));
                        }, icon: Icon(Icons.edit),color: Colors.blue,),
                      ],
                    )
                  ),
                );
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: (){
        Navigator.of(context).pushReplacementNamed('addnotes');
      },child: Icon(Icons.add),),
    );
  }


}
