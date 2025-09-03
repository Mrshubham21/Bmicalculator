import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1E1E2C),
      ),
      home: const BmiDashboard(),
    );
  }
}

class BmiDashboard extends StatefulWidget {
  const BmiDashboard({super.key});

  @override
  State<BmiDashboard> createState() => _BmiDashboardState();
}

class _BmiDashboardState extends State<BmiDashboard> {
  String _selectedGender = "Male";
  double _height = 160;
  double _weight = 70;

  double get _bmi => _weight / ((_height / 100) * (_height / 100));

  String _bmiCategory() {
    if (_bmi < 18.5) return "Underweight";
    if (_bmi < 24.9) return "Normal";
    if (_bmi < 29.9) return "Overweight";
    return "Obese";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // 🔹 Sidebar
          Container(
            width: 80,
            color: const Color(0xFF121221),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.home, color: Colors.greenAccent),
                SizedBox(height: 20),
                Icon(Icons.person, color: Colors.white54),
                SizedBox(height: 20),
                Icon(Icons.fitness_center, color: Colors.white54),
              ],
            ),
          ),

          // 🔹 Main BMI Section
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(24),
              color: const Color(0xFF29293D),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("BMI Calculator",
                        style: TextStyle(
                            fontSize: 28,
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),

                    // Gender Selection
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => _selectedGender = "Male"),
                            child: _buildSelectableCard(
                              "MALE",
                              const Icon(Icons.male,
                                  size: 40, color: Colors.white),
                              _selectedGender == "Male",
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => _selectedGender = "Female"),
                            child: _buildSelectableCard(
                              "FEMALE",
                              const Icon(Icons.female,
                                  size: 40, color: Colors.white),
                              _selectedGender == "Female",
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Height card
                    _buildCard(
                      "HEIGHT",
                      Column(
                        children: [
                          Text("${_height.toInt()} cm",
                              style: const TextStyle(fontSize: 20)),
                          Slider(
                            min: 140,
                            max: 200,
                            divisions: 60,
                            value: _height,
                            label: _height.toStringAsFixed(0),
                            onChanged: (val) =>
                                setState(() => _height = val),
                            activeColor: Colors.greenAccent,
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: "Enter Height (cm)",
                              labelStyle: TextStyle(color: Colors.white70),
                            ),
                            style: const TextStyle(color: Colors.white),
                            onChanged: (val) {
                              final h = double.tryParse(val);
                              if (h != null) {
                                setState(() => _height = h);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Weight card
                    _buildCard(
                      "WEIGHT",
                      Column(
                        children: [
                          Text("${_weight.toInt()} kg",
                              style: const TextStyle(fontSize: 20)),
                          Slider(
                            min: 40,
                            max: 150,
                            divisions: 110,
                            value: _weight,
                            label: _weight.toStringAsFixed(0),
                            onChanged: (val) =>
                                setState(() => _weight = val),
                            activeColor: Colors.greenAccent,
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: "Enter Weight (kg)",
                              labelStyle: TextStyle(color: Colors.white70),
                            ),
                            style: const TextStyle(color: Colors.white),
                            onChanged: (val) {
                              final w = double.tryParse(val);
                              if (w != null) {
                                setState(() => _weight = w);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // BMI Result
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text("BMI = ${_bmi.toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          const SizedBox(height: 10),
                          Text(_bmiCategory(),
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black87)),
                          const SizedBox(height: 8),
                          Text("Gender: $_selectedGender",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black54)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 🔹 Analytics Panel
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              color: const Color(0xFF1E1E2C),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Today's Analytics",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  const SizedBox(height: 16),
                  _buildStat("Breakfast", "Total Fat", "94.3 Kcal",
                      Icons.breakfast_dining, Colors.greenAccent),
                  _buildStat("Lunch", "Avg Carbs", "132.2 Kcal",
                      Icons.lunch_dining, Colors.purpleAccent),
                  _buildStat("Dinner", "Avg Protein", "89.3 Kcal",
                      Icons.dinner_dining, Colors.orangeAccent),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Helper Widgets
  Widget _buildCard(String title, Widget child) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2C),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(title,
              style: const TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _buildSelectableCard(String title, Widget icon, bool selected) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: selected ? Colors.greenAccent : const Color(0xFF1E1E2C),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: selected ? Colors.greenAccent : Colors.transparent,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          icon,
          const SizedBox(height: 10),
          Text(title,
              style: TextStyle(
                  fontSize: 16,
                  color: selected ? Colors.black : Colors.white70,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildStat(
      String title, String subtitle, String value, IconData icon, Color color) {
    return Card(
      color: const Color(0xFF29293D),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: color, size: 32),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        subtitle:
            Text(subtitle, style: const TextStyle(color: Colors.white54)),
        trailing: Text(value,
            style: TextStyle(color: color, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
