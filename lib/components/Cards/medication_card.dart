import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:medappfv/components/Themes/Sizing.dart';

class MedCard extends StatefulWidget {
  final Function(String) onDelete;
  final Function(String) onArchive;
  final bool isTaken; // Add a parameter to accept isTaken value

  final String medName;
  final String dosage;
  final String medId;

  const MedCard({
    super.key,
    required this.medId,
    required this.medName,
    required this.dosage,
    required this.onDelete,
    required this.onArchive,
    required this.isTaken,
  });

  @override
  State<MedCard> createState() => _MedCardState();
}

class _MedCardState extends State<MedCard> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.medId),
      onDismissed: (_) {},
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          final bool del = await showDialog(
            context: context,
            builder: (BuildContext ctx) {
              return AlertDialog(
                title: const Text('Confirm Deletion'),
                content: const Text(
                    'Are you sure you want to delete this medication?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      widget.onDelete(widget.medId);

                      Navigator.pop(ctx); // Close dialog without deletion
                    },
                    child: const Text('Delete'),
                  ),
                ],
              );
            },
          );
          return del;
        } else {
          final bool arc = await showDialog(
            context: context,
            builder: (BuildContext ctx) {
              return AlertDialog(
                content: const Text('Did you take the medication?'),
                actions: [
                  TextButton(
                    onPressed: () =>
                        Navigator.pop(ctx), // Close dialog without deletion
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      widget.onArchive(widget.medId);
                      Navigator.pop(ctx); // Close dialog without deletion
                    },
                    child: const Text('Yes'),
                  ),
                ],
              );
            },
          );
          return arc;
        }
      },
      background: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24), color: Colors.blue),
        alignment: Alignment.center,
        padding: EdgeInsets.only(right: SizeConfig.screenWidth * 0.04),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      secondaryBackground: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24), color: Colors.red),
        alignment: Alignment.center,
        padding: EdgeInsets.only(right: SizeConfig.screenWidth * 0.04),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Stack(
        children: [
          Container(
            height: SizeConfig.screenHeight * 0.15,
            width: SizeConfig.screenWidth * 0.85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border:
                  Border.all(color: Theme.of(context).colorScheme.secondary),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.04),
                  child: Image.asset(
                    'lib/icons/hemoglobin.png',
                    width: SizeConfig.screenWidth * 0.15,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        widget.medName,
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.titleSmall!.color,
                            fontWeight: FontWeight.w500,
                            fontSize: 24),
                        maxLines: 1,
                      ),
                      AutoSizeText(
                        '${widget.dosage} pill/s',
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.titleSmall!.color,
                            fontWeight: FontWeight.w500,
                            fontSize: 24),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: SizeConfig.screenWidth * 0.075),
                Padding(
                  padding:
                      EdgeInsets.only(right: SizeConfig.screenWidth * 0.02),
                  child: AutoSizeText(
                    '${widget.dosage} pill/s',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.titleSmall!.color,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
