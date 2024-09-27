//import 'dart:js';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class Requests {
  final String title;
  final String date;
  final String description;
  final String quantity;
  final String unitOfMeasurement;
  final String deliveryPlace;
  final String deliveryDate;
  final String document;

  Requests({
    required this.title,
    required this.date,
    required this.description,
    required this.quantity,
    required this.unitOfMeasurement,
    required this.deliveryPlace,
    required this.deliveryDate,
    required this.document,
  });
}

final TextEditingController requestTitle = TextEditingController();
final TextEditingController requestDescrip = TextEditingController();
final TextEditingController quantity = TextEditingController();
final TextEditingController unitOfMeasurement = TextEditingController();
final TextEditingController deliveryPlace = TextEditingController();
final TextEditingController deliveryDate = TextEditingController();
final TextEditingController document = TextEditingController();

//Lists
final List<Requests> requests = [
  Requests(
    title: "New Request",
    description: "newRequest",
    date: DateTime.now().toString(),
    quantity: "20",
    unitOfMeasurement: "cm",
    deliveryPlace: "mdmsa",
    deliveryDate: "20th",
    document: "mamsm",
  ),
  Requests(
    title: "Another Request",
    description: "secondRequest",
    date: DateTime.now().toString(),
    quantity: "15",
    unitOfMeasurement: "kg",
    deliveryPlace: "accra",
    deliveryDate: "25th",
    document: "document.pdf",
  ),
];
List<Requests> approvedRequests = [];
List<Requests> declinedRequests = [];

//popups
void popCreateDialog(BuildContext context, action) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Create Request',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              _buildTextField("Request Title", requestTitle),
              const SizedBox(height: 16),
              _buildTextField("Request Description", requestDescrip),
              const SizedBox(height: 16),
              _buildTextField("Quantity", quantity),
              const SizedBox(height: 16),
              _buildTextField("Unit of Measurement", unitOfMeasurement),
              const SizedBox(height: 16),
              _buildTextField("Delivery Place", deliveryPlace),
              const SizedBox(height: 16),
              _buildDatePicker("Delivery Date", deliveryDate,
                  context), // Using Date Picker here
              const SizedBox(height: 16),
              TextButton.icon(
                  onPressed: _pickDocument,
                  icon: const Icon(
                    Icons.attach_file_sharp,
                    color: Colors.red,
                  ),
                  label: const Text(
                    "Attach Document",
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: const StadiumBorder(),
              padding: const EdgeInsets.all(16),
            ),
            onPressed: action,
            child: const Text(
              'Submit',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    },
  );
}

Widget _buildTextField(String hintText, TextEditingController controller) {
  return TextField(
    controller: controller,
    cursorColor: Colors.red,
    decoration: InputDecoration(
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      hintText: hintText,
      fillColor: Colors.red.withOpacity(0.1),
      filled: true,
    ),
  );
}

void _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );
  if (picked != null && picked != DateTime.now()) {
    deliveryDate.text = picked.toString();
  }
}

void _pickDocument() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  if (result != null) {
    document.text = result.files.single.name;
  }
}

_buildDatePicker(
    String hintText, TextEditingController controller, BuildContext context) {
  return GestureDetector(
    onTap: () => _selectDate(context),
    child: AbsorbPointer(
      child: TextField(
        controller: controller,
        cursorColor: Colors.red,
        decoration: InputDecoration(
          icon: const Icon(Icons.date_range_outlined),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          hintText: hintText,
          fillColor: Colors.redAccent.withOpacity(0.1),
          filled: true,
        ),
      ),
    ),
  );
}

void popAdminDetails(context, requestList, index, approve, decline) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Request Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                detailRow("Title:", requestList[index].title),
                detailRow("Description:", requestList[index].description),
                detailRow("Date:", requestList[index].date),
                detailRow("Quantity:", requestList[index].quantity),
                detailRow("Unit of Measurement:",
                    requestList[index].unitOfMeasurement),
                detailRow("Delivery Place:", requestList[index].deliveryPlace),
                detailRow("Delivery Date:", requestList[index].deliveryDate),
                detailRow("Document:", requestList[index].document),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: decline,
            child: const Text(
              'Decline',
              style: TextStyle(color: Colors.red),
            ),
          ),
          ElevatedButton(
            onPressed: approve,
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              backgroundColor: Colors.green[500],
            ),
            child: const Text("Approve"),
          ),
        ],
      );
    },
  );
}

void popDetails(BuildContext context, requestList, int index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Request Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                detailRow("Title:", requestList[index].title),
                detailRow("Description:", requestList[index].description),
                detailRow("Date:", requestList[index].date),
                detailRow("Quantity:", requestList[index].quantity),
                detailRow("Unit of Measurement:",
                    requestList[index].unitOfMeasurement),
                detailRow("Delivery Place:", requestList[index].deliveryPlace),
                detailRow("Delivery Date:", requestList[index].deliveryDate),
                detailRow("Document:", requestList[index].document),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            child: const Text(
              'Close',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Widget detailRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    ),
  );
}

//Request Widgets
Widget buildRequestCard(BuildContext context, requestList, index) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    child: ListTile(
      title: Text(requestList[index].title),
      subtitle: Text(requestList[index].description),
      trailing: Text(requestList[index].date),
      onTap: () {
        popDetails(context, requestList, index);
      },
    ),
  );
}

Widget buildPendingCard(BuildContext context, requestList, index) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    child: ListTile(
      title: Text(requestList[index].title),
      subtitle: Text(requestList[index].description),
      trailing: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: Colors.green,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Submitted",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      onTap: () {
        popDetails(context, requestList, index);
      },
    ),
  );
}

Widget buildAdminPendingCard(
    BuildContext context, requestList, index, approve, decline) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    child: ListTile(
      title: Text(requestList[index].title),
      subtitle: Text(requestList[index].description),
      trailing: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: Colors.white30,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Pending",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      onTap: () {
        popAdminDetails(context, requestList, index, approve, decline);
      },
    ),
  );
}

Widget buildApprovedRequestCard(BuildContext context, requestList, index) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    child: ListTile(
      title: Text(requestList[index].title),
      subtitle: Text(requestList[index].description),
      trailing: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: Colors.green[500],
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Approved",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      onTap: () {
        popDetails(context, requestList, index);
      },
    ),
  );
}

Widget buildDeclinedRequestCard(BuildContext context, requestList, index) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    child: ListTile(
      title: Text(requestList[index].title),
      subtitle: Text(requestList[index].description),
      trailing: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: Colors.red[500],
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Declined",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      onTap: () {
        popDetails(context, requestList, index);
      },
    ),
  );
}
