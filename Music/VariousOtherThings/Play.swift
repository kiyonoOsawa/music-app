import Foundation
import RealmSwift
//import Realm
//import MusicKit

class Play: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var name: String = ""
//    let song = List<Song>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
