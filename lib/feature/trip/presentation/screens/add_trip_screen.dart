import 'package:clean_archi_travel_app/feature/trip/domain/entities/trip_entity.dart';
import 'package:clean_archi_travel_app/feature/trip/presentation/provider/trip_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddTripScreen extends ConsumerWidget {
  const AddTripScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String title = "";
    String pathImage = "";
    String location = "";
    String description = "";
    final GlobalKey<FormState> key = GlobalKey<FormState>();
    void onTap() {
      if (!key.currentState!.validate()) {
        return;
      }
      key.currentState!.save();
      ref.read(tripListNotifierProvider.notifier).addNewTrip(
            TripEntity(
                title: title,
                description: description,
                images: [pathImage],
                date: DateTime.now(),
                location: location),
          );
    }

    return Form(
      key: key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            decoration: InputDecoration(
              label: Text("name of the place"),
            ),
            validator: (value) {
              return (value == null || value.isEmpty)
                  ? "enter a valid text"
                  : null;
            },
            onSaved: (newValue) => title = newValue!,
          ),
          TextFormField(
            decoration: InputDecoration(
              label: Text("description for the place"),
            ),
            validator: (value) {
              return (value == null || value.isEmpty)
                  ? "enter a valid text"
                  : null;
            },
            onSaved: (newValue) => description = newValue!,
          ),
          TextFormField(
            decoration: InputDecoration(
              label: Text("location of the place"),
            ),
            validator: (value) {
              return (value == null || value.isEmpty)
                  ? "enter a valid text"
                  : null;
            },
            onSaved: (newValue) => location = newValue!,
          ),
          TextFormField(
            decoration: InputDecoration(
              label: Text("http image for the place"),
            ),
            validator: (value) {
              return (value == null || value.isEmpty)
                  ? "enter a valid text"
                  : null;
            },
            onSaved: (newValue) => pathImage = newValue!,
          ),
          Center(
            child: ElevatedButton(
              onPressed: onTap,
              child: Text('Add trip'),
            ),
          ),
        ],
      ),
    );
  }
}
