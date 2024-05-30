import UIKit
import MusicKit
import StoreKit
import MediaPlayer

class MusicViewController: UIViewController {
    
    @IBOutlet weak var musicTable: UITableView!
    
    weak var viewModel = MusicKitViewModel.shared
    var musicSubscription: MusicSubscription?
    var musicTitle: [String] = []
    var musicImage: [URL?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        musicTable.dataSource = self
        musicTable.delegate = self
        musicTable.register(UINib(nibName: "MusicListTableViewCell", bundle: nil), forCellReuseIdentifier: "musicListCell")
        fetchMusicData()
    }
    
    func fetchMusicData() {
        Task {
            do {
                let (titles, images) = try await viewModel?.getCurrentMusic() ?? ([], [])
                musicTitle.append(contentsOf: titles)
                musicImage.append(contentsOf: images)
                musicTable.reloadData()
            } catch {
                print("Error fetching music data: \(error)")
            }
        }
        print("こっちの数は？\(musicTitle.count)")
        print("これもみたい\(MPMusicPlayerController.systemMusicPlayer.nowPlayingItem!)")
    }
}

extension MusicViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "musicListCell", for: indexPath) as! MusicListTableViewCell
        cell.musicTitle.text = musicTitle[indexPath.item]
        //取得してきた画像を表示
        if let url = musicImage[indexPath.item] {
            loadImage(from: url) { image in
                DispatchQueue.main.async {
                    cell.musicImage.image = image
                }
            }
        } else {
            cell.musicImage.image = nil
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
    }
}
