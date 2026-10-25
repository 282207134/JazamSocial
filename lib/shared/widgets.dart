import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/app_state.dart';
import '../core/design.dart';
import '../data/assets.dart';
export '../core/app_state.dart';
export '../core/design.dart';
export '../data/demo_data.dart';

void toast(BuildContext context, String text) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text), behavior: SnackBarBehavior.floating, duration: const Duration(seconds: 2)));

class Photo extends StatelessWidget {
  const Photo(this.id, {this.width, this.height, this.radius = 0, this.fit = BoxFit.cover, this.alignment = Alignment.center, super.key});
  final String id;
  final double? width, height;
  final double radius;
  final BoxFit fit;
  final Alignment alignment;
  @override
  Widget build(BuildContext context) => ClipRRect(borderRadius: BorderRadius.circular(radius), child: Image.asset(designAssets[id] ?? id, width: width, height: height, fit: fit, alignment: alignment, gaplessPlayback: true));
}

class Avatar extends StatelessWidget {
  const Avatar(this.id, {this.size = 50, this.ring = false, this.online = false, super.key});
  final String id;
  final double size;
  final bool ring, online;
  @override
  Widget build(BuildContext context) => SizedBox(width: size + (ring ? 6 : 0), height: size + (ring ? 6 : 0), child: Stack(clipBehavior: Clip.none, children: [
    Container(padding: EdgeInsets.all(ring ? 2 : 0), decoration: BoxDecoration(shape: BoxShape.circle, border: ring ? Border.all(color: Jazam.pink, width: 1.5) : null), child: ClipOval(child: Photo(id, width: size, height: size))),
    if (online) Positioned(right: 0, bottom: 0, child: Container(width: 13, height: 13, decoration: BoxDecoration(color: const Color(0xFF7ED321), shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)))),
  ]));
}

class AppFrame extends StatelessWidget {
  const AppFrame({required this.child, this.title, this.actions, this.bottom, this.tab, this.background = Colors.white, this.back = true, this.fullBleed = false, this.dark = false, super.key});
  final Widget child;
  final String? title;
  final List<Widget>? actions;
  final Widget? bottom;
  final int? tab;
  final Color background;
  final bool back, fullBleed, dark;
  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(value: dark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark, child: Scaffold(
      backgroundColor: background,
      extendBodyBehindAppBar: fullBleed,
      appBar: title == null ? null : AppBar(
        title: Text(title!), backgroundColor: background,
        leading: back ? IconButton(tooltip: 'Back', onPressed: state.back, icon: const Icon(CupertinoIcons.chevron_left, size: 24)) : null,
        automaticallyImplyLeading: false, actions: actions,
      ),
      body: fullBleed ? child : SafeArea(top: title == null, bottom: false, child: child),
      bottomNavigationBar: bottom ?? (tab == null ? null : BottomTabs(selected: tab!)),
    ));
  }
}

class BottomTabs extends StatelessWidget {
  const BottomTabs({required this.selected, super.key});
  final int selected;
  @override
  Widget build(BuildContext context) {
    const pages = [PageId.home, PageId.channel, PageId.messages, PageId.notifications, PageId.profile];
    const icons = [CupertinoIcons.house, CupertinoIcons.tv, CupertinoIcons.chat_bubble_text, CupertinoIcons.bell, CupertinoIcons.person_crop_circle];
    const labels = ['Home', 'Streams', 'Messages', 'Notifications', 'Profiles'];
    return Container(decoration: const BoxDecoration(color: Jazam.background, border: Border(top: BorderSide(color: Color(0xFFE1E3E8), width: .6))), child: SafeArea(top: false, child: SizedBox(height: 60, child: Row(children: List.generate(5, (i) => Expanded(child: InkWell(
      key: ValueKey('tab-${labels[i]}'), onTap: () => AppScope.of(context).go(pages[i], replace: true),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icons[i], size: 23, color: selected == i ? Jazam.pink : Jazam.muted), const SizedBox(height: 4), Text(labels[i], style: TextStyle(fontSize: 10, color: selected == i ? Jazam.pink : Jazam.muted))]),
    )))))));
  }
}

class SearchHeader extends StatelessWidget {
  const SearchHeader({this.onChanged, this.onSearch, this.onAdd, this.hint = 'Search', super.key});
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSearch, onAdd;
  final String hint;
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.fromLTRB(20, 8, 20, 16), child: Row(children: [
    Expanded(child: SizedBox(height: 38, child: TextField(onChanged: onChanged, onTap: onSearch, readOnly: onSearch != null, style: const TextStyle(fontSize: 14), decoration: InputDecoration(hintText: hint, prefixIcon: const Icon(CupertinoIcons.search, size: 21, color: Jazam.muted), contentPadding: EdgeInsets.zero, border: OutlineInputBorder(borderRadius: BorderRadius.circular(22), borderSide: BorderSide.none))))),
    if (onAdd != null) ...[const SizedBox(width: 18), InkWell(onTap: onAdd, borderRadius: BorderRadius.circular(24), child: Container(width: 38, height: 38, decoration: const BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [Color(0xFFFF9273), Jazam.pink], begin: Alignment.topLeft, end: Alignment.bottomRight), boxShadow: [BoxShadow(color: Color(0x33FF2D55), blurRadius: 8, offset: Offset(0, 4))]), child: const Icon(CupertinoIcons.add, color: Colors.white, size: 30)))],
  ]));
}

class FollowButton extends StatelessWidget {
  const FollowButton(this.name, {super.key});
  final String name;
  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context); final following = state.following.contains(name);
    return SizedBox(height: 29, child: OutlinedButton(onPressed: () => state.toggleFollow(name), style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 13), backgroundColor: following ? Jazam.pink : Colors.white, foregroundColor: following ? Colors.white : Jazam.pink, side: const BorderSide(color: Jazam.pink), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))), child: Text(following ? 'Following' : 'Follow', style: const TextStyle(fontSize: 13))));
  }
}

class Heading extends StatelessWidget {
  const Heading(this.title, {this.action, this.onTap, super.key});
  final String title;
  final String? action;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.fromLTRB(15, 14, 15, 15), child: Row(children: [Expanded(child: Text(title, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700, height: 1.15))), if(action != null) TextButton(onPressed: onTap, child: Text(action!))]));
}

class PersonRow extends StatelessWidget {
  const PersonRow(this.person, {this.onTap, this.trailing, super.key});
  final Person person;
  final VoidCallback? onTap;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) => ListTile(contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8), leading: Avatar(person.image), title: Text(person.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)), subtitle: Text(person.detail, style: const TextStyle(color: Jazam.muted, fontSize: 13)), trailing: trailing, onTap: onTap ?? () => AppScope.of(context).go(PageId.userGallery));
}

class Composer extends StatefulWidget {
  const Composer({required this.onSend, this.hint = 'Write a comment ...', this.attach = false, super.key});
  final ValueChanged<String> onSend;
  final String hint;
  final bool attach;
  @override
  State<Composer> createState() => _ComposerState();
}
class _ComposerState extends State<Composer> {
  final controller = TextEditingController();
  @override void dispose() { controller.dispose(); super.dispose(); }
  void send() { if(controller.text.trim().isEmpty) return; widget.onSend(controller.text); controller.clear(); FocusScope.of(context).unfocus(); }
  @override Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), decoration: const BoxDecoration(color: Jazam.background, border: Border(top: BorderSide(color: Color(0xFFE8EAF0)))) , child: SafeArea(top: false, child: Row(children: [
    if(widget.attach) IconButton(tooltip: 'Attach photo', onPressed: () => showPhoto(context, '0:1009'), icon: const Icon(CupertinoIcons.paperclip, size: 22)),
    Expanded(child: TextField(key: const ValueKey('composer'), controller: controller, onSubmitted: (_) => send(), textInputAction: TextInputAction.send, decoration: InputDecoration(hintText: widget.hint, fillColor: Colors.white, isDense: true, contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10), border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: const BorderSide(color: Color(0xFFE7E9EF))))),
    IconButton(tooltip: 'Send', onPressed: send, icon: const Icon(CupertinoIcons.paperplane_fill, color: Jazam.pink, size: 24)),
  ])));
}

void showPhoto(BuildContext context, String id) => showDialog<void>(context: context, builder: (context) => Dialog(backgroundColor: Colors.transparent, child: Stack(children: [InteractiveViewer(child: Photo(id, radius: 12)), Positioned(right: 4, top: 4, child: CircleAvatar(backgroundColor: Colors.black54, child: IconButton(tooltip: 'Close photo', onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, color: Colors.white))))])));

void showCreateMenu(BuildContext context) {
  final state = AppScope.of(context);
  showModalBottomSheet<void>(context: context, showDragHandle: true, builder: (sheet) => SafeArea(child: Column(mainAxisSize: MainAxisSize.min, children: [
    for(final item in [(CupertinoIcons.video_camera, 'Start live broadcast', PageId.broadcast), (CupertinoIcons.calendar_badge_plus, 'Create an event', PageId.createEvent), (CupertinoIcons.map, 'Explore nearby events', PageId.eventMap), (CupertinoIcons.calendar, 'My calendar', PageId.calendar)])
      ListTile(leading: Icon(item.$1, color: Jazam.pink), title: Text(item.$2), trailing: const Icon(CupertinoIcons.chevron_right, size: 17), onTap: () { Navigator.pop(sheet); state.go(item.$3); }),
    const SizedBox(height: 12),
  ])));
}
