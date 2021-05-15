import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:calculadora/app/models/IMC.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BlocBase {  

  final _imcController = BehaviorSubject<IMC>();
  Stream<IMC> get outIMC => _imcController.stream;

  Future<void> calcularIMC(int idade, double peso, double altura) async {
    altura = altura / 100;
    double calculoIMC  = peso / (altura * altura);

    IMC imc = IMC(calculoIMC);
    _imcController.add(imc);
  }

  Future<void> clear() async {
    _imcController.add(null);
  }

  @override
  void dispose() {
    super.dispose();
    _imcController.close();
  }
}
