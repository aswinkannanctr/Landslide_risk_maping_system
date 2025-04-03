// import 'package:flutter/material.dart';
// import 'package:landslide_guardian/pages/google_map_page.dart';

// class MapPage extends StatelessWidget {
//   const MapPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             // Map Image covering the whole screen
//             Container(
              
//               width: double.infinity,
//               height: double.infinity,
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: NetworkImage('https://placeholder-url.com/world-map.jpg'),
//                   // Note: In a real application, you would want to use a local asset
//                   // or an actual map service like Google Maps
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
            
//             // Home Icon Button at top left
//             Positioned(
//               top: 24,
//               left: 24,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 8,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: IconButton(
//                   icon: const Icon(
//                     Icons.home,
//                     color: Colors.black,
//                     size: 28,
//                   ),
//                   onPressed: () {
//                     Navigator.push(context,MaterialPageRoute(builder: (context)=>GoogleMapFlutter()));
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }