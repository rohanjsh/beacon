import 'package:flutter/material.dart';
import 'package:hypertrack_plugin/hypertrack.dart';
import 'package:qualification_1/domain/networking/networking.dart';
import 'package:share/share.dart';

//TODO Add your publishablekey here
const String publishableKey =
    'xx';

class HyperTrackQuickStart extends StatefulWidget {
  HyperTrackQuickStart({Key key}) : super(key: key);

  @override
  _HyperTrackQuickStartState createState() => _HyperTrackQuickStartState();
}

class _HyperTrackQuickStartState extends State<HyperTrackQuickStart> {
  HyperTrack sdk;
  String deviceId;
  String result = '';
  bool isLoading = false;
  bool isLink = false;
  NetworkHelper helper;

  @override
  void initState() {
    super.initState();
    initializeSdk();
  }

  Future<void> initializeSdk() async {
    sdk = await HyperTrack.initialize(publishableKey);
    deviceId = await sdk.getDeviceId();
    sdk.setDeviceName('USER NAME HERE');
    print(deviceId);
    helper = NetworkHelper(
      auth:
          'Basic xxx',
      id: deviceId,
      url: 'https://v3.api.hypertrack.com',
    );
  }

  void shareLink() async {
    setState(() {
      isLoading = true;
      result = '';
    });
    var data = await helper.getData();
    setState(() {
      result = data['views']['share_url'];
      isLink = true;
      isLoading = false;
    });
    Share.share(data['views']['share_url'], subject: 'USER NAME\'s Location');
  }

  void startTracking() async {
    setState(() {
      isLoading = true;
      result = '';
    });
    var startTrack = await helper.startTracing();
    setState(() {
      result = (startTrack['message']);
      isLink = false;
      isLoading = false;
    });
  }

  void endTracking() async {
    setState(() {
      isLoading = true;
      result = '';
    });
    var endTrack = await helper.endTracing();
    setState(() {
      result = (endTrack['message']);
      isLink = false;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 0.0,
            width: double.infinity,
          ),
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isLoading ? CircularProgressIndicator() : Text(''),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  result,
                  style: TextStyle(
                      color: isLink ? Colors.blue[900] : Colors.red[900],
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          TextButton(
            child: Text(
              'Start Tracking my Location',
            ),
            onPressed: startTracking,
          ),
          TextButton(
            child: Text('Share my Location'),
            onPressed: shareLink,
          ),
          TextButton(
            child: Text('End Tracking my Location'),
            onPressed: endTracking,
          ),
        ],
      ),
    ));
  }
}
