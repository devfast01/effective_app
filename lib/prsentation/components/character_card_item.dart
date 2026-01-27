import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CharacterCardItem extends StatefulWidget {
  final String avatarUrl; // optional: real image url
  final String name;
  final String timeAgo;
  final String description;

  const CharacterCardItem({
    super.key,
    required this.avatarUrl,
    required this.name,
    required this.timeAgo,
    required this.description,
  });

  @override
  State<CharacterCardItem> createState() => _CharacterCardItemState();
}

class _CharacterCardItemState extends State<CharacterCardItem> {
  bool _isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Circle avatar with icon
          // Cached avatar with nice placeholder & error handling
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),
                child: SizedBox(
                  width: 75,
                  height: double.infinity,
                  child: widget.avatarUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: widget.avatarUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey.shade200,
                            child: const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.grey),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.deepPurple.shade400,
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          // Optional: fade in for smooth loading
                          fadeInDuration: const Duration(milliseconds: 300),
                        )
                      : Container(
                          color: Colors.deepPurple.shade400,
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                ),
              )),

          const SizedBox(width: 16),

          // Main content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + time row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _isFavorited = !_isFavorited;
                        });
                        // Optional: here you can later add real logic
                        // e.g. save to favorites list, call API, etc.
                      },
                      icon: Icon(
                        _isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorited
                            ? Colors.redAccent.shade400 // filled → red
                            : const Color.fromARGB(
                                255, 104, 99, 99), // outlined → grey
                        size: 28,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      tooltip: _isFavorited
                          ? 'Remove from favorites'
                          : 'Add to favorites',
                    ),
                  ],
                ),

                const Spacer(),

                // Description
                Text(
                  widget.description,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.35,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
