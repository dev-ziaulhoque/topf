import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../../data/services/notificaiton_manager.dart';

class NotificationSettingView extends StatefulWidget {
  const NotificationSettingView({Key? key}) : super(key: key);

  @override
  State<NotificationSettingView> createState() =>
      _NotificationSettingViewState();
}

class _NotificationSettingViewState extends State<NotificationSettingView> {
  final NotificationManager _notificationManager = NotificationManager();
  final AudioPlayer _audioPlayer = AudioPlayer();
  String _selectedSound = 'love_it_heart_1';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCurrentSound();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _loadCurrentSound() async {
    final sound = await _notificationManager.getNotificationSound();
    setState(() {
      _selectedSound = sound;
      _isLoading = false;
    });
  }

  Future<void> _playSound(String soundKey) async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource('sounds/$soundKey.mp3'));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error playing sound: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _selectSound(String soundKey) async {
    setState(() {
      _selectedSound = soundKey;
    });
    await _notificationManager.saveNotificationSound(soundKey);
    await _playSound(soundKey);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Notification sound changed to ${_notificationManager.availableSounds[soundKey]}'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Select Notification Sound',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ..._notificationManager.availableSounds.entries.map((entry) {
            return ListTile(
              leading: Icon(
                _selectedSound == entry.key
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: _selectedSound == entry.key
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              title: Text(entry.value),
              trailing: IconButton(
                icon: const Icon(Icons.play_arrow),
                onPressed: () => _playSound(entry.key),
                tooltip: 'Preview sound',
              ),
              onTap: () => _selectSound(entry.key),
              selected: _selectedSound == entry.key,
            );
          }).toList(),
          const Divider(height: 32),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () async {
                await _notificationManager.showNotification(
                  id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
                  title: 'Test Notification',
                  body: 'This is how your notification will sound',
                );
              },
              icon: const Icon(Icons.notifications_active),
              label: const Text('Test Notification'),
            ),
          ),
        ],
      ),
    );
  }
}