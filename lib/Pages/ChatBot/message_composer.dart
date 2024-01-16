// import 'package:eva_icons_flutter/eva_icons_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:medappfv/components/Themes/Sizing.dart';

// class MessageComposer extends StatelessWidget {
//   MessageComposer({
//     required this.onSubmitted,
//     required this.awaitingResponse,
//     Key? key,
//   }) : super(key: key);

//   final TextEditingController _messageController = TextEditingController();

//   final void Function(String) onSubmitted;
//   final bool awaitingResponse;

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig.init(context);
//     return Container(
//       decoration: const BoxDecoration(
//         color: Colors.transparent,
//       ),
//       child: SafeArea(
//         child: Row(
//           children: [
//             Expanded(
//               child: !awaitingResponse
//                   ? Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: Theme.of(context)
//                             .colorScheme
//                             .primary, // Input field background color
//                       ),
//                       child: TextField(
//                         style: Theme.of(context).textTheme.headlineSmall,
//                         cursorColor:
//                             Theme.of(context).textTheme.headlineSmall?.color,
//                         controller: _messageController,
//                         onSubmitted: onSubmitted,
//                         decoration: InputDecoration(
//                           hintText: 'Write Your Question Here...',
//                           hintStyle: TextStyle(
//                               color: Theme.of(context)
//                                   .textTheme
//                                   .headlineSmall!
//                                   .color,
//                               fontSize: 14),
//                           prefixIcon: const Icon(EvaIcons.search),
//                           prefixIconColor: Theme.of(context).iconTheme.color,
//                           border: InputBorder.none,
//                           contentPadding: EdgeInsets.symmetric(
//                               vertical: SizeConfig.pointFifteenHeight),
//                         ),
//                       ),
//                     )
//                   : Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                           height: SizeConfig.screenHeight * 0.03,
//                           width: SizeConfig.screenHeight * 0.03,
//                           child: const CircularProgressIndicator(),
//                         ),
//                         Padding(
//                           padding:
//                               EdgeInsets.all(SizeConfig.screenHeight * 0.015),
//                           child: Text(
//                             'Getting An Answer Right Away!',
//                             style: TextStyle(
//                                 color: Theme.of(context)
//                                     .textTheme
//                                     .titleSmall!
//                                     .color),
//                           ),
//                         ),
//                       ],
//                     ),
//             ),
//             IconButton(
//               onPressed: !awaitingResponse
//                   ? () => onSubmitted(_messageController.text)
//                   : null,
//               icon: Icon(
//                 Icons.send,
//                 color: Colors.grey.shade500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
