import Foundation
import UserNotifications

struct NotificationService {
    static func setRepeatCalenderNotification(id: String, weekday: Weekday, title: String, body: String, hour: Int, minute: Int, completion: @escaping (_ error: Error?) -> Void) {
        let content = UNMutableNotificationContent()
        content.title = "この曲を保存しませんか？"
        content.body = "この曲を聴いたあなたは何を考えていましたか？"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.weekday = weekday.rawValue
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "\(id)/\(weekday.name)", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            completion(error)
        }
    }
    
    static func cancelRepeatNotification(id: String, weekday: Weekday) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["\(id)/\(weekday.name)"])
    }
    
    static func checkNotificationAuthorization(completion: @escaping (_ isAuthorized: Bool) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}

enum Weekday: Int {
    case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday
    
    var name: String {
        switch self {
        case .sunday:
            return "Sunday"
        case .monday:
            return "Monday"
        case .tuesday:
            return "Tuesday"
        case .wednesday:
            return "Wednesday"
        case .thursday:
            return "Thursday"
        case .friday:
            return "Friday"
        case .saturday:
            return "Saturday"
        }
    }
    
    var title: String {
        switch self {
        case .sunday:
            return "日曜日"
        case .monday:
            return "月曜日"
        case .tuesday:
            return "火曜日"
        case .wednesday:
            return "水曜日"
        case .thursday:
            return "木曜日"
        case .friday:
            return "金曜日"
        case .saturday:
            return "土曜日"
        }
    }
}
