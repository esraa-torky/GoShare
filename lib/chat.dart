import 'package:flutter/material.dart';
class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        shadowColor: Colors.transparent,
        leading: Icon(Icons.arrow_back),
        title: Row(
          children:<Widget> [
            CircleAvatar(backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage('https://icons-for-free.com/iconfiles/png/512/person-1324760545186718018.png',
            ),
            ),
            SizedBox(width: 12),
            Text('User name',style: TextStyle(
                fontSize: 16
            ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children:<Widget> [
            Expanded(child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.vertical,
                itemBuilder: (context,index) =>messagebody()
            ),
            ),
            Row(
              children:<Widget> [
                Expanded(
                  child: TextFormField(
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          hintText: 'message',
                          //fillColor: Colors.grey[100],
                          //filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(width: 1,color: Colors.green),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(width: 2,color: Colors.green)
                        ),
                      ),
                      validator: (name){
                        if(name.isEmpty)
                        {
                        }
                        return null;
                      }
                  ),
                ),
                IconButton(icon: Icon(Icons.send,color: Colors.green,))
              ],
            )
          ],
        ),
      ),
    );
  }
  Widget messagebody()=>
      Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm'),
            ),
            decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(18.0,)
            )
        ),
      );
}
