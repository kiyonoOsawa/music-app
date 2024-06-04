import Foundation
import MusicKit
import MediaPlayer
import StoreKit
//import Combine

@MainActor
class MusicKitViewModel: NSObject {
    
    @Published var musicRequest = MusicRecentlyPlayedRequest<Song>()
    @Published var response: MusicRecentlyPlayedResponse<Song>!
    
    static let shared = MusicKitViewModel()
    
    //最近聴いた曲を最新から順に取得する
    func getCurrentMusic() async throws -> ([String], [URL?], [String], [MusicItemID]) {
        //limitで取得個数制限
        musicRequest.limit = 30
        response = try await musicRequest.response()
        let titles = response.items.compactMap { $0.title }
        let images = response.items.compactMap { $0.artwork?.url(width: 100, height: 100) }
        let artists = response.items.compactMap { $0.artistName }
        let ids = response.items.compactMap{ $0.id}
        print("最近聴いた曲のタイトル: \(titles)")
        print("何を取得できているのかみたい\(response)")
        print("何型？\(type(of: ids))")
        return (titles, images, artists, ids)
    }
    
    static func createMusicPlaylist() async throws {
        Task {
            do{
                try await MusicLibrary.shared.createPlaylist(name: "created from Music app Playlist", description: "A library of songs shared by the app.", authorDisplayName: nil)
            }catch{
                print("😺",error)
            }
        }
    }
    
    //この関数は作ったplaylistに曲追加してくれる曲の保存
    func addMusicToLikedMusicLibrary(ID: MusicItemID) async throws {
        Task {
            do {
                let Request = MusicCatalogResourceRequest<Song>(matching: \.id, equalTo: ID)
                let Response = try await Request.response()
                var requestPlaylists = MusicLibraryRequest<Playlist>()
                //プレイリストとfilterのtextの名前一致してないと動かないから気をつけて
                requestPlaylists.filter(text: "created from Music app Playlist")
                let responsePlaylists = try await requestPlaylists.response()
                try await MusicLibrary.shared.add(Response.items.first!, to: responsePlaylists.items.first!)
            } catch (let error) {
                print(error)
            }
        }
    }
}
