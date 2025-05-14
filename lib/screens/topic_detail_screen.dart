import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_handbook/models/topic.dart';
import 'package:flutter_highlight/themes/monokai.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:highlight/languages/dart.dart';

class TopicDetailScreen extends StatelessWidget {
  final Topic topic;

  const TopicDetailScreen({
    super.key,
    required this.topic,
  });

  @override
  Widget build(BuildContext context) {
    final controller = CodeController(
      text: topic.example,
      language: dart,
      readOnly: true,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(topic.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(height: 16),
            // Card(
            //   child: Padding(
            //     padding: const EdgeInsets.all(16),
            //     child: Text(
            //       topic.title,
            //       style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            //             fontStyle: FontStyle.italic,
            //           ),
            //     ),
            //   ),
            // ),
            Html(data: topic.description),
            if (topic.example.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Example',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(height: 16),
              CodeTheme(
                  data: CodeThemeData(styles: monokaiTheme),
                  child: CodeField(
                    controller: controller,
                    gutterStyle: GutterStyle(
                      showErrors: false,
                      showFoldingHandles: false,
                      showLineNumbers: false,
                    ),
                  )),
            ],
          ],
        ),
      ),
    );
  }
}
