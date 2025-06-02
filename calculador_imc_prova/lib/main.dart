import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Calculadora de IMC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();

  double peso = 0;
  double altura = 0;
  double resultado = 0;
  String imcResultado = "";

  void calcularIMC() {
    setState(() {
      String pesoTexto = pesoController.text.replaceAll(",", ".");
      String alturaTexto = alturaController.text.replaceAll(",", ".");

      peso = double.tryParse(pesoTexto) ?? 0;
      altura = double.tryParse(alturaTexto) ?? 0;

      if (altura > 3) {
        altura = altura / 100;
      }

      if (peso > 0 && altura > 0) {
        resultado = peso / (altura * altura);

        if (resultado < 18.5) {
          imcResultado = "Abaixo do peso";
        } else if (resultado < 24.9) {
          imcResultado = "Peso normal";
        } else if (resultado < 29.9) {
          imcResultado = "Sobrepeso";
        } else {
          imcResultado = "Obesidade";
        }
      } else {
        resultado = 0;
        imcResultado = "Informe valores válidos!";
      }
    });
  }

  void deleteAll() {
    setState(() {
      pesoController.clear();
      alturaController.clear();
      peso = 0;
      altura = 0;
      resultado = 0;
      imcResultado = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora IMC"),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: deleteAll),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 30),
              const Icon(Icons.person, size: 120, color: Colors.lightGreen),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: pesoController,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: "Peso (Kg)",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: alturaController,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: "Altura (cm ou m)",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: calcularIMC,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: const Text("Calcular"),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      "IMC: ${resultado.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      imcResultado,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
