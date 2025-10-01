
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final quantityProvider = StateProvider<int>((ref) => 1);
final selectedColorProvider = StateProvider<int>((ref) => 0);
final selectedSizeProvider = StateProvider<int>((ref) => 0);


class ProductDetails extends ConsumerStatefulWidget {
  final Map<String, String> product;

  const ProductDetails({super.key, required this.product});

  @override
  ConsumerState<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends ConsumerState<ProductDetails> {
  final colors = [Colors.green, Colors.blueGrey, Colors.yellow, Colors.orange];
  final sizes = ["M", "W", "EW"];

  final List<String> gallery = [
    'assets/sunglass1.jpg',
    'assets/sunglass1.jpg',
    'assets/sunglass2.jpg',
    'assets/sunglass2.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final quantity = ref.watch(quantityProvider);
    final selectedColor = ref.watch(selectedColorProvider);
    final selectedSize = ref.watch(selectedSizeProvider);

    return Scaffold(
      backgroundColor: Colors.brown.shade900,
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.black),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Image.asset(
                            widget.product['image']!,
                            fit: BoxFit.fitWidth,
                            width: 200,
                            height: 200,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(colors.length, (index) {
                            return GestureDetector(
                              onTap: () => ref
                                  .read(selectedColorProvider.notifier)
                                  .state = index,
                              child: Container(
                                margin:
                                const EdgeInsets.symmetric(horizontal: 6),
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: selectedColor == index
                                        ? Colors.black
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: colors[index],
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.product['name'] ?? '',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              widget.product['price'] ?? '',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text("Gallery",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 60,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: gallery.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(right: 10),
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    gallery[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text("Description",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        const Text(
                          "The eyeglasses feature a wayfarer style, which is a classic & versatile shape that suits most face types.",
                          style: TextStyle(color: Colors.black54),
                        ),
                        const SizedBox(height: 20),
                        const Text("Size",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Row(
                          children: List.generate(sizes.length, (index) {
                            return GestureDetector(
                              onTap: () => ref
                                  .read(selectedSizeProvider.notifier)
                                  .state = index,
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: selectedSize == index
                                      ? Colors.orange
                                      : Colors.grey.shade200,
                                ),
                                child: Text(
                                  sizes[index],
                                  style: TextStyle(
                                    color: selectedSize == index
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove, color: Colors.white),
                          onPressed: quantity > 1
                              ? () => ref
                              .read(quantityProvider.notifier)
                              .state--
                              : null,
                        ),
                        Text(
                          "$quantity",
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, color: Colors.white),
                          onPressed: () => ref
                              .read(quantityProvider.notifier)
                              .state++,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        backgroundColor: Colors.orange,
                      ),
                      onPressed: () {

                        final selectedSizeValue = sizes[selectedSize];
                        final selectedColorValue = colors[selectedColor];

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Added ${widget.product['name']} x$quantity (Size: $selectedSizeValue)'),
                        ));
                      },
                      child: const Text(
                        "Buy Now",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



