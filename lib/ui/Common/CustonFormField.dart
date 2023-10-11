import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/ui/Common/Provider.dart';
typedef Validator = String? Function(String?);
class CustomFormField extends StatefulWidget {
  TextEditingController a1;
  String hintText;
  TextInputType a2;
  bool is_icon;
  Validator? validtor;
  bool is_visable = true;
  int lines;
  bool is_loginOr_Register;

  CustomFormField(this.a1, this.hintText, this.a2, this.is_icon,this.validtor,{this.lines=1,this.is_loginOr_Register=false});

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    provider obj = Provider.of<provider>(context);

    return

      TextFormField(
        maxLines: widget.lines,
        minLines: 1,
        validator: widget.validtor,
      obscureText: widget.is_icon ? obj.is_visible : false,
      keyboardType: widget.a2,
      controller: widget.a1,
      decoration: InputDecoration(
        labelText: widget.hintText,
        labelStyle: TextStyle(color:widget.is_loginOr_Register?Colors.black:obj.currenttheme==ThemeMode.light?Colors.black:Colors.black),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        suffixIcon: widget.is_icon
            ? InkWell(
                onTap: () {
                  if (obj.is_visible) {
                    obj.is_visible = false;
                     obj.changeVisability();
                  } else {
                    obj.is_visible = true;
                    obj.changeVisability();
                  }
                  },
                child:obj.is_visible?
                const Icon(
                  Icons.visibility_off,
                  color: Colors.blue,
                ):
                const Icon(
                  Icons.remove_red_eye,
                  color: Colors.blue,
                ),
              )
            : null,
      ),
      style:  TextStyle(color:widget.is_loginOr_Register?Colors.black:obj.currenttheme==ThemeMode.light?Colors.black:Colors.white),
    );
  }
}
