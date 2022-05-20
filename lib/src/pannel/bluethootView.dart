// ignore_for_file: avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hard_and_soft_mobile/src/templates/defaultAppBarTemplate.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:hard_and_soft_mobile/src/pannel/bluethootViewComponents/ChatPage.dart';
import 'package:hard_and_soft_mobile/src/pannel/bluethootViewComponents/DiscoveryPage.dart';
import 'package:hard_and_soft_mobile/src/pannel/bluethootViewComponents/SelectBondedDevicePage.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:hard_and_soft_mobile/src/pannel/bluethootViewComponents/BackgroundCollectedPage.dart';
import 'package:hard_and_soft_mobile/src/pannel/bluethootViewComponents/BackgroundCollectingTask.dart';

class BluethootView extends StatefulWidget {
  const BluethootView({Key? key}) : super(key: key);

  @override
  _BluethootView createState() => _BluethootView();
}

class _BluethootView extends State<BluethootView> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  String _address = "...";
  String _name = "...";

  Timer? _discoverableTimeoutTimer;
  int _discoverableTimeoutSecondsLeft = 0;

  BackgroundCollectingTask? _collectingTask;

  bool _autoAcceptPairingRequests = false;

  @override
  void initState() {
    super.initState();

    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    Future.doWhile(() async {
      if ((await FlutterBluetoothSerial.instance.isEnabled) ?? false) {
        return false;
      }
      await Future.delayed(const Duration(milliseconds: 0xDD));
      return true;
    }).then((_) {
      FlutterBluetoothSerial.instance.address.then((address) {
        setState(() {
          _address = address!;
        });
      });
    });

    FlutterBluetoothSerial.instance.name.then((name) {
      setState(() {
        _name = name!;
      });
    });

    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
        _discoverableTimeoutTimer = null;
        _discoverableTimeoutSecondsLeft = 0;
      });
    });
  }

  @override
  void dispose() {
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
    _collectingTask?.dispose();
    _discoverableTimeoutTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBarTemplate(title: "Bluethoot View"),
      body: ListView(
        children: <Widget>[
          const ListTile(title: Text('General')),
          SwitchListTile(
            title: const Text('Enable Bluetooth'),
            value: _bluetoothState.isEnabled,
            onChanged: (bool value) {
              future() async {
                if (value) {
                  await FlutterBluetoothSerial.instance.requestEnable();
                } else {
                  await FlutterBluetoothSerial.instance.requestDisable();
                }
              }

              future().then((_) {
                setState(() {});
              });
            },
          ),
          ListTile(
            title: const Text('Bluetooth status'),
            subtitle: Text(_bluetoothState.toString()),
            trailing: ElevatedButton(
              child: const Text('Settings'),
              onPressed: () {
                FlutterBluetoothSerial.instance.openSettings();
              },
            ),
          ),
          ListTile(
            title: const Text('Local adapter address'),
            subtitle: Text(_address),
          ),
          ListTile(
            title: const Text('Local adapter name'),
            subtitle: Text(_name),
            onLongPress: null,
          ),
          ListTile(
            title: _discoverableTimeoutSecondsLeft == 0
                ? const Text("Discoverable")
                : Text("Discoverable for ${_discoverableTimeoutSecondsLeft}s"),
            subtitle: const Text("PsychoX-Luna"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: _discoverableTimeoutSecondsLeft != 0,
                  onChanged: null,
                ),
                const IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: null,
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () async {
                    print('Discoverable requested');
                    final int timeout = (await FlutterBluetoothSerial.instance
                        .requestDiscoverable(60))!;
                    if (timeout < 0) {
                      print('Discoverable mode denied');
                    } else {
                      print('Discoverable mode acquired for $timeout seconds');
                    }
                    setState(() {
                      _discoverableTimeoutTimer?.cancel();
                      _discoverableTimeoutSecondsLeft = timeout;
                      _discoverableTimeoutTimer = Timer.periodic(
                          const Duration(seconds: 1), (Timer timer) {
                        setState(() {
                          if (_discoverableTimeoutSecondsLeft < 0) {
                            FlutterBluetoothSerial.instance.isDiscoverable
                                .then((isDiscoverable) {
                              if (isDiscoverable ?? false) {
                                print(
                                    "Discoverable after timeout... might be infinity timeout :F");
                                _discoverableTimeoutSecondsLeft += 1;
                              }
                            });
                            timer.cancel();
                            _discoverableTimeoutSecondsLeft = 0;
                          } else {
                            _discoverableTimeoutSecondsLeft -= 1;
                          }
                        });
                      });
                    });
                  },
                )
              ],
            ),
          ),
          const Divider(),
          const ListTile(title: Text('Devices discovery and connection')),
          SwitchListTile(
            title: const Text('Auto-try specific pin when pairing'),
            subtitle: const Text('Pin 1234'),
            value: _autoAcceptPairingRequests,
            onChanged: (bool value) {
              setState(() {
                _autoAcceptPairingRequests = value;
              });
              if (value) {
                FlutterBluetoothSerial.instance.setPairingRequestHandler(
                    (BluetoothPairingRequest request) {
                  print("Trying to auto-pair with Pin 1234");
                  if (request.pairingVariant == PairingVariant.Pin) {
                    return Future.value("1234");
                  }
                  return Future.value(null);
                });
              } else {
                FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
              }
            },
          ),
          ListTile(
            title: ElevatedButton(
                child: const Text('Explore discovered devices'),
                onPressed: () async {
                  final BluetoothDevice? selectedDevice =
                      await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const DiscoveryPage();
                      },
                    ),
                  );

                  if (selectedDevice != null) {
                    print('Discovery -> selected ' + selectedDevice.address);
                  } else {
                    print('Discovery -> no device selected');
                  }
                }),
          ),
          ListTile(
            title: ElevatedButton(
              child: const Text('Connect to paired device to chat'),
              onPressed: () async {
                final BluetoothDevice? selectedDevice =
                    await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const SelectBondedDevicePage(
                          checkAvailability: false);
                    },
                  ),
                );

                if (selectedDevice != null) {
                  print('Connect -> selected ' + selectedDevice.address);
                  _startChat(context, selectedDevice);
                } else {
                  print('Connect -> no device selected');
                }
              },
            ),
          ),
          const Divider(),
          const ListTile(title: Text('Multiple connections example')),
          ListTile(
            title: ElevatedButton(
              child: ((_collectingTask?.inProgress ?? false)
                  ? const Text('Disconnect and stop background collecting')
                  : const Text('Connect to start background collecting')),
              onPressed: () async {
                if (_collectingTask?.inProgress ?? false) {
                  await _collectingTask!.cancel();
                  setState(() {});
                } else {
                  final BluetoothDevice? selectedDevice =
                      await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const SelectBondedDevicePage(
                            checkAvailability: false);
                      },
                    ),
                  );

                  if (selectedDevice != null) {
                    await _startBackgroundTask(context, selectedDevice);
                    setState(() {});
                  }
                }
              },
            ),
          ),
          ListTile(
            title: ElevatedButton(
              child: const Text('View background collected data'),
              onPressed: (_collectingTask != null)
                  ? () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return ScopedModel<BackgroundCollectingTask>(
                              model: _collectingTask!,
                              child: const BackgroundCollectedPage(),
                            );
                          },
                        ),
                      );
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  void _startChat(BuildContext context, BluetoothDevice server) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return ChatPage(server: server);
        },
      ),
    );
  }

  Future<void> _startBackgroundTask(
    BuildContext context,
    BluetoothDevice server,
  ) async {
    try {
      _collectingTask =
          await BackgroundCollectingTask.connect(server).then((value) => null);
      await _collectingTask!.start().then((value) => null);
    } catch (ex) {
      _collectingTask?.cancel();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error occured while connecting'),
            content: Text(ex.toString()),
            actions: <Widget>[
              TextButton(
                child: const Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
