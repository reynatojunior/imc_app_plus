import 'package:flutter/material.dart';

void main() {
  runApp(CalcularIMC());
}

class CalcularIMC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora de IMCPLUS',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: IMCCalculator(),
    );
  }
}

class IMCCalculator extends StatefulWidget {
  @override
  _IMCCalculatorState createState() => _IMCCalculatorState();
}

class _IMCCalculatorState extends State<IMCCalculator> {
  List<IMCData> imcDataList = [];

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  void calculeIMC() {
    double peso = double.parse(weightController.text);
    double altura =
        double.parse(heightController.text) / 100; // altura de cm para metros

    double imc = peso / (altura * altura);

    IMCData imcData = IMCData(peso: peso, altura: altura, imc: imc);
    setState(() {
      imcDataList.add(imcData);
    });

    // Limpa os campos de texto após o cálculo
    weightController.clear();
    heightController.clear();
  }

  String getClassificacao(double imc) {
    if (imc < 16) {
      return 'Magreza grave';
    } else if (imc < 17 && imc > 16) {
      return 'Magreza moderada';
    } else if (imc < 18.5 && imc > 17) {
      return 'Magreza leve';
    } else if (imc < 25 && imc > 18.5) {
      return 'Saudável';
    } else if (imc < 30 && imc > 25) {
      return 'Sobrepeso';
    } else if (imc < 35 && imc > 30) {
      return 'Obesidade Grau I';
    } else if (imc < 40 && imc > 35) {
      return 'Obesidade Grau II';
    } else {
      return 'Obesidade Grau III';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMCPLUS'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Peso (kg)',
              ),
            ),
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Altura (cm)',
              ),
            ),
            ElevatedButton(
              onPressed: calculeIMC,
              child: Text('Calcular IMC'),
            ),
            SizedBox(height: 16),
            Text(
              'Histórico de IMC:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: imcDataList.length,
                itemBuilder: (context, index) {
                  IMCData imcData = imcDataList[index];
                  String classificacao = getClassificacao(imcData.imc);
                  return ListTile(
                    title: Text('IMC: ${imcData.imc.toStringAsFixed(2)}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Peso: ${imcData.peso} kg, Altura: ${imcData.altura} m'),
                        Text('Classificação: $classificacao'),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IMCData {
  final double peso;
  final double altura;
  final double imc;

  IMCData({required this.peso, required this.altura, required this.imc});
}
