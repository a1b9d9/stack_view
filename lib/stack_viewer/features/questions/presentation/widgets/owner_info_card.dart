import 'package:flutter/material.dart';
import 'package:stack_viewer/stack_viewer/features/questions/domain/entities/question_entities/owner_question.dart';
import 'package:stack_viewer/stack_viewer/features/questions/presentation/widgets/static_methode.dart';

class OwnerInfoCard extends StatelessWidget {
  final OwnerEntity owner;

  const OwnerInfoCard({
    Key? key,
    required this.owner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(owner.avatarUrl),
              radius: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Posted by',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    owner.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            TextButton.icon(
              onPressed: () async {
                try {
                  await StaticMethode.launchUrlMethode(owner.profileLink);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Could not open profile'),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.person),
              label: const Text('View Profile'),
            ),
          ],
        ),
      ),
    );
  }
} 