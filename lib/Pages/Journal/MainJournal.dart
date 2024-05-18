import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:medappfv/Pages/Journal/DBhelper.dart';
import 'package:medappfv/components/Themes/Sizing.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Journal extends StatefulWidget {
  const Journal({super.key});

  @override
  State<Journal> createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  List<Map<String, dynamic>> _journalEntries = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _loadJournalEntries();
  }

  Future<void> _loadJournalEntries() async {
    User? user = _auth.currentUser;
    if (user != null) {
      List<Map<String, dynamic>> entries =
          await DatabaseHelper().getEntries(user.uid);
      setState(() {
        _journalEntries = entries;
      });
    }
  }

  Future<void> _addJournalEntry(
      String date, String time, String content) async {
    User? user = _auth.currentUser;
    if (user != null) {
      Map<String, String> entry = {
        'userId': user.uid,
        'date': date,
        'time': time,
        'content': content
      };
      await DatabaseHelper().insertEntry(entry);
      _loadJournalEntries();
    }
  }

  Future<void> _deleteJournalEntry(int id) async {
    await DatabaseHelper().deleteEntry(id);
    _loadJournalEntries();
  }

  void _showAddEntryDialog() {
    final TextEditingController _entryController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AutoSizeText(
                  'Add Journal Entry',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  minFontSize: 12,
                  maxFontSize: 18,
                ),
                SizedBox(height: SizeConfig.pointThreeHeight),
                TextField(
                  controller: _entryController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Write your journal entry here...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.pointThreeHeight),
                ElevatedButton(
                  onPressed: () {
                    if (_entryController.text.isNotEmpty) {
                      final now = DateTime.now();
                      _addJournalEntry(
                        DateFormat('dd MMM yyyy').format(now),
                        DateFormat('hh:mm a').format(now),
                        _entryController.text,
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: AutoSizeText('Add Entry'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showFullEntryDialog(String date, String time, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AutoSizeText(
                  date,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  minFontSize: 12,
                  maxFontSize: 18,
                ),
                AutoSizeText(
                  time,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  minFontSize: 12,
                  maxFontSize: 16,
                ),
                SizedBox(height: SizeConfig.pointThreeHeight),
                AutoSizeText(
                  content,
                  style: TextStyle(fontSize: 16),
                  minFontSize: 12,
                  maxFontSize: 16,
                ),
                SizedBox(height: SizeConfig.pointThreeHeight),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: AutoSizeText('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          'Journal',
          maxLines: 1,
          minFontSize: 12,
          maxFontSize: 18,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AutoSizeText(
                '"The best way to predict the future is to create it."',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                minFontSize: 12,
                maxFontSize: 16,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _journalEntries.length,
                itemBuilder: (context, index) {
                  final entry = _journalEntries[index];
                  return Dismissible(
                    key: Key(entry['id'].toString()),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      _deleteJournalEntry(entry['id']);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: AutoSizeText('Journal entry deleted'),
                        ),
                      );
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        title: AutoSizeText(
                          entry['date']!,
                          maxLines: 1,
                          minFontSize: 12,
                          maxFontSize: 18,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              entry['time']!,
                              maxLines: 1,
                              minFontSize: 12,
                              maxFontSize: 16,
                            ),
                            AutoSizeText(
                              entry['content']!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              minFontSize: 12,
                              maxFontSize: 16,
                            ),
                          ],
                        ),
                        onTap: () {
                          _showFullEntryDialog(entry['date']!, entry['time']!,
                              entry['content']!);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddEntryDialog,
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
