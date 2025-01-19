import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:file_picker/file_picker.dart';
//import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  bool _showEmojiPicker = false;
  bool _showAttachmentOptions = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: const NetworkImage(
                  "https://via.placeholder.com/150"), // Replace with user image
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Phillip Franci",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Online",
                  style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam, color: Colors.white),
            onPressed: () {
              _showCallDialog(context, "Video Call");
            },
          ),
          IconButton(
            icon: const Icon(Icons.call, color: Colors.white),
            onPressed: () {
              _showCallDialog(context, "Voice Call");
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: const [
                ChatBubble(
                  text: "Hi, I'm doing good, thanks for asking. How about you?",
                  isSender: true,
                  time: "10:00 AM",
                  bubbleColor: Colors.blue,
                  textColor: Colors.white,
                ),
                ChatBubble(
                  text:
                      "Same here, everything’s good. Have you made any plans for vacation yet?",
                  isSender: false,
                  time: "10:01 AM",
                  bubbleColor: Colors.white,
                  textColor: Colors.black,
                ),
              ],
            ),
          ),
          if (_showAttachmentOptions) _buildAttachmentOptions(),
          if (_showEmojiPicker)
            EmojiPicker(
              onEmojiSelected: (category, emoji) {
                _messageController.text += emoji.emoji;
              },
              config: Config(
                  // Corrected the parameter name
                  //emojiSizeMax: 32,
                  //bgColor: Colors.grey[200]!,
                  ),
            ),
          // Input bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.emoji_emotions, color: Colors.grey),
                  onPressed: () {
                    setState(() {
                      _showEmojiPicker = !_showEmojiPicker;
                      _showAttachmentOptions = false;
                    });
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message",
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.attach_file, color: Colors.grey),
                  onPressed: () {
                    setState(() {
                      _showAttachmentOptions = !_showAttachmentOptions;
                      _showEmojiPicker = false;
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt, color: Colors.grey),
                  onPressed: _pickImage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentOptions() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildAttachmentOption(
            icon: Icons.image,
            label: "Gallery",
            onTap: _pickImage,
          ),
          _buildAttachmentOption(
            icon: Icons.camera_alt,
            label: "Camera",
            onTap: _pickImage,
          ),
          _buildAttachmentOption(
            icon: Icons.file_copy,
            label: "Document",
            onTap: _pickFile,
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentOption(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blue[100],
            child: Icon(icon, color: Colors.blue),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.black),
          ),
        ],
      ),
    );
  }

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      debugPrint("Selected image path: ${image.path}");
    }
  }

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      debugPrint("Selected file path: ${result.files.single.path}");
    }
  }

  void _showCallDialog(BuildContext context, String callType) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("$callType in Progress"),
          content: const Text("This is a simulation of a call."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("End Call"),
            ),
          ],
        );
      },
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isSender;
  final String time;
  final Color bubbleColor;
  final Color textColor;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isSender,
    required this.time,
    required this.bubbleColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft:
                isSender ? const Radius.circular(12) : const Radius.circular(0),
            bottomRight:
                isSender ? const Radius.circular(0) : const Radius.circular(12),
          ),
        ),
        child: Column(
          crossAxisAlignment:
              isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(color: textColor, fontSize: 15),
            ),
            const SizedBox(height: 5),
            Text(
              time,
              style: TextStyle(
                color: isSender ? Colors.white70 : Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
