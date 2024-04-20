import 'package:flutter/material.dart';

class PgCard extends StatelessWidget {
  final String name;
  final String imageurl;
  final double price;
  final String adderess;
  final Function onTap;

  const PgCard(
      {super.key,
      required this.name,
      required this.imageurl,
      required this.price,
      required this.adderess,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      imageurl,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 120,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 120,
                          child: const Icon(
                            Icons.image,
                            size: 75,
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 9),
                          Text(
                            "$price",
                            style: const TextStyle(fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              adderess,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ));
  }
}
