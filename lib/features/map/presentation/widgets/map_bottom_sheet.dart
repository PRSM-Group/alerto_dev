import 'package:flutter/material.dart';

class MapBottomSheet extends StatefulWidget {
  const MapBottomSheet({super.key});

  @override
  State<MapBottomSheet> createState() => _MapBottomSheetState();
}

class _MapBottomSheetState extends State<MapBottomSheet>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.15,
      minChildSize: 0.15,
      maxChildSize: 0.75,
      snap: true,
      snapSizes: const [0.15, 0.75],
      builder: (context, scrollController) {
        return Material(
          color: Colors.white,
          elevation: 8,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              // Drag handle
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              // Header
              const SizedBox(height: 12),

              // Tabs
              TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.red,
                indicatorWeight: 3,
                tabs: const [
                  Tab(text: 'Road Status'),
                  Tab(text: 'Facilities'),
                  Tab(text: 'Routes'),
                ],
              ),

              // Empty space controlled by the draggable sheet
              Expanded(
                child: ListView(
                  controller: scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: const [SizedBox(height: 1000)],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
