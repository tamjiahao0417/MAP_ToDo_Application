import 'package:flutter/material.dart';

void main() {
  
  // Entry point of the app
  runApp(MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        
      // Sets the home screen of the app
      home: HomeScreen(), 
      
      // Removes debug banner
      debugShowCheckedModeBanner: false, 
      
      // Sets the app theme color
      theme: ThemeData(primarySwatch: Colors.indigo), 
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // List to store tasks  
  List<String> todoList = [];

  // Controller for text input
  final TextEditingController _controller = TextEditingController(); 

  // Index to track which task is being edited
  int updateIndex = -1;

  // Function to add a new task to the list
  addList(String task) {
      setState(() {
            todoList.add(task);
            _controller.clear();
      });
  }

  // Function to update an existing task
  updateListItem(String task, int index) {
      setState(() {
            todoList[index] = task;
            
            // Reset update index
            updateIndex = -1; 
            _controller.clear();
      });
  }

  // Function to delete a task
  deleteItem(index) {
      setState(() {
          todoList.removeAt(index);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Todo Application",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        
        // Centers the app bar title
        centerTitle: true, 
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Your custom styled input field
            TextFormField(
    
              // Input field controller
              controller: _controller, 
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.green,
                    )),
                filled: true,
                
                // Placeholder text
                labelText: 'Create Task....', 
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20), // Spacing

            Expanded(
              child: ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    color: Colors.green,
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 80,
                            child: Text(
                              todoList[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                           // Edit button
                          IconButton(
                            onPressed: () {
                                  setState(() {
                                        _controller.clear();
                                        _controller.text = todoList[index];
                                        updateIndex = index;
                                  });
                            },
                            icon: Icon(
                                  Icons.edit,
                                  size: 30,
                                  color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 10),

                          // Delete button
                          IconButton(
                            onPressed: () {
                                  deleteItem(index);
                            },
                            icon: Icon(
                                  Icons.delete,
                                  size: 30,
                                  color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: () {
          if (_controller.text.isNotEmpty) {
            updateIndex != -1
                ? updateListItem(_controller.text, updateIndex)
                : addList(_controller.text);
          }
        },
        child: Icon(updateIndex != -1 ? Icons.edit : Icons.add),
      ),
    );
  }
}