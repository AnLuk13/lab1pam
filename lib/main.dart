import 'package:flutter/material.dart';
import 'dart:math'; // Import the dart:math library

void main() {
  runApp(LoanCalculator());
}

class LoanCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoanCalculatorHome(),
    );
  }
}

class LoanCalculatorHome extends StatefulWidget {
  @override
  _LoanCalculatorHomeState createState() => _LoanCalculatorHomeState();
}

class _LoanCalculatorHomeState extends State<LoanCalculatorHome> {
  double amount = 0;
  int months = 1;
  double interestRate = 0;
  double monthlyPayment = 0;

  void calculatePayment() {
    setState(() {
      if (amount > 0 && months > 1 && interestRate > 0) {
        double monthlyRate = interestRate / 100;
        monthlyPayment = (amount * monthlyRate) /
            (1 - pow(1 + monthlyRate, -months)); // Use pow from dart:math
      }
      //  else {
      //   monthlyPayment = amount / months;
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Center(
              child: Text(
                "Loan calculator",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Enter amount",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              onChanged: (value) {
                amount = double.tryParse(value) ?? 0;
                calculatePayment();
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFF5F5F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                hintText: "Amount",
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Enter number of months",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Slider(
              onChangeEnd: (value) {
                calculatePayment();
              },
              value: months.toDouble(),
              min: 1,
              max: 60,
              divisions: 59,
              label: "$months months",
              onChanged: (value) {
                setState(() {
                  months = value.toInt();
                });
              },
              activeColor: Color(0xFF3A6FFF),
            ),
            SizedBox(height: 30),
            Text(
              "Enter % per month",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              onChanged: (value) {
                interestRate = double.tryParse(value) ?? 0;
                calculatePayment();
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFF5F5F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                hintText: "Percent",
              ),
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    "You will pay the approximate amount monthly:",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: 10), // Adds vertical padding to the Container
                child: Text(
                  "${monthlyPayment.toStringAsFixed(2)}€", // Displays the monthly payment
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3A6FFF),
                  ),
                ),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: calculatePayment,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Color(0xFF3A6FFF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Calculate",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
