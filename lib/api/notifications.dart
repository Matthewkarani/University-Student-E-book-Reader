import 'package:awesome_notifications/awesome_notifications.dart';

import '../util/utilities.dart';
Future<void> createReadingReminderNotification() async {
  //Here we are calling the AwesomeNotifications object and await the call
  //CreateNotifications method has a required content parameter where
  // we can provide a notificationsContent object content
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'basic_channel',
      title: '${Emojis.activites_confetti_ball} It\s time to read!',
      body: 'Engineer Matthew the time to study is now!, your future depends'
            ' on it',
      //make the Persona(Engineer) and user Name, be a dynamic variable
      notificationLayout: NotificationLayout.BigPicture,
    ),
  );


}

Future<void> createWaterReminderNotification(
    NotificationWeekAndTime notificationSchedule) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'scheduled_channel',
      title: '${Emojis.wheater_droplet} Add some water to your plant!',
      body: 'Water your plant regularly to keep it healthy.',
      notificationLayout: NotificationLayout.Default,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'MARK_DONE',
        label: 'Mark Done',
      )
    ],
    schedule: NotificationCalendar(
      weekday: notificationSchedule.dayOfTheWeek,
      hour: notificationSchedule.timeOfDay.hour,
      minute: notificationSchedule.timeOfDay.minute,
      second: 0,
      millisecond: 0,
    ),
  );
}
Future<void> cancelScheduledNotifications() async {
  await AwesomeNotifications().cancelAllSchedules();
}