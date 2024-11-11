import 'package:flutter/material.dart';
import 'package:app_rider/services/socket.dart';

class SocketTestPage extends StatefulWidget {
  const SocketTestPage({super.key});

  @override
  State<SocketTestPage> createState() => _SocketTestPageState();
}

class _SocketTestPageState extends State<SocketTestPage> {
  SocketService ride = SocketService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('yo'),
          ],
        ),
      ),
      body: Column(
        children: [
          Text('socket test'),
          StreamBuilder(
            stream: ride.socket.stream,
            builder: (context, snapshot) {
              return Text(snapshot.hasData ? '${snapshot.data}' : '');
            },
          )
        ],
      ),
    );
  }
}
