import Foundation
import RealmSwift

class Diary: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var musicTitle = String()
//    @objc dynamic var musicImage = String()
    @objc dynamic var date = Date()
    @objc dynamic var emotion = Int()
    @objc dynamic var content = String()
    @objc dynamic var musicImageString: String? = nil
    
    // URL型のカスタムプロパティ
    var musicImage: URL? {
        get {
            if let urlString = musicImageString {
                return URL(string: urlString)
            }
            return nil
        }
        set {
            musicImageString = newValue?.absoluteString
        }
    }
}
