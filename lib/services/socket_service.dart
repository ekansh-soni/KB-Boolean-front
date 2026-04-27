import 'dart:convert';
import 'package:kb_boolean/repository/api_endpoints.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketService {
  final channel = WebSocketChannel.connect(
    Uri.parse(Endpoints.websocketUrl), // your websocket URL
  );

  Stream get stream => channel.stream;

  void send(data) {
    channel.sink.add(jsonEncode(data));
  }

  void dispose() {
    channel.sink.close();
  }
}