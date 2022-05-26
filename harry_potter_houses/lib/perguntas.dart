// ignore_for_file: prefer_final_fields, unused_field

import 'package:flutter/cupertino.dart';

import 'sistema.dart';

class Perguntas {
  int _questionNumber = 0;

  List<Question> _questionData = [
    Question(
        questionTitle:
            'Olá futuro bruxo(a)! Vamos descobrir qual é a casa ideal para você em Hogwarts? E a primeira questão é: com quais dos substantivos você se identifica mais?',
        choice1: 'Coragem e gentileza',
        choice2: 'Ambição e inteligência'),
    Question(
        questionTitle:
            'Você prefere quebrar as regras e conquistar algo de forma rápida ou prefere utilizar a inteligência e estudar para então conquistar?',
        choice1: 'Prefiro quebrar as regras',
        choice2: 'Utilizo a inteligência e estudos'),
    Question(
        questionTitle: 'O que se encaixa melhor com o seu perfil?',
        choice1: 'Ousadia e astúcia',
        choice2: 'Paciência e sinceridade'),
    Question(
        questionTitle: 'Você ficará muito bem aos cuidados da SONSERINA',
        choice1: 'Refazer teste',
        choice2: ''),
    Question(
        questionTitle: 'Você ficará muito bem aos cuidados da LUFA-LUFA!',
        choice1: 'Refazer teste',
        choice2: ''),
    Question(
        questionTitle: 'Você ficará muito bem aos cuidados da GRIFINÓRIA!',
        choice1: 'Refazer teste',
        choice2: ''),
    Question(
        questionTitle: 'Você ficará muito bem aos cuidados da CORVINAL!',
        choice1: 'Refazer teste',
        choice2: '')
  ];

  String obterPergunta() {
    return _questionData[_questionNumber].questionTitle;
  }

  String obterresposta1(int opcao) {
    return _questionData[_questionNumber].choice1;
  }

  String obterresposta2(int opcao) {
    return _questionData[_questionNumber].choice2;
  }

  void nextQuestion(int userChoice) {
    if (userChoice == 1 && _questionNumber == 0) {
      _questionNumber = 2;
    } else if (userChoice == 2 && _questionNumber == 0) {
      _questionNumber = 1;
    } else if (userChoice == 1 && _questionNumber == 1) {
      _questionNumber = 3;
    } else if (userChoice == 2 && _questionNumber == 1) {
      _questionNumber = 6;
    } else if (userChoice == 1 && _questionNumber == 2) {
      _questionNumber = 5;
    } else if (userChoice == 2 && _questionNumber == 2) {
      _questionNumber = 4;
    } else if (_questionNumber == 3 ||
        _questionNumber == 4 ||
        _questionNumber == 5 ||
        _questionNumber == 6) {
      _questionNumber = 0;
    }
  }

  bool visible() {
    if (_questionNumber == 0 || _questionNumber == 1 || _questionNumber == 2) {
      return true;
    } else {
      return false;
    }
  }
}
