import UIKit
import MusicKit
import StoreKit
import MediaPlayer

class MusicViewController: UIViewController {
    
    @IBOutlet weak var musicTable: UITableView!
    
    weak var viewModel = MusicKitViewModel.shared
    var musicSubscription: MusicSubscription?
    var musicTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        musicTable.dataSource = self
        musicTable.delegate = self
        musicTable.register(UINib(nibName: "MusicListTableViewCell", bundle: nil), forCellReuseIdentifier: "musicListCell")
        fetchMusicData()
    }
    
    func fetchMusicData() {
        if MPMusicPlayerController.systemMusicPlayer.nowPlayingItem == nil, musicSubscription?.canPlayCatalogContent != false {
            print("取得ゼロ")
        } else {
            musicTitle = MPMusicPlayerController.systemMusicPlayer.nowPlayingItem!.title!
            Task {
                try await viewModel?.getCrrentMusic()
            }
        }
    }
}

extension MusicViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "musicListCell", for: indexPath) as! MusicListTableViewCell
        cell.musicTitle.text = musicTitle
        return cell
    }
}
