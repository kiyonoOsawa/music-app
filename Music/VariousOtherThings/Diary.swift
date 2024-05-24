import Foundation
import RealmSwift

class Diary: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var musicTitle = String()
    @objc dynamic var musicImage = Data()
    @objc dynamic var date = Date()
    @objc dynamic var emotion = Int()
    @objc dynamic var content = String()
}
