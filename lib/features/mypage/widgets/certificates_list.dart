import 'package:flutter/material.dart';

class CertificatesList extends StatelessWidget {
  final List<String> certificates;
  final Function(int) onRemove;
  final VoidCallback onAdd;

  const CertificatesList({required this.certificates, required this.onRemove, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Certificates:', style: TextStyle(fontWeight: FontWeight.bold)),
        for (var i = 0; i < certificates.length; i++)
          Row(
            children: [
              Expanded(child: Text(certificates[i])),
              IconButton(
                icon: Icon(Icons.remove_circle),
                onPressed: () => onRemove(i),
              ),
            ],
          ),
        TextButton.icon(
          onPressed: onAdd,
          icon: Icon(Icons.add_circle),
          label: Text('Add Certificate'),
        ),
      ],
    );
  }
}
