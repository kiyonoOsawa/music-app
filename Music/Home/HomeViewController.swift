import UIKit
import RealmSwift

class HomeViewController: UIViewController {
    
//    @IBOutlet weak var addDiaryButton: UIButton!
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
    
//    @IBAction func addDiary() {
//        let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
//        let nextVC = storyboard.instantiateViewController(withIdentifier: "toAddDiary")
//        self.present(nextVC, animated: true, completion: nil)
//    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let space: CGFloat = 8
        let cellWidth: CGFloat = diaryCollectionView.frame.width - space
        let cellHeight: CGFloat = 88
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 30, left:16, bottom: 0, right: 16)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 60
    }
}
