import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart'; // Import the HomeScreen

class DonationScreen extends StatefulWidget {
  const DonationScreen({Key? key}) : super(key: key);

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  final List<String> categories = [
    'Food',
    'Hygienic Products',
    'Clothes',
    'Books',
    'Bedding',
    'Money',
    'Toys',
    'Blood'
  ];
  final Map<String, bool> selectedCategories = {};
  String weight = '';
  String description = '';
  TimeOfDay? selectedTime;
  String? selectedPaymentMethod;
  final List<String> paymentMethods = ['None', 'Cash', 'Credit Card', 'PayPal'];
  String? cardNumber;
  String? cardHolderName;
  String? expiryDate;
  String? cvv;
  String? paypalEmail;
  String? paypalPassword;
  String? cashAmount;

  @override
  void initState() {
    super.initState();
    for (var category in categories) {
      selectedCategories[category] = false;
    }
  }

  void _submitForm() {
    // Validate input fields
    if (selectedCategories.values.every((value) => !value)) {
      _showErrorDialog("Please select at least one category.");
      return;
    }
    if (weight.isEmpty) {
      _showErrorDialog("Please enter the weight.");
      return;
    }
    if (description.isEmpty) {
      _showErrorDialog("Please enter a description.");
      return;
    }
    if (selectedTime == null) {
      _showErrorDialog("Please select an order time.");
      return;
    }
    if (selectedPaymentMethod == null) {
      _showErrorDialog("Please select a payment method.");
      return;
    }

    // Only validate payment details if a payment method other than 'None' is selected
    if (selectedPaymentMethod != 'None') {
      if (selectedPaymentMethod == 'Credit Card') {
        if (cardNumber == null || cardNumber!.length != 16) {
          _showErrorDialog("Please enter a valid card number.");
          return;
        }
        if (cardHolderName == null || cardHolderName!.isEmpty) {
          _showErrorDialog("Please enter the card holder name.");
          return;
        }
        if (expiryDate == null || expiryDate!.length != 5) {
          _showErrorDialog("Please enter a valid expiry date.");
          return;
        }
        if (cvv == null || cvv!.length != 3) {
          _showErrorDialog("Please enter a valid CVV.");
          return;
        }

        // Validate expiry date
        try {
          int month = int.parse(expiryDate!.split('/')[0]);
          int year = int.parse(expiryDate!.split('/')[1]);
          int currentYear = DateTime.now().year % 100;
          int currentMonth = DateTime.now().month;

          // Convert to full year for comparison
          year += 2000;
          
          if (year < DateTime.now().year || 
              (year == DateTime.now().year && month < currentMonth)) {
            _showErrorDialog("Card has expired.");
            return;
          }
        } catch (e) {
          _showErrorDialog("Please enter a valid expiry date.");
          return;
        }
      } else if (selectedPaymentMethod == 'PayPal') {
        if (paypalEmail == null || paypalEmail!.isEmpty || !paypalEmail!.contains('@')) {
          _showErrorDialog("Please enter a valid PayPal email.");
          return;
        }
        if (paypalPassword == null || paypalPassword!.isEmpty) {
          _showErrorDialog("Please enter your PayPal password.");
          return;
        }
      }
    }

    // Add validation for cash amount
    if (selectedPaymentMethod == 'Cash' && (cashAmount == null || cashAmount!.isEmpty)) {
      _showErrorDialog("Please enter the cash amount.");
      return;
    }

    // If all fields are valid, print the form data
    print('Selected Categories: ${selectedCategories.entries.where((entry) => entry.value).map((entry) => entry.key).toList()}');
    print('Weight: $weight');
    print('Description: $description');
    print('Order Time: ${selectedTime?.format(context)}');
    print('Payment Method: $selectedPaymentMethod');

    // Add cash amount to the printed form data
    if (selectedPaymentMethod == 'Cash') {
      print('Cash Amount: $cashAmount EGP');
    }

    // Navigate back to HomeScreen after successful submission
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showCategoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Select Categories"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: categories.map((category) {
                    return CheckboxListTile(
                      title: Text(category),
                      value: selectedCategories[category],
                      onChanged: (bool? value) {
                        setState(() {
                          selectedCategories[category] = value!;
                        });
                        this.setState(() {});
                      },
                      activeColor: Theme.of(context).colorScheme.primary,
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  child: const Text("Done"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildCreditCardFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            labelText: "Card Number",
            labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(16),
          ],
          onChanged: (value) {
            cardNumber = value;
          },
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            labelText: "Card Holder Name",
            labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')), // Allows only letters and spaces
          ],
          onChanged: (value) {
            cardHolderName = value;
          },
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Expiry Date (MM/YY)",
                  labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                  _ExpiryDateInputFormatter(),
                ],
                onChanged: (value) {
                  expiryDate = value;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: "CVV",
                  labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
                onChanged: (value) {
                  cvv = value;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPayPalFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            labelText: "PayPal Email",
            labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            paypalEmail = value;
          },
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            labelText: "PayPal Password",
            labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          obscureText: true, // Hides the password
          onChanged: (value) {
            paypalPassword = value;
          },
        ),
      ],
    );
  }

  Widget _buildCashField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            labelText: "Cash Amount (EGP)",
            labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: (value) {
            setState(() {
              cashAmount = value;
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donation Form"),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select Categories:", style: TextStyle(fontSize: 18)),
            TextButton(
              onPressed: _showCategoryDialog,
              child: Text(
                'Choose Categories',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              children: selectedCategories.entries
                  .where((entry) => entry.value)
                  .map((entry) => Chip(
                        label: Text(entry.key),
                        deleteIcon: const Icon(Icons.close),
                        onDeleted: () {
                          setState(() {
                            selectedCategories[entry.key] = false;
                          });
                        },
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: "Weight (kg)",
                labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) {
                weight = value;
              },
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: "Description",
                labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                ),
              ),
              maxLines: 3,
              onChanged: (value) {
                description = value;
              },
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () async {
                final TimeOfDay? time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (time != null) {
                  setState(() {
                    selectedTime = time;
                  });
                }
              },
              child: Text(
                selectedTime == null
                    ? 'Select Order Time'
                    : 'Selected Time: ${selectedTime!.format(context)}',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              hint: const Text("Select Payment Method"),
              value: selectedPaymentMethod,
              onChanged: (String? newValue) {
                setState(() {
                  selectedPaymentMethod = newValue;
                });
              },
              items: paymentMethods.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            // Add appropriate fields based on payment method
            if (selectedPaymentMethod == 'Cash') _buildCashField(),
            if (selectedPaymentMethod == 'Credit Card') _buildCreditCardFields(),
            if (selectedPaymentMethod == 'PayPal') _buildPayPalFields(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: const Text("Submit Donation"),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom formatter for expiry date (MM/YY format)
class _ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var newText = newValue.text;

    if (newText.length > 5) {
      return oldValue;
    }

    // Handle backspace
    if (oldValue.text.length > newText.length) {
      return newValue;
    }

    // Format MM/YY
    if (newText.length >= 2) {
      // Validate month
      int? month = int.tryParse(newText.substring(0, 2));
      if (month != null) {
        if (month > 12) {
          return oldValue;
        }
        if (month == 0) {
          return oldValue;
        }
      }

      if (newText.length == 2) {
        newText = '$newText/';
      } else if (newText.length > 2 && !newText.contains('/')) {
        newText = '${newText.substring(0, 2)}/${newText.substring(2)}';
      }
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
} 
