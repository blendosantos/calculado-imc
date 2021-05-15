import 'package:calculadora/app/components/text_field_number.dart';
import 'package:calculadora/app/models/IMC.dart';
import 'package:calculadora/app/modules/home/home_bloc.dart';
import 'package:calculadora/app/modules/home/home_module.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _bloc = HomeModule.to.getBloc<HomeBloc>();

  TextEditingController _pesoController;
  TextEditingController _alturaController;
  TextEditingController _idadeController;

  _HomePageState() {
    _pesoController = TextEditingController();
    _alturaController = TextEditingController();
    _idadeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text(
          'Índice de Massa Corporal',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_outlined),
            onPressed: () {
              _idadeController.text = '';
              _alturaController.text = '';
              _pesoController.text = '';
              _bloc.clear();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          child: Column(
            children: [
              Container(
                width: size.width,
                padding: EdgeInsets.all(15),
                child: Wrap(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: size.width * 0.45,
                      child: TextFieldNumberCustom(
                        controller: _idadeController,
                        labelText: 'Idade',
                      ),
                    ),
                    Container(
                      width: size.width * 0.45,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(Icons.emoji_people,
                              size: size.width * 0.14, color: Colors.pink),
                          Icon(Icons.emoji_people,
                              size: size.width * 0.14,
                              color: Colors.blueAccent),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: size.width,
                padding: EdgeInsets.all(15),
                child: Wrap(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: size.width * 0.45,
                      child: TextFieldNumberCustom(
                        controller: _pesoController,
                        suffixText: 'kg',
                        labelText: 'Peso',
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: size.width * 0.45,
                      child: TextFieldNumberCustom(
                        controller: _alturaController,
                        suffixText: 'cm',
                        labelText: 'Altura',
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.03),
              ElevatedButton(
                child: Text(
                  "CALCULAR",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  try {
                    int idade = int.parse(_idadeController.text);
                    double peso = double.parse(_pesoController.text);
                    double altura = double.parse(_alturaController.text);
                    _bloc.calcularIMC(idade, peso, altura);
                  } catch (e) {
                    print('Campos vazios ou valores incorretos');
                  }
                },
              ),
              SizedBox(height: size.height * 0.03),

              // Grafico

              StreamBuilder<IMC>(
                  stream: _bloc.outIMC,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return SizedBox();
                    }
                    final imc = snapshot.data;
                    return Column(
                      children: [
                        SfRadialGauge(
                          animationDuration: 3500,
                          enableLoadingAnimation: true,
                          axes: <RadialAxis>[
                            RadialAxis(
                                startAngle: 130,
                                endAngle: 50,
                                minimum: 0,
                                maximum: 100,
                                interval: 10,
                                minorTicksPerInterval: 9,
                                showAxisLine: false,
                                radiusFactor: 0.9,
                                labelOffset: 8,
                                ranges: <GaugeRange>[
                                  GaugeRange(
                                      startValue: 0,
                                      endValue: 18.59,
                                      startWidth: 0.265,
                                      sizeUnit: GaugeSizeUnit.factor,
                                      endWidth: 0.265,
                                      color: const Color.fromRGBO(
                                          34, 144, 199, 0.75)),
                                  GaugeRange(
                                      startValue: 18.6,
                                      endValue: 24.99,
                                      startWidth: 0.265,
                                      sizeUnit: GaugeSizeUnit.factor,
                                      endWidth: 0.265,
                                      color: const Color.fromRGBO(
                                          123, 199, 34, 0.75)),
                                  GaugeRange(
                                      startValue: 25,
                                      endValue: 29.99,
                                      startWidth: 0.265,
                                      sizeUnit: GaugeSizeUnit.factor,
                                      endWidth: 0.265,
                                      color: const Color.fromRGBO(
                                          238, 193, 34, 0.75)),
                                  GaugeRange(
                                      startValue: 30,
                                      endValue: 34.99,
                                      startWidth: 0.265,
                                      sizeUnit: GaugeSizeUnit.factor,
                                      endWidth: 0.265,
                                      color: const Color.fromRGBO(
                                          249, 177, 48, 0.75)),
                                  GaugeRange(
                                      startValue: 35,
                                      endValue: 39.99,
                                      startWidth: 0.265,
                                      sizeUnit: GaugeSizeUnit.factor,
                                      endWidth: 0.265,
                                      color: const Color.fromRGBO(
                                          248, 138, 58, 0.65)),
                                  GaugeRange(
                                      startValue: 40,
                                      endValue: 100,
                                      startWidth: 0.265,
                                      sizeUnit: GaugeSizeUnit.factor,
                                      endWidth: 0.265,
                                      color: const Color.fromRGBO(
                                          238, 79, 34, 0.65)),
                                ],
                                annotations: <GaugeAnnotation>[
                                  GaugeAnnotation(
                                      angle: 90,
                                      positionFactor: 0.35,
                                      widget: Container(
                                          child: const Text('IMC',
                                              style: TextStyle(
                                                  color: Color(0xFF000000),
                                                  fontSize: 16)))),
                                  GaugeAnnotation(
                                      angle: 90,
                                      positionFactor: 0.8,
                                      widget: Container(
                                        child: Text(
                                          '  ' +
                                              imc.imc
                                                  .toStringAsFixed(2)
                                                  .toString()
                                                  .replaceAll('.', ',') +
                                              '  ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ))
                                ],
                                pointers: <GaugePointer>[
                                  NeedlePointer(
                                    value: imc.imc,
                                    needleLength: 0.6,
                                    lengthUnit: GaugeSizeUnit.factor,
                                    needleStartWidth: 1,
                                    needleEndWidth: 8,
                                    animationType: AnimationType.easeOutBack,
                                    enableAnimation: true,
                                    animationDuration: 1200,
                                    knobStyle: KnobStyle(
                                        knobRadius: 0.09,
                                        sizeUnit: GaugeSizeUnit.factor,
                                        borderColor: imc.color,
                                        color: Colors.white,
                                        borderWidth: 0.05),
                                    tailStyle: TailStyle(
                                        color: imc.color,
                                        width: 8,
                                        lengthUnit: GaugeSizeUnit.factor,
                                        length: 0.2),
                                    needleColor: imc.color,
                                  )
                                ],
                                axisLabelStyle: GaugeTextStyle(fontSize: 12),
                                majorTickStyle: MajorTickStyle(
                                    length: 0.25,
                                    lengthUnit: GaugeSizeUnit.factor,
                                    thickness: 1.5),
                                minorTickStyle: MinorTickStyle(
                                    length: 0.13,
                                    lengthUnit: GaugeSizeUnit.factor,
                                    thickness: 1))
                          ],
                        ),
                        SizedBox(height: size.height * 0.02),
                        Wrap(
                          children: [
                            Text("Classificação: ",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800])),
                            Text(imc.classificacao,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: imc.color))
                          ],
                        ),
                        SizedBox(height: size.height * 0.01),
                        Wrap(
                          children: [
                            Text("Riscos Relacionados: ",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800])),
                            Text(imc.riscos,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: imc.color))
                          ],
                        ),
                      ],
                    );
                  }),

              SizedBox(height: size.height * 0.06),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                width: size.width,
                child: GestureDetector(
                    child: Text("Referência: UNIMED"),
                    onTap: () async {
                      const url =
                          "https://www.unimed.coop.br/web/vitoria/viver-bem/pais-e-filhos/estatura-por-idade";
                      await canLaunch(url)
                          ? await launch(url)
                          : throw 'Não foi possível abrir url nesse dispositivo';
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
