package react.native.push_notification;

@:jsRequire('react-native-push-notification')
extern class PushNotification {
	static function configure(config:Config):Void;
	static function requestPermissions():Void;
	static function localNotification(data:LocalNotification):Void;
	static function localNotificationSchedule(data:ScheduledLocalNotification):Void;
	static function getDeliveredNotifications(cb:Array<DeliveredNotification>->Void):Void;
	static function removeDeliveredNotifications(arr:Array<Int>):Void;
	static function setApplicationIconBadgeNumber(v:Int):Void;
	#if android
	static function createChannel(config:ChannelConfig, ?cb:Bool->Void):Void; // (optional) callback returns whether the channel was created, false means it already existed.
	static function getChannels(cb:Array<String>->Void):Void;
	#end
}

typedef Config = {
	?onRegister:Token->Void,
	?onNotification:Notification->Void,
	?popInitialNotification:Bool,
	?requestPermissions:Bool,
	#if android
	?senderID:String,
	#else
	?permissions:{
		alert:Bool,
		badge:Bool,
		sound:Bool,
	}
	#end
}

#if android
typedef ChannelConfig = {
	channelId:String, // (required)
	channelName:String, // (required)
	?channelDescription:String, // (optional) default: undefined.
	?playSound:Bool, // (optional) default: true
	?soundName:String, // (optional) See `soundName` parameter of `localNotification` function
	?importance:ChannelImportance, // (optional) default: Importance.HIGH. Int value of the Android notification importance
	?vibrate:Bool // (optional) default: true. Creates the default vibration pattern if true.
}

enum abstract ChannelImportance(Int) to Int {
	var DEFAULT = 3;
	var HIGH =4;
	var LOW = 2;
	var MIN = 1;
	var NONE = 0;
}
#end

typedef Token = {
	final token:String;
	final os:TokenOS;
}

enum abstract TokenOS(String) to String {
	var ios;
	var android;
}

typedef Notification = {
	foreground:Bool,
	userInteraction:Bool,
	message:String,
	finish:FetchResult->Void,
	data:{}
}

enum abstract FetchResult(String) to String {
	var NewData = 'backgroundFetchResultNewData';
	var NoData = 'backgroundFetchResultNoData';
	var ResultFailed = 'backgroundFetchResultFailed';
}

typedef DeliveredNotification = {
	identifier:Int,
	title:String,
	body:{},
	?category:String,
	?userInfo:{},
}

typedef ScheduledLocalNotification = {
	> LocalNotification,
	date:Date,
}

typedef LocalNotification = {
	#if android
	channelId:String, // (required) channelId, if the channel doesn't exist, notification will not trigger.
	?ticker:String, // (optional)
	?showWhen:Bool, // (optional) default: true
	?autoCancel:Bool, // (optional) default: true
	?largeIcon:String, // (optional) default: "ic_launcher". Use "" for no large icon.
	?largeIconUrl:String, // (optional) default: undefined
	?smallIcon:String, // (optional) default: "ic_notification" with fallback for "ic_launcher". Use "" for default small icon.
	?bigText:String, // (optional) default: "message" prop
	?subText:String, // (optional) default: none
	?bigPictureUrl:String, // (optional) default: undefined
	?bigLargeIcon:String, // (optional) default: undefined
	?bigLargeIconUrl:String, // (optional) default: undefined
	?color:String, // (optional) default: system default
	?vibrate:Bool, // (optional) default: true
	vibration:Int, // vibration length in milliseconds, ignored if vibrate=false, default: 1000
	?tag:String, // (optional) add tag to message
	?group:String, // (optional) add group to message
	?roupSummary:Bool, // (optional) set this notification to be the group summary for a group of notifications, default: false
	?ongoing:Bool, // (optional) set whether this is an "ongoing" notification
	?priority:String, // (optional) set notification priority, default: high
	?visibility:String, // (optional) set notification visibility, default: private
	?ignoreInForeground:Bool, // (optional) if true, the notification will not be visible when the app is in the foreground (useful for parity with how iOS notifications appear). should be used in combine with `com.dieam.reactnativepushnotification.notification_foreground` setting
	?shortcutId:String, // (optional) If this notification is duplicative of a Launcher shortcut, sets the id of the shortcut, in case the Launcher wants to hide the shortcut, default undefined
	?onlyAlertOnce:Bool, // (optional) alert will open only once with sound and notify, default: false

	?when:Int, // (optional) Add a timestamp (Unix timestamp value in milliseconds) pertaining to the notification (usually the time the event occurred). For apps targeting Build.VERSION_CODES.N and above, this time is not shown anymore by default and must be opted into by using `showWhen`, default: null.
	?usesChronometer:Bool, // (optional) Show the `when` field as a stopwatch. Instead of presenting `when` as a timestamp, the notification will show an automatically updating display of the minutes and seconds since when. Useful when showing an elapsed time (like an ongoing phone call), default: false.
	?timeoutAfter:Int, // (optional) Specifies a duration in milliseconds after which this notification should be canceled, if it is not already canceled, default: null

	?messageId:String, // (optional) added as `message_id` to intent extras so opening push notification can find data stored by @react-native-firebase/messaging module.

	actions:Action, // (Android only) See the doc for notification actions to know more
	?invokeApp:Bool, // (optional) This enable click on actions to bring back the application to foreground or stay in background, default: true

	#else
	?category:String, // (optional) default: empty string
	?subtitle:String, // (optional) smaller title below notification title

	#end
	?id:Int, // (optional) Valid unique 32 bit integer specified as string. default: Autogenerated Unique ID
	?title:String, // (optional)
	message:String, // (required)
	?userInfo: {}, // (optional) default: {} (using null throws a JSON value '<null>' error)
	?playSound:Bool, // (optional) default: true
	?soundName:String, // (optional) Sound to play when the notification is shown. Value of 'default' plays the default sound. It can be set to a custom sound such as 'android.resource://com.xyz/raw/my_sound'. It will look for the 'my_sound' audio file in 'res/raw' directory and play it. default: 'default' (default sound is played)
	?number:Int, // (optional) Valid 32 bit integer specified as string. default: none (Cannot be zero)
	?repeatType:RepeatType // (optional) Repeating interval. Check 'Repeating Notifications' section for more info.
}

@:enum
abstract Action(String) to String {
	var Yes = 'Yes';
	var No = 'No';
}
@:enum
abstract RepeatType(String) to String {
	var Week = 'week';
	var Day = 'day';
	var Hour = 'hour';
	var Minute = 'minute';
	var Time = 'time';
}
