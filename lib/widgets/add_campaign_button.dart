import 'package:flutter/material.dart';

class AddCampaignButton extends StatelessWidget {
  const AddCampaignButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.person),
        const SizedBox(width: 8),
        TextButton.icon(
          onPressed: () {
            Navigator.of(context).pushNamed('/add_campaign');
          },
          icon: const Icon(Icons.add),
          label: const Text('Adicionar campanha'),
        ),
      ],
    );
  }
}
