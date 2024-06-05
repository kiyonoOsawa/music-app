import UIKit
import RealmSwift
import MusicKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var musicImageView: UIImageView!
    @IBOutlet weak var musicTitleLabel: UILabel!
    @IBOutlet weak var emotionImage: UIImageView!
    @IBOutlet weak var contentText: UITextView!
    
    weak var viewModel = MusicKitViewModel.shared
    var diary: Results<Diary>!
    
    var date = String()
    //    var musicIDString = String()
    var emotionNum = Int()
    var content = String()
    var musicID: MusicItemID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        design()
        setData()
        fetchMusicDetails()
    }
    
    func design() {
        contentText.isEditable = false
    }
    
    func setData() {
        dateLabel.text = date
        setEmotion()
        contentText.text = content
    }
    
    func setEmotion() {
        let emotionImageName = ["happy", "regret", "anxiety", "angry", "sad", "love", "joy", "tired"]
        for i in 0..<8 {
            emotionImage.image = UIImage(named: emotionImageName[emotionNum])
        }
    }
    
    private func fetchMusicDetails() {
        Task {
            do {
                let song = try await viewModel?.getSpecificSongsOnCatalog(ID: musicID)
                if let song = song {
                    musicTitleLabel.text = song.title
                    if let artworkURL = song.artwork?.url(width: 200, height: 200) {
                        loadImage(from: artworkURL) { image in
                            DispatchQueue.main.async {
                                self.musicImageView.image = image
                            }
                        }
                    }
                }
            } catch {
                print("Failed to fetch music details: \(error)")
            }
        }
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
    
    func setDismissKeyboard() {
        let tapGR: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGR.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGR)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
//    @IBAction func playButtonTapped() {
//        Task {
//            do {
////                let song = try await viewModel?.getSpecificSongsOnCatalog(ID: musicID)
//                let player = SystemMusicPlayer.shared
//                player.queue = [musicID]
//                try await player.prepareToPlay()
//                player.play()
//            } catch {
//                print("Failed to play music: \(error)")
//            }
//        }
//    }
}
