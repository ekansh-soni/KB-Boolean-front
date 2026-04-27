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

  var comexList = <LiveData>[].obs;
  var futureList = <LiveData>[].obs;

  void connectSocket() {
    channel = WebSocketChannel.connect(
      Uri.parse("ws://192.168.1.13:8000/ws/liveFeed"),
    );

    isConnected.value = true;

    channel.stream.listen(
      (message) {
        final data = jsonDecode(message);

        // adjust according to your API
        webSocketResponseBean.value = WebSocketResponseBean.fromJson(data);

        comexList.value = getComexList(webSocketResponseBean.value);
        futureList.value = getFutureList(webSocketResponseBean.value);
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

  List<LiveData> getComexList(WebSocketResponseBean? data) {
    final list = data?.liveData ?? [];

    return list
        .where(
          (item) =>
              item.symbol == 'XAUUSD' ||
              item.symbol == 'XAGUSD' ||
              item.symbol == 'INRSPOT' ||
        item.symbol == 'INRSpot'
        )
        .toList();
  }

  List<LiveData> getFutureList(WebSocketResponseBean? data) {
    final list = data?.liveData ?? [];

    return list
        .where(
          (item) => item.symbol == 'goldnext' || item.symbol == 'silvernext',
        )
        .toList();
  }

  @override
  void onClose() {
    channel.sink.close();
    super.onClose();
  }
}
