import 'package:clean_archi_travel_app/feature/trip/presentation/provider/trip_provider.dart';
import 'package:clean_archi_travel_app/feature/trip/presentation/widgets/custom_search_widget.dart';
import 'package:clean_archi_travel_app/feature/trip/presentation/widgets/trip_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TripScreen extends ConsumerWidget {
  const TripScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripList = ref.watch(tripListNotifierProvider);
    print("hte number of length ${tripList.length}");
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomSearchBar(),
          ListView.builder(
            shrinkWrap: true,
            itemCount: tripList.length,
            itemBuilder: (context, index) => TripWidget(trip: tripList[index]),
          ),
        ],
      ),
    );
  }
}
