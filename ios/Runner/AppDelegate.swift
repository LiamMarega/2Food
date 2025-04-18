import UIKit
import Flutter
import FirebaseCore
import FirebaseMessaging

@main
@objc class AppDelegate: FlutterAppDelegate {
  private let notificationCenter = UNUserNotificationCenter.current()
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    FirebaseApp.configure()

      
    Messaging.messaging().delegate = self
    
    
    notificationCenter.delegate = self
    let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
    notificationCenter.requestAuthorization(options: authOptions) { granted, error in
        if granted {
          print("User granted notification permissions.")
        } else if let error = error {
          print("Error requesting notification permissions: \(error)")
        }
      }
    application.registerForRemoteNotifications()
    
    
    GeneratedPluginRegistrant.register(with: self)
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      Messaging.messaging().apnsToken = deviceToken
      print("APNs token registered: \(deviceToken)")
    }
}

// FlutterAppDelegate already conforms to UNUserNotificationCenterDelegate
// so we don't need to declare the conformance again
extension AppDelegate {
   override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if #available(iOS 14.0, *) {
            completionHandler([.banner, .sound, .badge])
        } else {
            // For iOS versions earlier than 14.0
            completionHandler([.alert, .sound, .badge])
        }
    }

   override func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print("Tapped on notification with userInfo: \(userInfo)")
        completionHandler()
    }
}


extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("FCM registration token: \(String(describing: fcmToken))")
    }
}
