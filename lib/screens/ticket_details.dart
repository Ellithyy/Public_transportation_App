import 'package:flutter/material.dart';
import 'package:public_tranport_app/constants.dart';
import 'package:public_tranport_app/widgets/ticket_info.dart';

class TicketDetails extends StatefulWidget {
  final TicketInfo ticketInfo;

  const TicketDetails({Key? key, required this.ticketInfo}) : super(key: key);

  @override
  _TicketDetailsState createState() => _TicketDetailsState();
}

class _TicketDetailsState extends State<TicketDetails> {
  final TextEditingController _amountController = TextEditingController();
  String _selectedPaymentMethod = 'Credit Card';
  double creditBalance = 85.0;
  double walletBalance = 18.0;

  void _togglePaymentMethod(String method) {
    setState(() {
      _selectedPaymentMethod = method;
    });
  }

  void _buyTicket() {
    double amount = double.tryParse(_amountController.text) ?? 0.0;
    if (amount <= 0) {
      _showSnackbar("Enter a valid amount.");
      return;
    }

    if (_selectedPaymentMethod == 'Credit Card' && amount > creditBalance) {
      _showSnackbar("Insufficient credit card balance.");
      return;
    }

    if (_selectedPaymentMethod == 'E-Wallet' && amount > walletBalance) {
      _showSnackbar("Insufficient e-wallet balance.");
      return;
    }

    setState(() {
      if (_selectedPaymentMethod == 'Credit Card') {
        creditBalance -= amount;
      } else {
        walletBalance -= amount;
      }
    });

    _showSnackbar("Ticket purchased successfully!");
    _amountController.clear();
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.black54,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kMoonStones,
      appBar: AppBar(
        backgroundColor: kMoonStones,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Ticket Details',
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 100,
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 28, vertical: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 120),
                        Text(
                          'Payment',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        SizedBox(height: 10),
                        Text('Enter Amount', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                        SizedBox(height: 12),
                        TextField(
                          controller: _amountController,
                          style: TextStyle(fontSize: 16),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixText: '\$ ',
                            filled: true,
                            fillColor: kGray.withOpacity(0.2),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                          ),
                        ),
                        SizedBox(height: 20),
                        _paymentOption('Credit Card', creditBalance),
                        SizedBox(height: 15),
                        Divider(color: kDarkGray, thickness: 1),
                        SizedBox(height: 15),
                        _paymentOption('E-Wallet', walletBalance),
                        SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: _buyTicket,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kMoonStones,
                              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            ),
                            child: Text(
                              'Buy Ticket',
                              style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  child: widget.ticketInfo,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentOption(String method, double balance) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _paymentMethodButton(method, _selectedPaymentMethod == method),
        Text('Balance: \$${balance.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _paymentMethodButton(String method, bool isSelected) {
    return GestureDetector(
      onTap: () => _togglePaymentMethod(method),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        alignment: Alignment.center,
        width: 145,
        height: 45,
        decoration: BoxDecoration(
          color: isSelected ? kMoonStones : kGray,
          borderRadius: BorderRadius.circular(15),
          border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
        ),
        child: Text(
          method,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
