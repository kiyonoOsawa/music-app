import UIKit
import RealmSwift
import MusicKit
import MediaPlayer
import StoreKit

class PlaylistViewController: UIViewController {
    
    @IBOutlet weak var playListCollectionView: UICollectionView!
    
    weak var viewModel = MusicKitViewModel.shared
    let realm = try! Realm()
    var diary: Results<Diary>!
//    var playlistMusicIDs: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playListCollectionView.delegate = self
        playListCollectionView.dataSource = self
        playListCollectionView.register(UINib(nibName: "PlayListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PlayListCell")
        do{
            let realm = try Realm()
            diary = realm.objects(Diary.self)
            playListCollectionView.reloadData()
        } catch {
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.diary = realm.objects(Diary.self)
        playListCollectionView.reloadData()
    }
    
}

extension PlaylistViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return diary.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayListCell", for: indexPath) as! PlayListCollectionViewCell
        cell.layer.cornerRadius = 12
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOpacity = 0.45
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = 5
        cell.layer.masksToBounds = false
        // Tag番号を使ってインスタンスをつくる
        let photoImageView = cell.contentView.viewWithTag(1)  as! UIImageView
        let photoImage = UIImage(named: "")
        photoImageView.image = photoImage
        let titleLabel = cell.contentView.viewWithTag(2) as! UILabel
        titleLabel.text = diary[indexPath.row].musicTitle
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.estimatedItemSize = .zero
        let space: CGFloat = 8
        let cellWidth: CGFloat = UIScreen.main.bounds.width / 2 - space * 4
        let cellHeight: CGFloat = 206
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.estimatedItemSize = .zero
        return UIEdgeInsets(top: 16, left:16, bottom: 8, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
