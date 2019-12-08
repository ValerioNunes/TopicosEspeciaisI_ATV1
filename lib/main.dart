import 'package:flutter/material.dart';
import 'package:topicos1atv1/model/pressao_arterial.dart';
import 'package:topicos1atv1/model/quadro_pressao_arterial.dart';
import 'package:topicos1atv1/service/hipertensao_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Níveis da Pressão Arterial'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _maxima = new TextEditingController();
  TextEditingController _minima= new TextEditingController();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  PressaoArterial _model;

  @override
  void initState() {
    super.initState();
  }

  Widget _showImage(String dir){
    return Card(
      child: Image.asset(
        dir,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _showCadEdt() {

    bool submit() {
      _model =  new PressaoArterial();

      if (this._formKey.currentState.validate()) {
        _formKey.currentState.save(); // Save our form now.

        setState(() {
         print(_model);
        });

        return true;
      }
      return false;
    }

     Widget getQuadro(PressaoArterial model){
      if(model !=  null) {
        QuadroPressaoArterial quadro = HipertensaoService.getQuadroParaPressaoArterial(model);

        String dir = (quadro == QuadroPressaoArterial.Pressao_Normal) ? "assets/launcher/normal.PNG":
                     (quadro == QuadroPressaoArterial.Limitrofe) ? "assets/launcher/limitrofe.PNG" :
                     (quadro == QuadroPressaoArterial.Alta) ? "assets/launcher/alta.PNG" :
                     (quadro == QuadroPressaoArterial.ForaDeRange) ? "assets/launcher/limitrofe.PNG" : "assets/launcher/fora.jpg";
        return _showImage(dir);
     }else
      return  Container();

    }

    return new SafeArea(
        top: false,
        bottom: false,
        child:
            new Form(
            key: this._formKey,
            autovalidate: true,
            child: new ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: <Widget>[
                  Container(child:  getQuadro(_model), height: 320),
                  new TextFormField(
                      controller: _maxima,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.chevron_right),
                        hintText: 'Maxima Pressão Arterial',
                        labelText: 'Maxima',
                      ),
                      validator: (value) =>
                      value.isEmpty ? 'Digite o maxima da Pressão Arterial' : null,
                      onSaved: (String value) {
                        if(value != null && value != '')
                          this._model.maxima = int.parse(value);
                      }),
                  new TextFormField(
                      controller: _minima,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.chevron_right),
                        hintText: 'Mínima',
                        labelText: 'Mínima',
                      ),
                      validator: (value) =>
                      value.isEmpty ? 'Digite o minima da Pressão Arterial' : null,
                      onSaved: (String value) {
                        if(value != null && value != '')
                          this._model.minima =  int.parse(value);
                      }),
                  new Container(
                    child: new RaisedButton(
                      child: new Text('Verificar', style: new TextStyle(color: Colors.white)),
                      onPressed: () => (submit()),
                      color: Colors.lightGreen,
                    ),
                    margin: new EdgeInsets.only(top: 20.0),
                  )
                ]
            )),

        );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,),
      ),
      body: _showCadEdt(),
    );
  }
}
