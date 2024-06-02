import UIKit
import RealmSwift

class PlaylistViewController: UIViewController {
    
    @IBOutlet weak var playListCollectionView: UICollectionView!
    
    let realm = try! Realm()
    var diary: Results<Diary>!
    
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
        //ここのmusicImageはplaylistの最後の一つを選びたい
//        let musicImage = UIImage(data: diary[indexPath.row].musicImage)
//        cell.musicImage.image = musicImage
        //ここのmusicTitleあとで年・月に変更したい
        cell.playListTitle.text = diary[indexPath.row].musicTitle
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let space: CGFloat = 8
        let cellWidth: CGFloat = UIScreen.main.bounds.width / 2 - space * 4
        let cellHeight: CGFloat = 206
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24, left:18, bottom: 0, right: 18)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
