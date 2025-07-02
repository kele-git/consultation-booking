import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tpg_assignment/utils/auth_helper.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  String studentIdFilter = '';
  DateTimeRange? dateRange;

  Stream<QuerySnapshot> getBookingsStream() {
    Query query = FirebaseFirestore.instance.collection('bookings');

    if (studentIdFilter.isNotEmpty) {
      query = query.where('studentId', isEqualTo: studentIdFilter);
    }

    if (dateRange != null) {
      query = query
          .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(dateRange!.start))
          .where('date', isLessThanOrEqualTo: Timestamp.fromDate(dateRange!.end));
    }

    return query.orderBy('date', descending: false).snapshots();
  }

  void _deleteBooking(String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Booking'),
        content: const Text('Are you sure you want to delete this booking?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete')),
        ],
      ),
    );

    if (confirm ?? false) {
      await FirebaseFirestore.instance.collection('bookings').doc(id).delete();
    }
  }

  void _selectDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        dateRange = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: const Color.fromARGB(255, 51, 30, 145),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => AuthHelper.logout(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Filter by Student ID',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (val) => setState(() => studentIdFilter = val),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.date_range),
              label: Text(dateRange == null
                  ? 'Filter by Date Range'
                  : '${dateRange!.start.toLocal()} - ${dateRange!.end.toLocal()}'),
              onPressed: _selectDateRange,
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: getBookingsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final docs = snapshot.data?.docs ?? [];

                if (docs.isEmpty) {
                  return const Center(child: Text('No bookings found.'));
                }

                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data() as Map<String, dynamic>;

                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: ListTile(
                        title: Text("📌 Topic: ${data['topic'] ?? 'No topic'}"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("🧑 Student ID: ${data['studentId'] ?? 'Unknown'}"),
                            Text("📅 Date: ${data['date']?.toDate()?.toLocal().toString().split(' ')[0] ?? 'N/A'}"),
                            Text("⏰ Time: ${data['time'] ?? 'N/A'}"),
                            Text("📝 Description: ${data['description'] ?? 'None'}"),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteBooking(docs[index].id),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}