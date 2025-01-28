import 'package:account/provider/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'formScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return TransactionProvider();
          },
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Account'),
      ),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                // การนำทางไปยัง FormScreen
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const FormScreen(); // เปิดหน้าจอ FormScreen
                }));
              },
            ),
          ],
        ),
        body: Consumer(builder:
            (context, TransactionProvider transactionProvider, Widget? child) {
          return ListView.builder(
            itemCount: transactionProvider.transactions.length,
            itemBuilder: (context, int index) {
              return Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  title: Text(
                      'รายการที่ ${index + 1} - ${transactionProvider.transactions[index].title}'),
                  subtitle: Text('วันที่บันทึก - ${transactionProvider.transactions[index].date}'),
                  leading: CircleAvatar(
                    child: FittedBox(
                      child: Text(transactionProvider.transactions[index].amount
                          .toString()),
                    ),
                  ),
                ),
              );
            },
          );
        }));
  }
}