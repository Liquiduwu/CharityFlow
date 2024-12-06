import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'admin_feedback_screen.dart';

class AdminAnalyticsScreen extends StatelessWidget {
  const AdminAnalyticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Analytics Dashboard",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, "Most Active Charity Organizations"),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 100,
                  barGroups: [
                    BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 75)]),
                    BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 85)]),
                    BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 60)]),
                    BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 95)]),
                  ],
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const titles = ['Resala', 'Bank El-Ta3am', 'Masr El-Kheir', 'Others'];
                          return Text(titles[value.toInt()], style: const TextStyle(fontSize: 10));
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            _buildSectionTitle(context, "Most Donated Categories"),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: 35,
                      title: 'Food\n35%',
                      color: Colors.blue,
                      radius: 50,
                    ),
                    PieChartSectionData(
                      value: 25,
                      title: 'Clothes\n25%',
                      color: Colors.green,
                      radius: 50,
                    ),
                    PieChartSectionData(
                      value: 20,
                      title: 'Medical\n20%',
                      color: Colors.red,
                      radius: 50,
                    ),
                    PieChartSectionData(
                      value: 20,
                      title: 'Others\n20%',
                      color: Colors.orange,
                      radius: 50,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            _buildSectionTitle(context, "Top Donors"),
            _buildDonorList(),
            const SizedBox(height: 32),
            _buildSectionTitle(context, "Donation Success Rate"),
            _buildSuccessRateIndicator(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildDonorList() {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          _buildDonorListItem("Ahmed Mohamed", "50 donations"),
          _buildDonorListItem("Sara Ahmed", "45 donations"),
          _buildDonorListItem("Mohamed Ali", "42 donations"),
        ],
      ),
    );
  }

  Widget _buildDonorListItem(String name, String donations) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(name),
      subtitle: Text(donations),
    );
  }

  Widget _buildSuccessRateIndicator(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Success Rate",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "95%",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: 0.95,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
              minHeight: 10,
            ),
          ],
        ),
      ),
    );
  }
} 