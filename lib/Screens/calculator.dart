import 'package:flutter/material.dart';

class CalorieCalculator extends StatefulWidget {
  const CalorieCalculator({super.key});

  @override
  State<CalorieCalculator> createState() => _CalorieCalculatorState();
}

class _CalorieCalculatorState extends State<CalorieCalculator> {
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final ageController = TextEditingController();
  String gender = 'Male';
  String activity = 'Light exercise';
  double? result;

  double calculateCalories() {
    double w = double.tryParse(weightController.text) ?? 0;
    double h = double.tryParse(heightController.text) ?? 0;
    double a = double.tryParse(ageController.text) ?? 0;

    double bmr;
    if (gender == 'Male') {
      bmr = 88.36 + (13.4 * w) + (4.8 * h) - (5.7 * a);
    } else {
      bmr = 447.6 + (9.2 * w) + (3.1 * h) - (4.3 * a);
    }

    double multiplier;
    switch (activity) {
      case 'No exercise':
        multiplier = 1.2;
        break;
      case 'Light exercise':
        multiplier = 1.375;
        break;
      case 'Moderate exercise':
        multiplier = 1.55;
        break;
      case 'Hard exercise':
        multiplier = 1.725;
        break;
      default:
        multiplier = 1.2;
    }

    return bmr * multiplier;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'حاسبة السعرات الحرارية',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    style: TextStyle(color: Colors.white),

                    value: gender,
                    decoration: const InputDecoration(labelText: 'الجنس'),
                    items: ['Male', 'Female']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (val) => setState(() => gender = val!),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    style: TextStyle(color: Colors.white),

                    value: activity,
                    decoration: const InputDecoration(
                      labelText: 'مستوى النشاط',
                    ),
                    items:
                        [
                              'No exercise',
                              'Light exercise',
                              'Moderate exercise',
                              'Hard exercise',
                            ]
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                    onChanged: (val) => setState(() => activity = val!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: weightController,
              decoration: const InputDecoration(labelText: 'الوزن (كغ)'),
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white),
            ),
            TextField(
              controller: heightController,
              decoration: const InputDecoration(labelText: 'الطول (سم)'),
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white),
            ),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: 'العمر'),
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  result = calculateCalories();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade700,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
              child: const Text(
                'احسب السعرات ',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 30),
            if (result != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  ' سعراتك اليومية التقريبية للمحافظه على وزنك:${result!.toStringAsFixed(0)} سعرة حرارية ',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
