import 'dart:io';

class AppAssets {
  static const applicationLogoPng = 'assets/images/application/applicationLogo.png';
  static const applicationSplash = 'assets/images/application/applicationSplash.png';
  static const allowLocation = 'assets/images/allow_location/allow_location.svg';
  static const carIcon = 'assets/images/icons/car_icon.png';
  static const closeIcon = 'assets/images/icons/close_icon.png';

  static const flagUK = 'assets/images/flags/flagUK.png';
  static const flagBA = 'assets/images/flags/flagBA.png';

  static const legalEntity = 'assets/images/icons/legal_entity_icon.png';

  static const mapPin = 'assets/images/map/mapPin.png';
  static const mapPin2x = 'assets/images/map/mapPin2x.png';
  static String get mapPinByPlatform => Platform.isIOS ? mapPin : mapPin2x;

  static const onboarding1 = 'assets/images/onboarding/onBoarding1.jpg';
  static const onboarding2 = 'assets/images/onboarding/onBoarding2.jpg';
  static const onboarding3 = 'assets/images/onboarding/onBoarding3.jpg';

  static const physicalEntity = 'assets/images/icons/physical_entity_icon.png';
  static const placeholderPhoto = 'assets/images/placeholders/placeholderPhoto.png';
  static const placeholderNoContent = 'assets/images/placeholders/placeholderNoContent.png';

  static const googleMapsMapStyle = 'assets/other/googleMapsMapStyle.txt';

  static const registrationImage = 'assets/images/placeholders/registration.png';
  static const resetPasswordImage = 'assets/images/reset_password/change_password.png';
  static const resetPasswordMailImage = 'assets/images/reset_password/verification_email.png';
  static const successPasswordChange = 'assets/images/reset_password/success_password_change.png';

  static const driverLicense = 'assets/images/application/driverLicense.png';

  static const successRegistration = 'assets/images/register/success_img.svg';
}
