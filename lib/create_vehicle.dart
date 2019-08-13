import 'package:flutter/material.dart';
import 'generated/i18n.dart';
import 'util.dart';
import 'server.dart';
import 'apikeys.dart';
import 'server.dart' as server;

class CreateVehicle extends StatefulWidget {
  _CreateVehicleState createState() => _CreateVehicleState();
}

class _CreateVehicleState extends State<CreateVehicle> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _makeController = TextEditingController();
  final _modelController = TextEditingController();
  final _colorController = TextEditingController();
  final _plateController = TextEditingController();
  final _yearController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void createVehicle(BuildContext context) async {
    debugPrint('creating');
    FocusScope.of(context).requestFocus(new FocusNode());
    if (_formKey.currentState.validate()) {
      debugPrint('valid');
      Vehicle v = Vehicle(
          -1,
          _nameController.text,
          _makeController.text,
          _modelController.text,
          _colorController.text,
          _plateController.text,
          false,
          4,
          int.parse(_yearController.text));
      String result = await createNewVehicle(v);
      if (result.length == 0) {
        Navigator.of(context).pop();
        return;
      } else {
        // TODO
        debugPrint('Error creating vehicle: ' + result);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO
    return Scaffold(
        body: Padding(
            padding: FORM_PADDING,
            child: Center(
                child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                              textInputAction: TextInputAction.next,
                              controller: _nameController,
                              decoration: InputDecoration(
                                  labelText: S.of(context).vehicleTitle)),
                          TextFormField(
                              textInputAction: TextInputAction.next,
                              controller: _makeController,
                              decoration: InputDecoration(
                                  labelText: S.of(context).vehicleMake)),
                          TextFormField(
                              textInputAction: TextInputAction.next,
                              controller: _modelController,
                              decoration: InputDecoration(
                                  labelText: S.of(context).vehicleModel)),
                          TextFormField(
                              textInputAction: TextInputAction.next,
                              controller: _colorController,
                              decoration: InputDecoration(
                                  labelText: S.of(context).vehicleColor)),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: _yearController,
                            decoration: InputDecoration(
                                labelText: S.of(context).vehicleYear),
                            keyboardType: TextInputType.number,
                          ),
                          TextFormField(
                              textInputAction: TextInputAction.next,
                              controller: _plateController,
                              decoration: InputDecoration(
                                  labelText: S.of(context).vehiclePlate)),
                          Padding(
                              padding: SUBMIT_BUTTON_PADDING,
                              child: Center(
                                  child: MaterialButton(
                                      child: Text(S.of(context).createRide),
                                      onPressed: () {
                                        createVehicle(context);
                                      })))
                        ])))),
        appBar: AppBar());
  }
}
