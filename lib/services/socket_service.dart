import 'dart:convert';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/websocket_response_bean.dart';

class SocketService extends GetxController {
  static SocketService get to => Get.find();

  late WebSocketChannel channel;
  var webSocketResponseBean = Rxn<WebSocketResponseBean>();
  var isConnected = false.obs;

  @override
  void onInit() {
    super.onInit();
    connectSocket();
  }

  void connectSocket() {
    channel = WebSocketChannel.connect(
      Uri.parse("ws://192.168.1.26:8000/ws/liveFeed"),
    );

    isConnected.value = true;

    channel.stream.listen(
      (message) {
        final data = jsonDecode(message);

        // adjust according to your API
        webSocketResponseBean.value = WebSocketResponseBean.fromJson(data);
      },
      onError: (error) {
        isConnected.value = false;
        reconnect();
      },
      onDone: () {
        isConnected.value = false;
        reconnect();
      },
    );
  }

  void reconnect() {
    Future.delayed(Duration(seconds: 3), () {
      connectSocket();
    });
  }

  @override
  void onClose() {
    channel.sink.close();
    super.onClose();
  }
}
