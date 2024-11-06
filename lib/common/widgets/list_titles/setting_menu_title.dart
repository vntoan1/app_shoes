import 'package:flutter/material.dart';
import 'package:sport_shoes_store/utils/constants/colors.dart';
class SettingMenuTitle extends StatelessWidget {
  const SettingMenuTitle({super.key, required this.icon, required this.title, required this.subTitle, this.trailing, this.onTap});
  final IconData icon;
  final String title, subTitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 28, color: ColorApp.blue02,),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium,),
      subtitle: Text(subTitle, style: Theme.of(context).textTheme.labelMedium,),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
