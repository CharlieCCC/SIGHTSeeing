import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class VisionTest extends StatefulWidget{
  @override
  _VisionTestState createState() => _VisionTestState();
}

class _VisionTestState extends State<VisionTest> {
  final double TEXT_HEIGHT = 60;
  final List<TextEditingController> _controller = [];
  final List<FocusNode> _FocusNode = [];

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text("确定要保存及退出吗?"),
        actions: <Widget>[
          FlatButton(
            child: Text('保存'),
            onPressed: (){
              _saveData();
              Navigator.of(context).pop(true);
            },
          ),
          FlatButton(
            child: Text('不要'),
            onPressed: (){
              Navigator.of(context).pop(false);
            },
          ),
        ],
      ),
    )??false;
  }

  SizedBox _showingText( String text, double boxHeight, double ratio, TextAlign alignment){
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: ratio * screenWidth,
      // height: boxHeight,
      child: Text(text,
        textAlign: alignment,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  SizedBox _inputTextField( double boxHeight, double ratio, TextEditingController _controller,
      FocusNode firstNode, FocusNode nextNode){
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: ratio * screenWidth,
      // height: boxHeight,
      child: TextField(
        controller: _controller,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        textInputAction: (nextNode != null ) ? TextInputAction.next : TextInputAction.done,
        focusNode: firstNode,
        onSubmitted: (term){
          firstNode.unfocus();
          if(nextNode != null) {
            FocusScope.of(context).requestFocus(nextNode);
          }
        },

      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    for(int i = 0; i < 6; i++) {
      _controller.add(new TextEditingController());
      _FocusNode.add(new FocusNode());
    }
    int _nodeInstantiated = 0;

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: ListView(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _showingText("", TEXT_HEIGHT, 0.4, TextAlign.center),
                  _showingText("左", TEXT_HEIGHT, 0.2, TextAlign.center),
                  SizedBox(width: MediaQuery.of(context).size.width*0.05),
                  _showingText("右", TEXT_HEIGHT, 0.2, TextAlign.center),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _showingText("裸眼远视力", TEXT_HEIGHT, 0.4, TextAlign.center),
                  _inputTextField(TEXT_HEIGHT, 0.2, _controller[_nodeInstantiated],
                      _FocusNode[_nodeInstantiated], _FocusNode[++_nodeInstantiated]),
                  SizedBox(width: MediaQuery.of(context).size.width*0.05),
                  _inputTextField(TEXT_HEIGHT, 0.2, _controller[_nodeInstantiated],
                      _FocusNode[_nodeInstantiated], _FocusNode[++_nodeInstantiated]),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _showingText("戴镜远视力", TEXT_HEIGHT, 0.4, TextAlign.center),
                  _inputTextField(TEXT_HEIGHT, 0.2, _controller[_nodeInstantiated],
                      _FocusNode[_nodeInstantiated], _FocusNode[++_nodeInstantiated]),
                  SizedBox(width: MediaQuery.of(context).size.width*0.05),
                  _inputTextField(TEXT_HEIGHT, 0.2, _controller[_nodeInstantiated],
                      _FocusNode[_nodeInstantiated], _FocusNode[++_nodeInstantiated]),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _showingText("小孔视力", TEXT_HEIGHT, 0.4, TextAlign.center),
                  _inputTextField(TEXT_HEIGHT, 0.2, _controller[_nodeInstantiated],
                      _FocusNode[_nodeInstantiated], _FocusNode[++_nodeInstantiated]),
                  SizedBox(width: MediaQuery.of(context).size.width*0.05),
                  _inputTextField(TEXT_HEIGHT, 0.2, _controller[_nodeInstantiated],
                      _FocusNode[_nodeInstantiated], null),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                ],
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.05),

              Row(
                children: <Widget>[
                  SizedBox(width: MediaQuery.of(context).size.width * 0.4),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: RaisedButton(
                      onPressed: (){
                        /// button for save and back to last page
                        _saveData();
                        Navigator.pop(context);
                      },
                      child: Text("完成"),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: RaisedButton(
                        onPressed: (){
                          for(int i = 0; i < _controller.length; i++)
                            _controller[i].clear();
                        },
                      child: Text("清除所有"),
                    ),
                  ),
                ],
              ),
            ],
        ),
      ),
    );
  }
  void _saveData(){

  }
}