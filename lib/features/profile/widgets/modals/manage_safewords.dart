import 'package:flutter/material.dart';

class ManageSafewords extends StatefulWidget {
  const ManageSafewords({super.key});

  @override
  State<ManageSafewords> createState() => _ManageSafewordsState();
}

class _ManageSafewordsState extends State<ManageSafewords> {
  final List _safewords = [
    {'label': 'Safeword Label1', 'phrase': '"Actual safeword"'},
    {'label': 'Safeword Label2', 'phrase': '"Actual safeword"'},
  ];

  final int _maxSafewords = 3;

  void _addSafeword() {
    if (_safewords.length < _maxSafewords) {
      setState(() {
        int nextIndex = _safewords.length + 1;
        _safewords.add({
          'label': 'Safeword Label$nextIndex',
          'phrase': '"Actual safeword"',
        });
      });
    }
  }

  void _deleteSafeword(int index) {
    setState(() {
      _safewords.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.2,
      maxChildSize: 0.8,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(24),
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Manage Safewords',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Record three phrases to activate the location sharing function and alert. Swipe to delete a safeword.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 24),

              Text(
                'Current safewords: ${_safewords.length}/3',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

              ..._safewords.asMap().entries.map((entry) {
                int index = entry.key;
                var safeword = entry.value;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Dismissible(
                    key: Key(safeword['label']! + index.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.red.shade600,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.delete_outline,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    onDismissed: (direction) {
                      _deleteSafeword(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Safeword deleted'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.volume_up_outlined,
                            size: 26,
                            color: Colors.black87,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  safeword['label']!,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  safeword['phrase']!,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade600,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),

              if (_safewords.length < _maxSafewords)
                GestureDetector(
                  onTap: _addSafeword,
                  child: Container(
                    height: 64,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.add_circle_outline,
                        size: 28,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
