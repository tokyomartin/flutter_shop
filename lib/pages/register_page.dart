import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/model/province.dart';
import 'package:flutter_shop/pages/index_page.dart';
import 'package:flutter_shop/provide/province.dart';
import 'package:flutter_shop/provide/user.dart';
import 'package:flutter_shop/util/share_pref.dart';
// import 'package:flutter_learn/util/ToastUtil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';


/**
 * 注册地址 填写
 */

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var email = '';
  var password = '';
  var password_confirmation = '';

  void _forSubmitted() async{
    FormState? _form = _formKey.currentState;

    if (_form?.validate() == true) {
      _form?.save();

      print(email);
      print(password);
      print(password_confirmation);


     await Provider.of<UserProvider>(context, listen: false).signup(  email, password, password_confirmation);

      var member_id =  await SharePref.getSharePrefMemberId(context);
      if(member_id != null){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => IndexPage()), (Route<dynamic> route) => false);
      }


    }
  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          title: Text("注册页面"),
          actions: <Widget>[

            // _CustomPopMenu()
          ],
        ),
    // body: FutureBuilder(
    // future:_getDataList(context),
    //     builder: (context, snapshot) {

        body: Container(
          child: Column(
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [

                      TextFormField(
                        decoration: InputDecoration(
                          hintText: '邮箱 Email',
                        ),
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return '请输入市区町村';
                        //   }
                        //   return null;
                        // },
                        onSaved: (val) {
                          email = val!;
                          debugPrint("邮箱 is " + email);
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: '密码 password',
                        ),
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return '请输入番地、ビル名';
                        //   }
                        //   return null;
                        // },
                        onSaved: (val) {
                          password = val!;
                          debugPrint("password is " + password);
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: '再次输入密码',
                        ),
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return '请输入連絡先';
                        //   }
                        //   return null;
                        // },
                        onSaved: (val) {
                          password_confirmation = val!;
                          debugPrint("密码 is " + password_confirmation);
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
        ),
    );
  }


  Future<List<ProvinceMode>> _getDataList(BuildContext context) async{

    debugPrint("-----------进入注册页面----------");
    return <ProvinceMode>[];
    // await Provider.of<ProvinceProvide>(context, listen: false).getList(context);
    // List<ProvinceMode> myList  =  Provider.of<ProvinceProvide>(context, listen: false).myDataList;
    //
    // // debugPrint("--------PROVINCE LIST---------" + myList.toString());
    // return myList;// return 'end';

  }





}