import "package:flutter/material.dart";
import "package:bluetoothadapter/bluetoothadapter.dart";

class BluethootView extends StatefulWidget {
  const BluethootView({Key? key}) : super(key: key);

  @override
  State<BluethootView> createState() => _BluethootViewState();
}

class _BluethootViewState extends State<BluethootView> {
  Bluetoothadapter flutterbluetoothadapter = Bluetoothadapter();
  String _connectionStatus = "NONE";
  List<BtDevice> devices = [];
  String _recievedMessage = "";
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    flutterbluetoothadapter.initBlutoothConnection(null);
    flutterbluetoothadapter.checkBluetooth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () async {
                      await flutterbluetoothadapter.startServer();
                    },
                    child: const Text('LISTEN'),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () async {
                      devices = await flutterbluetoothadapter.getDevices();
                      setState(() {});
                    },
                    child: const Text('LIST DEVICES'),
                  ),
                ),
              )
            ],
          ),
          Text("STATUS - $_connectionStatus"),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 20,
            ),
            child: ListView(
              shrinkWrap: true,
              children: _createDevices(),
            ),
          ),
          Text(
            _recievedMessage,
            style: const TextStyle(fontSize: 24),
          ),
          Row(
            children: <Widget>[
              Flexible(
                flex: 4,
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _controller,
                    decoration:
                        const InputDecoration(hintText: "Write message"),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () {
                      flutterbluetoothadapter.sendMessage(_controller.text,
                          sendByteByByte: false);
//                        flutterbluetoothadapter.sendMessage(".",
//                            sendByteByByte: true);
                      _controller.text = "";
                    },
                    child: const Icon(
                      Icons.send,
                      semanticLabel: "Send",
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  _createDevices() {
    if (devices.isEmpty) {
      return [
        const Center(
          child: Text("No Paired Devices listed..."),
        )
      ];
    }
    List<Widget> deviceList = [];
    for (var element in devices) {
      deviceList.add(
        InkWell(
          key: UniqueKey(),
          onTap: () {
            flutterbluetoothadapter.startClient(devices.indexOf(element), true);
          },
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(border: Border.all()),
            child: Text(
              element.name.toString(),
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      );
    }
    return deviceList;
  }
}
