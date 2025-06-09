import "package:flutter/material.dart";
import "package:flutter/services.dart";


// Brazillian CEP input widget
class CEPInput extends StatefulWidget 
{
  final IconData _submitButtonIcon;
  final void Function() _onSubmit;
  final TextEditingController _controller;

  const CEPInput(this._submitButtonIcon, this._onSubmit, this._controller, { super.key });

  @override
  State createState() 
  {
    return _CEPInputState();
  }
}

class _CEPInputState extends State<CEPInput> 
{
  String _err = "";

  _CEPInputState();

  bool _ensureLength() 
  {
    String cep = widget._controller.text;
    if (cep.length != 8) 
    {
      setState(() {
        _err = "CEP informado deve conter 8 caracteres!";
      });

      return false;
    }

    return true;
  }

  void _submit() 
  {
    if (!_ensureLength()) return;

    try 
    {
      widget._onSubmit();
    } catch (err) 
    {
      setState(() {
        _err = err.toString();
      });
    }
  }

  void _cleanErrorMessage() 
  {
    setState(() {
      _err = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.all(14.0), 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.0,
        children: <Widget>[
          Text(
            _err,
            style: TextStyle(
              fontSize: 12.0,
              color: colorScheme.error,
            ),
          ), 
          TextField(
            decoration: InputDecoration(
              labelText: "Insira seu CEP: ", 
              hintText: "EX: 12345678",
              border: OutlineInputBorder(), 
              suffixIcon: IconButton(
                icon: Icon(widget._submitButtonIcon), 
                onPressed: _submit,
              )
            ),
            keyboardType: TextInputType.number,
            maxLength: 8,
            inputFormatters: [ FilteringTextInputFormatter.digitsOnly ],
            controller: widget._controller,
            onTap: _cleanErrorMessage,
          )
        ],
      ),
    );
  }
}