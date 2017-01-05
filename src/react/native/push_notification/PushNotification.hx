package react.native.push_notification;

@:jsRequire('react-native-push-notification')
extern class PushNotification {
	static function configure(config:Config):Void;
	static function localNotification(data:LocalNotification):Void;
	static function localNotificationSchedule(data:ScheduledLocalNotification):Void;
}

typedef Config = {
	?onRegister:String->Void,
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

typedef Notification = {
	foreground:Bool,
	userInteraction:Bool,
	message:String,
	data:{},
}

typedef ScheduledLocalNotification = {
	> LocalNotification,
	date:Date,
}

typedef LocalNotification = {
	#if android
	?id:String,
	?ticker:String,
	?autoCancel:Bool,
	?largeIcon:String,
	?smallIcon:String,
	?bigText:String,
	?subText:String,
	?color:String,
	?vibrate:Bool,
	?vibration:Int,
	?tag:String,
	?group:String,
	?ongoing:Bool,
	?repeatType:RepeatType,
	?actions:Action,
	#else
	?alertAction:Dynamic,
	?category:Dynamic,
	?userInfo:{},
	#end
	?title:String,
	message:String,
	?playSound:Bool,
	?soundName:String,
	?number:String,
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