import 'dart:async';
import 'package:flutter/material.dart';
import '../data/demo_data.dart';
import '../data/local_repository.dart';

enum PageId {
  welcome, login, phone, verification, enableNotifications, inviteFriends,
  home, following, discover, comments, live, shareLive, messages, chat, friends,
  channel, broadcast, notifications, profile, editProfile, userPortrait,
  userGallery, postDetails, eventDetails, videoCall, eventMap, addLocation,
  searchMap, createEvent, calendar,
}

class AppState extends ChangeNotifier {
  AppState({this.repository, PageId initialPage = PageId.welcome}) : page = initialPage {
    final saved = repository?.load() ?? {};
    name = saved['name'] as String? ?? 'Connor Davis';
    email = saved['email'] as String? ?? 'darrell_bailey@gmail.com';
    phone = saved['phone'] as String? ?? '+65 39879 343';
    gender = saved['gender'] as String? ?? 'Female';
    birthday = saved['birthday'] as String? ?? '16/04/1988';
    notificationsEnabled = saved['notifications'] as bool? ?? false;
    following.addAll(List<String>.from(saved['following'] as List? ?? ['Norman Henry']));
    liked.addAll(List<String>.from(saved['liked'] as List? ?? []));
    messages.addAll(List<String>.from(saved['messages'] as List? ?? []));
    comments.addAll(List<String>.from(saved['comments'] as List? ?? []));
    interested = saved['interested'] as bool? ?? false;
    for (final json in saved['events'] as List? ?? []) {
      createdEvents.add(SocialEvent.fromJson(Map<String, dynamic>.from(json as Map)));
    }
  }
  final LocalRepository? repository;
  PageId page;
  final List<PageId> _history = [];
  late String name, email, phone, gender, birthday;
  String verificationPhone = '905070017';
  String selectedPlace = '523 Edwin Parkway Apt. 026';
  String chatName = 'Rosalie Gray';
  String chatAvatar = '0:1017';
  bool notificationsEnabled = false, interested = false;
  final following = <String>{};
  final liked = <String>{};
  final messages = <String>[];
  final comments = <String>[];
  final createdEvents = <SocialEvent>[];
  List<SocialEvent> get allEvents => [...createdEvents, ...events];

  void go(PageId next, {bool replace = false}) {
    if (next == page) return;
    if (replace) { _history.clear(); } else { _history.add(page); }
    page = next;
    notifyListeners();
  }
  void back() {
    page = _history.isEmpty ? PageId.home : _history.removeLast();
    notifyListeners();
  }
  void openChat(String name, String avatar) {
    chatName = name; chatAvatar = avatar; go(PageId.chat);
  }
  void toggleFollow(String name) { following.contains(name) ? following.remove(name) : following.add(name); commit(); }
  void toggleLike(String id) { liked.contains(id) ? liked.remove(id) : liked.add(id); commit(); }
  void sendMessage(String value) { if (value.trim().isEmpty) return; messages.add(value.trim()); commit(); }
  void addComment(String value) { if (value.trim().isEmpty) return; comments.add(value.trim()); commit(); }
  void updateProfile({required String name, required String email, required String phone, required String gender, required String birthday}) {
    this.name = name; this.email = email; this.phone = phone; this.gender = gender; this.birthday = birthday; commit();
  }
  void addEvent(SocialEvent event) { createdEvents.insert(0, event); commit(); go(PageId.eventMap); }
  void commit() {
    unawaited(repository?.save({
      'name': name, 'email': email, 'phone': phone, 'gender': gender, 'birthday': birthday,
      'notifications': notificationsEnabled, 'following': following.toList(), 'liked': liked.toList(),
      'messages': messages, 'comments': comments, 'interested': interested,
      'events': createdEvents.map((e) => e.toJson()).toList(),
    }));
    notifyListeners();
  }
}

class AppScope extends InheritedNotifier<AppState> {
  const AppScope({required AppState state, required super.child, super.key}) : super(notifier: state);
  static AppState of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<AppScope>()!.notifier!;
}
