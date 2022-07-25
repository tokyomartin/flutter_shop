import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/model/province.dart';
import 'package:flutter_shop/provide/province.dart';
import 'package:flutter_shop/util/share_pref.dart';
// import 'package:flutter_learn/util/ToastUtil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../model/delivery_addr.dart';
import '../provide/delivery_addr.dart';


import 'ExpandDropdownButton.dart';
import 'ExpandPopupMenuDivider.dart';



/**
 * 注册地址 填写
 */

class PopViewPage extends StatefulWidget {
  PopViewPage({Key key}) : super(key: key);

  _PopViewPageState createState() => _PopViewPageState();
}

class _PopViewPageState extends State<PopViewPage> {
  // var content = 'One';
  // var content1 = 'One';
  // String selectedItem = '东京都';
  var prefecture = '東京都';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var last_name = '';
  var first_name = '';
  var last_name_kana = '';
  var first_name_kana = '';
  var post_code_front = '';
  var post_code_back = '';
  var city = '';
  var address1 = '';
  var phone_number = '';
  var company_name = '';
  var is_default = 0;

  void _forSubmitted() async{
    var _form = _formKey.currentState;

    if (_form.validate()) {
      _form.save();
      // print(first_name);
      // print(last_name);
      var member_id = await SharePref.getSharePrefMemberId(context);

      var bSuccess = await Provider.of<DeliveryAddrProvide>(context, listen: false).save(member_id, post_code_front, post_code_back, prefecture, city, address1, last_name, first_name, last_name_kana, first_name_kana, phone_number, company_name, is_default);
      if(bSuccess){
        Navigator.pop(context);
      }else{

      }

    }
  }


  Widget buildFirstRow1(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
            child:
            TextFormField(
              decoration: InputDecoration(
                hintText: '姓',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return '请输入姓';
                }
                return null;
              },
              onSaved: (val) {
                last_name = val;
                debugPrint("_first_name is " + last_name);
              },
            )
        ),
        Expanded(
            child:

            TextFormField(
              decoration: InputDecoration(
                hintText: '名',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return '请输入名';
                }
                return null;
              },
              onSaved: (val) {
                first_name = val;
                debugPrint("_last_name is " + first_name);
              },
            )
        )
      ],
    );
  }

  Widget buildFloorRow2(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              hintText: '姓（カタカナ）',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return '请输入姓（カタカナ）';
              }
              return null;
            },
            onSaved: (val) {
              last_name_kana = val;
              debugPrint("_katakana_first_name is " + last_name_kana);
            },
          ),
        ),
        Expanded(
            child:

            TextFormField(
              decoration: InputDecoration(
                hintText: '名（カタカナ）',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return '请输入名（カタカナ）';
                }
                return null;
              },
              onSaved: (val) {
                first_name_kana = val;
                debugPrint("_katakana_last_name is " + first_name_kana);
              },
            )
        )
      ],
    );
  }

  Widget buildFloorRow3(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              hintText: '邮政编码（上3桁）',
            ),
            validator: (value) {
              RegExp reg = new RegExp(r'^\d{3}$');
              if (!reg.hasMatch(value)) {
                return '请输入邮编上3桁';
              }
              return null;
            },
            onSaved: (val) {
              post_code_front = val;
              debugPrint(" front_post is " + post_code_front);
            },
          ),
        ),
        Expanded(
          child:TextFormField(
            decoration: InputDecoration(
              hintText: '下4桁',
            ),
            validator: (value) {
              RegExp reg = new RegExp(r'^\d{4}$');
              if (!reg.hasMatch(value)) {
                return '请输入邮编下4桁';
              }
              return null;
            },
            onSaved: (val) {
              post_code_back = val;
              debugPrint("_last_post is " + post_code_back);
            },
          ),
        )
      ],
    );
  }


  @override
  Widget build(BuildContext context) {





    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon:Icon(Icons.arrow_back),
            onPressed: (){
              debugPrint('返回上一页');
              Navigator.popAndPushNamed(context, "/");
            },
          ),
          title: Text("新建送货地址"),
          actions: <Widget>[
            // _NormalPopMenu(),
            // _DividerPopMenu(),
            _CustomPopMenu()
          ],
        ),
        body: FutureBuilder(
          future:_getDataList(context),
          builder: (context, snapshot) {

            // debugPrint(snapshot.toString());

            return snapshot.hasData
                ? Container(
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
              child: Column(
                  children: [
                    buildFirstRow1(context),
                    buildFloorRow2(context),
                    buildFloorRow3(context),

                    new DropdownButton<String>(
                      hint: Text("请输入都道府县"),
                      value: prefecture,
                      onChanged: (newValue) {
                        setState(() {
                          prefecture = newValue;
                        });
                      },
                      items: snapshot.data.map<DropdownMenuItem<String>>((ProvinceMode fc) {
                        // debugPrint(fc.toString());

                        return DropdownMenuItem<String>(
                          child: Text(fc.pref_name),
                          value: fc.pref_name, //fc.id.toString(),
                        );
                      })?.toList() ?? [],
                    ),

                    TextFormField(
                      decoration: InputDecoration(
                        hintText: '市区町村',
                      ),
                      // validator: (value) {
                      //   if (value.isEmpty) {
                      //     return '请输入市区町村';
                      //   }
                      //   return null;
                      // },
                      onSaved: (val) {
                        city = val;
                        debugPrint("city is " + city);
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: '番地、ビル名',
                      ),
                      // validator: (value) {
                      //   if (value.isEmpty) {
                      //     return '请输入番地、ビル名';
                      //   }
                      //   return null;
                      // },
                      onSaved: (val) {
                        address1 = val;
                        debugPrint("address1 is " + address1);
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: '連絡先（電話番号）',
                      ),
                      // validator: (value) {
                      //   if (value.isEmpty) {
                      //     return '请输入連絡先';
                      //   }
                      //   return null;
                      // },
                      onSaved: (val) {
                        phone_number = val;
                        debugPrint("phone_number is " + phone_number);
                      },
                    ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: RaisedButton(
                                child: Text('提交'),
                                onPressed:_forSubmitted,

                                // onPressed: () {
                                //
                                //   debugPrint("first_name is " + first_name);
                                //   debugPrint("last_name is " + last_name);
                                //
                                //
                                //   if (_formKey.currentState.validate()) {
                                //     Scaffold.of(context).showSnackBar(SnackBar(
                                //       content: Text('提交成功...'),
                                //     ));
                                //   }
                                // },
                              ),
                            )
                        ])
                  ],


              )
            ),
                    ],
                  ),
                )
                :Container();


          }
            //   (context,snapshot){
            //
            // List<DropdownMenuItem<String>> menuItems = [];
            // List provinceList = [];
            // List myL ist= Provider.of<ProvinceProvide>(context, listen: false).myDataList;
            //
            // myList.forEach((element) {
            //      ProvinceMode province = element;
            //      // provinceList.add(province.pref_name);
            //      menuItems.add(new DropdownMenuItem(child: Text(province.pref_name), value: province.id.toString()));
            // });

            // List<DropdownMenuItem<String>> get dropdownItems{
            //   List<DropdownMenuItem<String>> menuItems = [
            //     DropdownMenuItem(child: Text("USA"),value: "USA"),
            //     DropdownMenuItem(child: Text("Canada"),value: "Canada"),
            //     DropdownMenuItem(child: Text("Brazil"),value: "Brazil"),
            //     DropdownMenuItem(child: Text("England"),value: "England"),
            //   ];
            //   return menuItems;
            // }
          // },
        ),


    );
  }


  Future<List<ProvinceMode>> _getDataList(BuildContext context) async{

    debugPrint("-----------进入省市列表页面----------");
    await Provider.of<ProvinceProvide>(context, listen: false).getList(context);
    List<ProvinceMode> myList  =  Provider.of<ProvinceProvide>(context, listen: false).myDataList;

    // debugPrint("--------PROVINCE LIST---------" + myList.toString());
    return myList;// return 'end';
  }

  //自定义分割线 和 Item 样式
  Widget _CustomPopMenu() {
    return PopupMenuButton<String>(
        offset: Offset(0, 64),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: 'Item01',
            child: Row(children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                  child: Icon(Icons.search, color: Colors.blueAccent)),
              Text('Item One')
            ]),
          ),
          ExpandPopupMenuDivider<String>(height: 2.0, color: Colors.red),
          PopupMenuItem<String>(
              value: 'Item02',
              child: Row(children: <Widget>[
                Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                    child: Icon(Icons.home, color: Colors.blueAccent)),
                Text('Item Two')
              ])),
          ExpandPopupMenuDivider<String>(height: 2.0, color: Colors.red),
          PopupMenuItem<String>(
              value: 'Item03',
              child: Row(children: <Widget>[
                Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                    child: Icon(Icons.person, color: Colors.blueAccent)),
                Text('Item Three')
              ])),
          ExpandPopupMenuDivider<String>(height: 2.0, color: Colors.red),
          PopupMenuItem<String>(
              value: 'Item04',
              child: Row(children: <Widget>[
                Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                    child: Icon(Icons.local_grocery_store,
                        color: Colors.blueAccent)),
                Text('Item Four')
              ]))
        ],
        onSelected: (String value) {

          Fluttertoast.showToast(
              msg: value.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );

          // ToastUtil.show(value.toString());

        });
  }
}