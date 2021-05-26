import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sociaapp/shared/styles/icon_broken.dart';

void navigateto(context, Widget) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Widget));
}
Widget defaultTextButton({
  @required Function function,
  @required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
      ),
    );
Widget defaultAppBar({
  @required BuildContext context,
  String title,
  List<Widget> actions,
}) => AppBar(
  leading: IconButton(
    onPressed: ()
    {
      Navigator.pop(context);
    },
    icon: Icon(
      IconBroken.Arrow___Left_2,
    ),
  ),
  titleSpacing: 5.0,
  title: Text(
    title,
  ),
  actions: actions,
);


Widget defaultTextField(
    {@ required TextEditingController controller,
      @ required String label,
      @ required IconData prefix,
        IconData suffix,
       Function presssufix,
       Function onChange,
      Function onsumbit,
      @ required Function validator,
       bool readonly = false,
    TextInputType textInputType,
    bool obscure = false}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(prefix),
      suffixIcon: IconButton(
        icon: Icon(suffix),
        onPressed: presssufix,
      ),
      border: OutlineInputBorder(),
    ),
    readOnly: readonly,
    keyboardType: textInputType,
    obscureText: obscure,
    validator: validator,
    onFieldSubmitted: onsumbit,
    onChanged: onChange,
  );
}

Widget defaultbutton({String text, Function press}) {
  return MaterialButton(
      minWidth: double.infinity,
      height: 50,
      color: Colors.blue,
      child: Text(
        text,
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
      onPressed: press);
}

void navigateRoute(context, Widget) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => Widget),
      (Route<dynamic> route) => false);
}

void defaultMessage({@required String message}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
