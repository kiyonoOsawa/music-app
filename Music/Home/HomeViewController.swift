import UIKit
import RealmSwift

class HomeViewController: UIViewController {
    
    @IBOutlet weak var diaryCollectionView: UICollectionView!
    
    static let shared = HomeViewController()
    let realm = try! Realm()
    var diary: Results<Diary>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        diaryCollectionView.delegate = self
        diaryCollectionView.dataSource = self
        self.diary = realm.objects(Diary.self)
        diaryCollectionView.reloadData()
        setUI()
        print("とってきたい！\(diary)")
        do{
            let realm = try Realm()
            diary = realm.objects(Diary.self)
            diaryCollectionView.reloadData()
        } catch {
        }
        NotificationCenter.default.addObserver(self, selector: #selector(diarySaved(_:)), name: Notification.Name("DiarySaved"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.diary = realm.objects(Diary.self)
        diaryCollectionView.reloadData()
    }
    
    @objc func diarySaved(_ notification: Notification) {
        // データを再読み込み
        self.diary = realm.objects(Diary.self)
        diaryCollectionView.reloadData()
    }
    
    deinit {
        // NotificationCenterのObserverを削除
        NotificationCenter.default.removeObserver(self)
    }
    
    func setUI() {
        diaryCollectionView.register(UINib(nibName: "DiaryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DiaryCell")
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return diary.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiaryCell", for: indexPath) as! DiaryCollectionViewCell
        cell.layer.cornerRadius = 16
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOpacity = 0.45
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = 5
        cell.layer.masksToBounds = false
        cell.musicTitleLabel.text = diary[indexPath.row].musicTitle
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        cell.dateLabel.text = dateFormatter.string(from: diary[indexPath.row].date)
        let musicImage = UIImage(data: diary[indexPath.row].musicImage)
        cell.musicImageView.image = musicImage
        if diary[indexPath.row].content == "" {
            cell.contentAble.isHidden = true
        } else {
            cell.contentAble.isHidden = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        if let addVC = storyboard.instantiateViewController(withIdentifier: "ditailVC") as? DetailViewController {
            addVC.modalTransitionStyle = .coverVertical
            addVC.modalPresentationStyle = .pageSheet
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd"
            addVC.date = dateFormatter.string(from: diary[indexPath.row].date)
            //            addVC.musicImage = UIImage(data: diary[indexPath.row].musicImage)!
            addVC.musicTitle = diary[indexPath.row].musicTitle
            addVC.emotion = diary[indexPath.row].emotion
            addVC.content = diary[indexPath.row].content
            self.navigationController?.pushViewController(addVC, animated: true)
            //            self.present(addVC, animated: true, completion: nil)
            print("押された？\(indexPath.row)") //押されてるのになぜ動かないの------！
        } else {
            print("ダメでした")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let space: CGFloat = 8
        let cellWidth: CGFloat = diaryCollectionView.frame.width - space
        let cellHeight: CGFloat = 88
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24, left:16, bottom: 0, right: 16)
    }
}
