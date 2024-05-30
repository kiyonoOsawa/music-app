import Foundation
import MusicKit
import Combine
//import UIKit

@MainActor
class MusicKitViewModel: NSObject {
    
    @Published var musicRequest = MusicRecentlyPlayedRequest<Song>()
    @Published var response: MusicRecentlyPlayedResponse<Song>!
    
    static let shared = MusicKitViewModel()
    
    //最近聴いた曲を最新から順に取得する
    func getCurrentMusic() async throws -> ([String], [URL?]) {
        //limitで取得個数制限
        musicRequest.limit = 30
        response = try await musicRequest.response()
        let titles = response.items.compactMap { $0.title }
        let images = response.items.compactMap { $0.artwork?.url(width: 100, height: 100) }
        print("最近聴いた曲のタイトル: \(titles)")
        return (titles, images)
    }
}
