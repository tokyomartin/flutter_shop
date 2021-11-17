import 'package:flutter/material.dart';

// class FormTestRoute extends StatefulWidget {
//   @override
//   _FormTestRouteState createState() => _FormTestRouteState();
// }
//
// class _FormTestRouteState extends State<FormTestRoute> {


// Create a Form widget.
class FormTestRoute extends StatefulWidget {
  const FormTestRoute({Key key}) : super(key: key);

  @override
  FormTestRouteState createState() {
    return FormTestRouteState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class FormTestRouteState extends State<FormTestRoute> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();






  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above

    // List<DropdownMenuItem<String>> sortItems = [];
    // String _selectedSort = '排序';
    // sortItems.add(DropdownMenuItem(value: '排序', child: Text('排序')));
    // sortItems.add(DropdownMenuItem(value: '价格降序', child: Text('价格降序')));
    // sortItems.add(DropdownMenuItem(value: '价格升序', child: Text('价格升序')));
    //

    List<DropdownMenuItem> getItems() {
      List<DropdownMenuItem> items = [];
      for (int i = 0; i < 10; i++) {
        items.add(DropdownMenuItem(
          value: "${i}",
          child: Text("item ${i}"),
        ));
      }
      return items;
    }

    var _selectedSort;


    getList() {
      return
        DropdownButton(
          hint: Text("请选择"),
          items: getItems(),
          value: _selectedSort,
          elevation: 1,
          icon: Icon(
            Icons.airplay,
            size: 20,
          ),
          onChanged: (T) {
            //下拉菜单item点击之后的回调
            setState(() {
              _selectedSort = T;
            });
          },
        );
    }

    String _bodyStr = "显示菜单内容";
    getPopupMenuList(){
      return new PopupMenuButton(
          onSelected: (String value){
            setState(() {
              _bodyStr = value;
            });
          },
          itemBuilder: (BuildContext context) =><PopupMenuItem<String>>[
            new PopupMenuItem(
                value:"选项一的内容",
                child: new Text("选项一")
            ),
            new PopupMenuItem(
                value: "选项二的内容",
                child: new Text("选项二")
            )
          ]
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: new Text('新建地址'),
      ),
      body:  Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // getList(),
            getPopupMenuList(),
            new Text(_bodyStr),
          DropdownButton(
            hint: Text("请选择"),
            items: getItems(),
            value: _selectedSort,
            elevation: 1,
            icon: Icon(
              Icons.airplay,
              size: 20,
            ),
            onChanged: (T) {
              //下拉菜单item点击之后的回调
              setState(() {
                _selectedSort = T;
                // state.didChange(newValue);
              });
            },
          ),

            TextFormField(
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }



}