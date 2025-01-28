import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final FocusNode _nameFocusNode = FocusNode(); // โฟกัสสำหรับช่องชื่อรายการ
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  final List<Map<String, dynamic>> _items = []; // รายการเก็บข้อมูล

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_nameFocusNode);
    });
  }

  void _addItem() {
    // ตรวจสอบว่าช่องป้อนข้อมูลไม่ว่าง
    if (_nameController.text.isNotEmpty && _amountController.text.isNotEmpty) {
      setState(() {
        _items.add({
          'name': _nameController.text,
          'amount': double.tryParse(_amountController.text) ?? 0.0,
        });
      });
      // ล้างข้อมูลใน TextField
      _nameController.clear();
      _amountController.clear();
      // โฟกัสกลับไปที่ช่องชื่อ
      FocusScope.of(context).requestFocus(_nameFocusNode);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('กรุณากรอกข้อมูลให้ครบถ้วน')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Input Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              focusNode: _nameFocusNode,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                label: Text('ชื่อรายการ'),
                hintText: 'กรุณาใส่ชื่อรายการ',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                label: Text('จำนวนเงิน'),
                hintText: 'กรุณาใส่จำนวนเงิน',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addItem,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: const Text('เพิ่มข้อมูล'),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return Card(
                    child: ListTile(
                      title: Text(item['name']),
                      subtitle: Text('จำนวนเงิน: ${item['amount']} บาท'),
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

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}