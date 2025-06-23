import 'package:flutter/material.dart';

class StartMilkCollectingPage extends StatefulWidget {
  const StartMilkCollectingPage({super.key});

  @override
  State<StartMilkCollectingPage> createState() => _StartMilkCollectingPageState();
}

class _StartMilkCollectingPageState extends State<StartMilkCollectingPage> {
  bool isCollecting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Milk Collecting'),
        centerTitle: true,
        backgroundColor: Color(0xFF35F9D1), // Added green background panel
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF35F9D1), Color(0x5F99EFDD), Colors.white],
            stops: [0.1, 0.3, 0.3],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isCollecting ? 'Collecting Milk...' : 'Ready to Collect Milk',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isCollecting = !isCollecting;
                  });
                  // Add your collection logic here
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 60),
                  backgroundColor: isCollecting ? Colors.red : Colors.green,
                ),
                child: Text(
                  isCollecting
                      ? 'STOP Collecting Milk'
                      : 'START Collecting Milk',
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              if (isCollecting)
                const Column(
                  children: [
                    SizedBox(height: 30),
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text(
                      'Milk collection in progress...',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}



















// this IS an main.dart file to used to running and testing the milk collection code


// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Milk Collection App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: const HomeScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             // Add navigation back functionality if needed
//             Navigator.of(context).pop();
//           },
//         ),
//         title: const Text(
//           'Milk Collection',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.green, // Green background panel
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const MilkCollectingScreen(),
//               ),
//             );
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.green,
//             padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//           ),
//           child: const Text(
//             'Go to Milk Collection',
//             style: TextStyle(fontSize: 18),
//           ),
//         ),
//       ),
//     );
//   }
// }
