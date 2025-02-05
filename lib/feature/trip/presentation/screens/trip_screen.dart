import 'package:clean_archi_travel_app/feature/trip/domain/entities/trip_entity.dart';
import 'package:clean_archi_travel_app/feature/trip/presentation/provider/trip_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TripScreen extends ConsumerWidget {
  const TripScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<TripEntity> tripList = ref.watch(tripListNotifierProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // here we will call the use case of the delete
          print("im in the on pressed");
          ref.read(tripListNotifierProvider.notifier).addNewTrip(
                TripEntity(
                    title: "model place",
                    description: "i'm just trying so wait for me oky!!",
                    images: [],
                    date: DateTime.now(),
                    location: "cd"),
              );
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: tripList.length,
        itemBuilder: (context, index) => Text(tripList[index].title),
      ),
    );
  }
}
