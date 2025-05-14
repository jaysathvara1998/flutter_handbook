import 'package:flutter/material.dart';
import 'package:flutter_handbook/core/utils/utils.dart';
import 'package:flutter_handbook/models/topic.dart';

class TopicCard extends StatefulWidget {
  final Topic topic;
  final VoidCallback onReadMoreTap;

  const TopicCard({
    super.key,
    required this.topic,
    required this.onReadMoreTap,
  });

  @override
  State<TopicCard> createState() => _TopicCardState();
}

class _TopicCardState extends State<TopicCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.topic.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  const SizedBox(height: 8),
                  Text(
                    Utils.htmlToPlainText(widget.topic.description),
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: widget.onReadMoreTap,
                      icon: const Text('Read More'),
                      label: const Icon(Icons.arrow_forward),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
