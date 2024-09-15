import 'package:flutter/material.dart';
import 'package:student_grivence/api_service.dart';

class NewEvent extends StatefulWidget {
  const NewEvent({super.key});

  @override
  _NewEventState createState() => _NewEventState();
}

class _NewEventState extends State<NewEvent> {
  final _eventNameController = TextEditingController();
  final _eventDescriptionController = TextEditingController();
  final _eventLocationController = TextEditingController();
  final _eventDateController = TextEditingController();
  final _eventTimeController = TextEditingController();
  final ApiService _apiService = ApiService();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _submitEvent() async {
    String eventName = _eventNameController.text;
    String description = _eventDescriptionController.text;
    String location = _eventLocationController.text;
    String date = _eventDateController.text;
    String time = _eventTimeController.text;

    if (eventName.isEmpty ||
        description.isEmpty ||
        location.isEmpty ||
        date.isEmpty ||
        time.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all the fields")),
      );
      return;
    }

    Map<String, dynamic> eventData = {
      'name': eventName,
      'description': description,
      'location': location,
      'date': date,
      'time': time,
    };

    try {
      final response = await _apiService.createEvent(eventData);

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Event Created Successfully")),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Failed to create event. Please try again later.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _eventDateController.text =
            "${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
        _eventTimeController.text = _selectedTime!.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Event'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _eventNameController,
              decoration: const InputDecoration(labelText: 'Event Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _eventDescriptionController,
              decoration: const InputDecoration(labelText: 'Event Description'),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _eventLocationController,
              decoration: const InputDecoration(labelText: 'Event Location'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _eventDateController,
              decoration:
                  const InputDecoration(labelText: 'Event Date (yyyy-mm-dd)'),
              onTap: () => _selectDate(context),
              readOnly: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _eventTimeController,
              decoration:
                  const InputDecoration(labelText: 'Event Time (hh:mm)'),
              onTap: () => _selectTime(context),
              readOnly: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitEvent,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Create Event'),
            ),
          ],
        ),
      ),
    );
  }
}
