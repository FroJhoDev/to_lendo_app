import 'package:packages/packages.dart';

/// {@template app_icons}
/// Centralized icon definitions using Hugeicons.
///
/// This class maps semantic icons used across the app to
/// specific Hugeicons variants to keep the visual language
/// consistent and make it easier to change in the future.
/// {@endtemplate}
sealed class AppIcons {
  AppIcons._();

  /// Icon used as the main application logo.
  static const appLogo = HugeIcons.strokeRoundedBookOpen01;

  /// Icon used to represent cloud synchronization.
  static const cloudSync = HugeIcons.strokeRoundedCloudServer;

  /// Icon used for back navigation actions.
  static const back = HugeIcons.strokeRoundedArrowLeft01;

  /// Icon used for overflow or more options menus.
  static const more = HugeIcons.strokeRoundedMenu01;

  /// Icon used for add or create actions.
  static const add = HugeIcons.strokeRoundedAdd01;

  /// Icon used for email fields and actions.
  static const email = HugeIcons.strokeRoundedMail01;

  /// Icon used for password fields and security actions.
  static const password = HugeIcons.strokeRoundedLockPassword;

  /// Icon used to represent the user or profile.
  static const user = HugeIcons.strokeRoundedUser;

  /// Icon used to represent a generic book.
  static const book = HugeIcons.strokeRoundedBookOpen01;

  /// Icon used for outlined book representations.
  static const bookOutlined = HugeIcons.strokeRoundedBookOpen02;

  /// Icon used to represent bookmarks or completed items.
  static const bookmark = HugeIcons.strokeRoundedBookmark01;

  /// Icon used to represent streaks or reading activity.
  static const fire = HugeIcons.strokeRoundedFire;

  /// Icon used for filled star ratings.
  static const starFilled = HugeIcons.strokeRoundedStar;

  /// Icon used for half star ratings.
  static const starHalf = HugeIcons.strokeRoundedStarHalf;

  /// Icon used for outlined star ratings.
  static const starOutlined = HugeIcons.strokeRoundedStar;

  /// Icon used when content is visible (password shown).
  static const visibilityOn = HugeIcons.strokeRoundedView;

  /// Icon used when content is hidden (password obscured).
  static const visibilityOff = HugeIcons.strokeRoundedViewOff;

  /// Icon used for add page actions.
  static const addPage = HugeIcons.strokeRoundedBookBookmark02;
}
