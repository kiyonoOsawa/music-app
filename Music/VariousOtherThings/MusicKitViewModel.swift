import Foundation
import MusicKit
import Combine

@MainActor
class MusicKitViewModel: NSObject {
    
    @Published var musicRequest = MusicRecentlyPlayedRequest<Song>()
    @Published var response: MusicRecentlyPlayedResponse<Song>!
    
    static let shared = MusicKitViewModel()
    
    //最近聴いた曲を最新から順に取得する
    func getCrrentMusic() async throws {
        //limitで取得個数制限
        musicRequest.limit = 30
        response = try await musicRequest.response()
        print("最近聴いた曲",response!.items.debugDescription)
    }
}
