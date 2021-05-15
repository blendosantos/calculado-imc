import 'package:flutter/rendering.dart';

class IMC {

  IMC(this.imc) {
    if (this.imc <= 18.5) {
      this.classificacao = "Déficit de massa corporal";
      this.riscos = "Baixo (com riscos de outras doenças)";
      this.color = const Color.fromRGBO(34, 144, 199, 0.75);
    } else if (this.imc >= 18.5 && this.imc <= 24.99) {
      this.classificacao = "Massa corporal normal";
      this.riscos = "Normal";
      this.color = const Color.fromRGBO(123, 199, 34, 0.75);
    } else if (this.imc >= 25 && this.imc <= 29.99) {
      this.classificacao = "Sobrepeso";
      this.riscos = "Elevado";
      this.color = const Color.fromRGBO(238, 193, 34, 0.75);
    } else if (this.imc >= 30 && this.imc <= 34.99) {
      this.classificacao = "Obesidade leve";
      this.riscos = "Alto";
      this.color = const Color.fromRGBO(249, 177, 48, 0.75);
    } else if (this.imc >= 35 && this.imc <= 39.99) {
      this.classificacao = "Obesidade média";
      this.riscos = "Muito Alto";
      this.color = const Color.fromRGBO(248, 138, 58, 0.65);
    } else if (this.imc >= 40) {
      this.classificacao = "Obesidade mórbida";
      this.riscos = "Iminente";
      this.color = const Color.fromRGBO(238, 79, 34, 0.65);
    }
  }

  double imc;
  Color color;
  String classificacao;
  String riscos;

}