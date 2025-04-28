import 'package:edunourish/features/student/screens/list/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:edunourish/features/student/providers/student_provider.dart';
import 'package:edunourish/core/models/food_palce.dart';


class Restaurant extends StatefulWidget {
  const Restaurant({Key? key}) : super(key: key);

  @override
  State<Restaurant> createState() => _RestaurantState();
}

class _RestaurantState extends State<Restaurant> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<StudentProvider>();

    // Show loading indicator inside Scaffold
    if (prov.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final allPlaces = prov.foodPlace;
    // filter places by name or description
    final filtered = allPlaces.where((place) {
      final q = searchText.toLowerCase();
      return (place.name?.toLowerCase().contains(q) ?? false) ||
             (place.description?.toLowerCase().contains(q) ?? false);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildAppBar(context),
              const SizedBox(height: 20),
              _buildSearchField(),
              const SizedBox(height: 20),

              // either show grid or "no results"
              Expanded(
                child: filtered.isEmpty
                  ? _buildNoResults()
                  : GridView.builder(
                      itemCount: filtered.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (_, i) =>
                          _buildPlaceCard(context, filtered[i]),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        const Text(
          "Food Place",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ProfilePageStudent()),
            );
          },
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            child: const Icon(Icons.person),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        onChanged: (val) => setState(() => searchText = val),
        decoration: const InputDecoration(
          hintText: "Search dishes, restaurants...",
          prefixIcon: Icon(Icons.search),
          suffixIcon: Icon(Icons.mic),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
        ),
      ),
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.restaurant_menu,
              size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 12),
          Text(
            'No restaurants found',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceCard(BuildContext context, FoodPlace place) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () => _showPlaceDetails(context, place),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // image
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.network(
                  place.photo ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(height: 8),
            // name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                place.name ?? '',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                place.description ?? '',
                style: const TextStyle(fontSize: 14, color: Colors.black54),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPlaceDetails(BuildContext context, FoodPlace place) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        final height = MediaQuery.of(context).size.height * 0.7;
        return SizedBox(
          height: height,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // drag handle
                Container(
                  width: 80,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xff008f99),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 12),
                // large image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    place.photo ?? '',
                    height: 400,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.error, size: 80, color: Colors.red),
                  ),
                ),
                const SizedBox(height: 16),
                // name
                Text(
                  place.name ?? '',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                // full description
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      place.description ?? '',
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
