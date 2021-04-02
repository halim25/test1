import 'package:flutter/material.dart';
import 'providers/notes.dart';
import 'products.dart';
import 'package:provider/provider.dart';
import 'add_products.dart';
import 'screens/notes_screen.dart';


void main() {
  runApp(
    ChangeNotifierProvider<Notes>(
      create: (_) => Notes(),
      child:MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Color.fromRGBO(205, 91 , 102,1),
         canvasColor: Color.fromRGBO(231, 231 , 231, 1)
         ),
      debugShowCheckedModeBanner: false,
      home: NotesScreen(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Product> prodList =
        Provider.of<Products>(context, listen: true).productsList;

    Widget buildText(title, desc, double price) {
      var description =
          desc.length >= 20 ? desc.replaceRange(20, desc.length, '...') : desc;
      return Positioned(
        bottom: 10,
        right: 10,
        child: Container(
          width: 180,
          color: Colors.black54,
          // margin: EdgeInsets.only(left: 100, top: 20),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Text(
            "$title\n$description\n\$$price",
            style: TextStyle(fontSize: 26, color: Colors.white),
            softWrap: true,
            overflow: TextOverflow.fade,
            maxLines: 4,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('My Products')),
      body: prodList.isEmpty
          ? Center(
              child: Text('No Products Added.', style: TextStyle(fontSize: 22)))
          : GridView(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisSpacing: 0,
                crossAxisSpacing: 10,
                maxCrossAxisExtent: 500,
                childAspectRatio: 2,
              ),
              children: prodList
                  .map(
                    (item) => Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 6,
                      margin: EdgeInsets.all(10),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              //topRight: Radius.circular(15),
                            ),
                            child: Image.file(item.image, fit: BoxFit.cover),
                          ),
                          buildText(item.title, item.description, item.price),
                          Positioned(
                            left: 10,
                            bottom: 10,
                            child: FloatingActionButton(
                              heroTag: item.description,
                              backgroundColor: Theme.of(context).primaryColor,
                              onPressed: () =>
                                  Provider.of<Products>(context, listen: false)
                                      .delete(item.description),
                              child: Icon(Icons.delete, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
      floatingActionButton: buildContainerButton(context),
    );
  }

  Container buildContainerButton(BuildContext context) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Theme.of(context).primaryColor,
      ),
      child: TextButton.icon(
        label: Text("Add Product",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
        icon: Icon(Icons.add),
        onPressed: () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (ctx) => AddProduct())),
      ),
    );
  }
}
