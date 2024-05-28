import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'BttmNavigationBar.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double? _currentBalance = 0.0;
  double? _income = 0.0;
  double? _expenses = 0.0;
  final TextEditingController _expenseController = TextEditingController();
  String _selectedCategory = 'Rent';

  final List<Map<String, dynamic>> _dataSource = [
    {'category': 'Rent', 'value': 1000.0},
    {'category': 'Groceries', 'value': 2000.0},
    {'category': 'Transportation', 'value': 500.0},
  ];

  final List<String> _categories = ['Rent', 'Groceries', 'Transportation', 'Other'];

  late List<DoughnutSeries<Map<String, dynamic>, String>> _series;

  @override
  void initState() {
    super.initState();
    _income = 5000.0;
    _expenses = _dataSource.map((e) => e['value'] as double).reduce((a, b) => a + b);
    _currentBalance = _income! - _expenses!;

    _updateSeries();
  }

  void _updateSeries() {
    _series = [
      DoughnutSeries<Map<String, dynamic>, String>(
        dataSource: _dataSource,
        xValueMapper: (Map<String, dynamic> data, _) => data['category'] as String,
        yValueMapper: (Map<String, dynamic> data, _) => data['value'] as double,
        radius: '100%',
        startAngle: 0,
        endAngle: 360,
        innerRadius: '50%',
        dataLabelSettings: DataLabelSettings(
          isVisible: true,
          labelPosition: ChartDataLabelPosition.outside,
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ];
  }

  void _addExpense() {
    final double? value = double.tryParse(_expenseController.text);
    if (value != null) {
      setState(() {
        bool categoryExists = false;
        for (var item in _dataSource) {
          if (item['category'] == _selectedCategory) {
            item['value'] += value;
            categoryExists = true;
            break;
          }
        }
        if (!categoryExists) {
          _dataSource.add({'category': _selectedCategory, 'value': value});
        }
        _expenses = _dataSource.map((e) => e['value'] as double).reduce((a, b) => a + b);
        _currentBalance = _income! - _expenses!;
        _updateSeries();
      });
    }
  }

  List<BttmNavigationBarModel> BttmNavigationBarItems = [
    BttmNavigationBarModel(icon: Icons.monetization_on, label: "Ekran Główny"),
    BttmNavigationBarModel(icon: Icons.account_circle, label: "Konto"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      bottomNavigationBar: BottomNavigationBar(
        items: BttmNavigationBarItems.map((BttmNavigationBarModel item) {
          return BottomNavigationBarItem(
            icon: Icon(item.icon),
            label: item.label,
          );
        }).toList(),
        backgroundColor: Color(0xffffffff),
        currentIndex: 0,
        elevation: 8,
        iconSize: 24,
        selectedItemColor: Color(0xff49c4ad),
        unselectedItemColor: Color(0xff9e9e9e),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (value) {},
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              alignment: Alignment.topLeft,
              children: [
                Container(
                  margin: EdgeInsets.all(0),
                  padding: EdgeInsets.all(0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    color: Color(0xff49c4ad),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.zero,
                    border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                        width: 200,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Color(0x00000000),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "WYKAZ WYDATKÓW",
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              fontSize: 24,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(0),
                        width: 200,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Color(0x00000000),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(0),
                        height: 200,
                        child: SfCircularChart(
                          series: _series,
                          tooltipBehavior: TooltipBehavior(enable: true),
                          legend: Legend(
                            isVisible: true,
                            position: LegendPosition.bottom,
                            overflowMode: LegendItemOverflowMode.wrap,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Wybierz kategorię',
                    ),
                    value: _selectedCategory,
                    items: _categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCategory = newValue!;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _expenseController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Wprowadź nowy wydatek (zł)',
                    ),
                    keyboardType: TextInputType.number,
                    onSubmitted: (value) {
                      _addExpense();
                      _expenseController.clear();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
