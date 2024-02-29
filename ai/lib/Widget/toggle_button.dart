import 'package:flutter/material.dart';
import 'package:ai/Constants/theme.dart';

import 'package:ai/Screens/chat_screen.dart';

class ToggleButton extends StatefulWidget {
  final InputMode _inputmode;
  final VoidCallback _sendTextMessage;
  final VoidCallback _sendVoiceMessage;
  final bool _isReplying;
  final bool _isListening;

  const ToggleButton({
    super.key,
    required InputMode inputmode,
    required VoidCallback sendTextMessage,
    required VoidCallback sendVoiceMessage,
    required bool isReplying,
    required bool isListening,
  })  : _inputmode = inputmode,
        _sendTextMessage = sendTextMessage,
        _sendVoiceMessage = sendVoiceMessage,
        _isReplying = isReplying,
        _isListening = isListening;

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.primary,
        shape: CircleBorder(),
        padding: EdgeInsets.all(10),
      ),
      onPressed: widget._isReplying
          ? null
          : widget._inputmode == InputMode.text
              ? widget._sendTextMessage
              : widget._sendVoiceMessage,
      child: Icon(
        widget._inputmode == InputMode.text
            ? Icons.send
            : widget._isListening
                ? Icons.mic_off
                : Icons.mic,
      ),
    );
  }
}
