import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:riceking/widget/button.dart';
import 'package:riceking/widget/staff.dart';

import '../../function/appFunction.dart';
import '../../function/dataBaseFunction.dart';
import '../../widget/inputField.dart';
import '../../widget/text.dart';

class AiAssist extends StatefulWidget {
  const AiAssist({super.key});

  @override
  State<AiAssist> createState() => _AiAssistState();
}

class _AiAssistState extends State<AiAssist> {
  TextEditingController aiController = TextEditingController();
  List<Map<String, String>> chat = [];
  bool onLoad = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment(0, 0),
              child: Opacity(
                opacity: chat.isEmpty ? 0.2 : 0.05,
                child: Image.asset(
                  'assets/appLogo.png',
                  width: width(context) * 0.8,
                ),
              ),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconAsButton(
                        icon: Icons.arrow_back_outlined,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        size: 24,
                      ),
                      SizedBox(width: 8),
                      RobotoText(title: 'Crop AI', size: 24),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Expanded(
                  child: SizedBox(
                    width: width(context),
                    child: ListView.builder(
                      itemCount: chat.length,
                      itemBuilder: (context, index) {
                        return message(chat[index]);
                      },
                    ),
                  ),
                ),
                Visibility(visible: onLoad, child: loader()),
                TextFieldForMsg(
                  controller: aiController,
                  hintText: 'Message',
                  icons: Icons.send,
                  keyboardType: TextInputType.text,
                  onPressed: () async {
                    String _quary = aiController.text;
                    setState(() {
                      chat.add({'source': 'user', 'response': _quary});
                      chat.add({'source': 'ai', 'response': '''# Coming Soon: RiceKing AI Assistant

We're excited to announce that we're adding a new, powerful feature to the RiceKing app—an **AI assistant** designed specifically for the agricultural community. This intelligent tool will be your trusted partner, ready to help you with all your farming questions and technological needs.

### What to Expect

The RiceKing AI assistant is being developed to provide instant, expert advice on a wide range of agricultural topics. Here's a glimpse of how it will help you:

* **Get Instant Answers:** Have a question about a crop disease, pest control, or soil health? Just ask! Our AI will provide accurate, reliable information in seconds, saving you valuable time.

* **Learn About New Technology:** Stay ahead of the curve. The AI can explain the latest farming technologies and how to integrate them into your operations to boost efficiency and yield.

* **Access a Knowledge Hub:** The assistant will be powered by a vast database of agricultural knowledge, from traditional farming methods to cutting-edge research, all at your fingertips.

We are dedicated to building a tool that is not only smart but also easy to use, helping you make the best decisions for your farm.

We can't wait to see how RiceKing AI helps you grow. Stay tuned for updates on our official launch!'''});
                      aiController.clear();
                      // onLoad = true;
                    });
                    // String response = await getAiResponse(_quary);
                    // setState(() {
                    //   if (response.isEmpty) {
                    //     chat.removeLast();
                    //     aiController = TextEditingController(text: _quary);
                    //     showToast('No response found', context);
                    //   } else {
                    //     chat.add({'source': 'ai', 'response': response});
                    //     aiController.clear();
                    //   }
                    //   onLoad = false;
                    // });
                  },
                ),
                SizedBox(height: 14),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget message(Map<String, String> response) {
    bool user = (response['source'] ?? 'user') == 'user';
    return Container(
      margin: EdgeInsets.only(
        left: user ? 50 : 18,
        right: user ? 18 : 50,
        top: 5,
        bottom: 5,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color:
            user
                ? Theme.of(context).colorScheme.primary.withOpacity(0.9)
                : Theme.of(context).colorScheme.primary.withOpacity(0.2),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(12),
          topRight: const Radius.circular(12),
          bottomLeft: user ? const Radius.circular(12) : Radius.zero,
          bottomRight: user ? Radius.zero : const Radius.circular(12),
        ),
      ),
      child: MarkdownBody(
        data: response['response'] ?? '',
        styleSheet: MarkdownStyleSheet(
          p: TextStyle(
            color: user ? Colors.white : Theme.of(context).colorScheme.tertiary,
            fontSize: 16,
            height: 1.4,
          ),
          a: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  Widget loader() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SpinKitFadingCircle(
        color: Theme.of(context).colorScheme.tertiary,
        size: 30.0,
      ),
    );
  }

  Future<String> getAiResponse(String message) async {
    final response = await Database().getAiResponse(message);
    return response;
  }
}
