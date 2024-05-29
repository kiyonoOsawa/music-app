import UIKit
import MusicKit
import StoreKit
import MediaPlayer

class MusicViewController: UIViewController {
    
    @IBOutlet weak var musicTable: UITableView!
    
    weak var viewModel = MusicKitViewModel.shared
    var musicSubscription: MusicSubscription?
    var musicTitle: [String] = []
    
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
            Task {
                do {
                    let titles = try await viewModel?.getCurrentMusic() ?? []
                    musicTitle.append(contentsOf: titles)
                    musicTable.reloadData()
                } catch {
                    print("Error fetching music data: \(error)")
                }
            }
            print("こっちの数は？\(musicTitle.count)")
            print("これもみたい\(MPMusicPlayerController.systemMusicPlayer.nowPlayingItem!)")
        }
    }
}

extension MusicViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "musicListCell", for: indexPath) as! MusicListTableViewCell
        cell.musicTitle.text = musicTitle[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}
