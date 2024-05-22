import Foundation
import MusicKit
import Combine

@MainActor
class MusicKitViewModel: NSObject {
    
    static let shared = MusicKitViewModel()
    
    @Published var musicRequest = MusicRecentlyPlayedRequest<Song>()
    @Published var response: MusicRecentlyPlayedResponse<Song>!
    
    //最近聴いた曲を最新から順に取得する
    func getCrrentMusic() async throws {
        //limitで取得個数制限
        musicRequest.limit = 30
        response = try await musicRequest.response()
        print("最近聴いた曲",response!.items.debugDescription)
    }
    
    //apple Music上のデータからidを使って曲の情報を取得する
    func getSpecificSongsOnCatalog(ID: MusicItemID) async throws ->  MusicItemCollection<Song>.Element {
        //試しに上の関数で取ってきた30個目の曲の情報を持ってくる
        //idは曲一つ一つに必ず振られてるからidだけ抑えとけばこれで検索できる
        let Songrequest = MusicCatalogResourceRequest<Song>(matching: \.id, equalTo: ID)
        let Songresponse = try await Songrequest.response()
        let song = Songresponse.items.first
        print("id検索結果",song)
        return song!
    }
}
