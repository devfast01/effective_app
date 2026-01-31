// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../domain/entities/favorite_character.dart';
// import '../bloc/favorites_bloc/favorites_bloc.dart';
// import '../bloc/favorites_bloc/favorites_event.dart';
// import '../bloc/favorites_bloc/favorites_state.dart';

// class CharacterCardItem extends StatefulWidget {
//   final int id;
//   final String name;
//   final String avatarUrl;
//   final String timeAgo;
//   final String description;
//   final bool isFavoriteItem;

//   const CharacterCardItem({
//     super.key,
//     required this.id,
//     required this.avatarUrl,
//     required this.name,
//     required this.timeAgo,
//     required this.description,
//     required this.isFavoriteItem,
//   });

//   @override
//   State<CharacterCardItem> createState() => _CharacterCardItemState();
// }

// class _CharacterCardItemState extends State<CharacterCardItem> {
//   bool _isFavoritedFromDb = false;

//   @override
//   void initState() {
//     // "widget.isFavoriteItem is to know the item for HomeScreen or FavoritesSreen"
//     _isFavoritedFromDb = widget.isFavoriteItem;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100,
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey.shade300, width: 1),
//                 ),
//                 child: SizedBox(
//                   width: 75,
//                   height: double.infinity,
//                   child: widget.avatarUrl.isNotEmpty
//                       ? CachedNetworkImage(
//                           imageUrl: widget.avatarUrl,
//                           fit: BoxFit.cover,
//                           placeholder: (context, url) => Container(
//                             color: Colors.grey.shade200,
//                             child: const Center(
//                               child: CircularProgressIndicator(
//                                 strokeWidth: 2.5,
//                                 valueColor:
//                                     AlwaysStoppedAnimation<Color>(Colors.grey),
//                               ),
//                             ),
//                           ),
//                           errorWidget: (context, url, error) => Container(
//                             color: Colors.deepPurple.shade400,
//                             child: const Icon(
//                               Icons.camera_alt,
//                               color: Colors.white,
//                               size: 28,
//                             ),
//                           ),
//                           // fade in for smooth loading
//                           fadeInDuration: const Duration(milliseconds: 300),
//                         )
//                       : Container(
//                           color: Colors.deepPurple.shade400,
//                           child: const Icon(
//                             Icons.camera_alt,
//                             color: Colors.white,
//                             size: 28,
//                           ),
//                         ),
//                 ),
//               )),

//           const SizedBox(width: 16),

//           // Main content
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         widget.name,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 16,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     BlocSelector<FavoritesBloc, FavoritesState, bool>(
//                       selector: (state) {
//                         return state.favorites[widget.id] ?? false;
//                       },
//                       builder: (context, isFav) {
//                         return IconButton(
//                           onPressed: () {
//                             setState(() {
//                               _isFavoritedFromDb = !_isFavoritedFromDb;
//                             });
//                             context.read<FavoritesBloc>().add(
//                                   ToggleFavoriteEvent(
//                                     FavoriteCharacter(
//                                       id: widget.id,
//                                       name: widget.name,
//                                       image: widget.avatarUrl,
//                                       image: widget.s,
//                                       image: widget.avatarUrl,
//                                     ),
//                                   ),
//                                 );
//                           },
//                           icon: Icon(
//                             _isFavoritedFromDb
//                                 ? Icons.favorite
//                                 : Icons.favorite_border,
//                             color: _isFavoritedFromDb
//                                 ? Colors.redAccent.shade400
//                                 : const Color.fromARGB(255, 104, 99, 99),
//                             size: 28,
//                           ),
//                           padding: EdgeInsets.zero,
//                           constraints: const BoxConstraints(),
//                           tooltip: _isFavoritedFromDb
//                               ? 'Remove from favorites'
//                               : 'Add to favorites',
//                         );
//                       },
//                     ),
//                   ],
//                 ),

//                 const Spacer(),

//                 // Description
//                 Text(
//                   widget.description,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     height: 1.35,
//                   ),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
