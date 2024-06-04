import UIKit
import MusicKit
import RealmSwift

class AddDiaryViewController: UIViewController {
    
    @IBOutlet weak var sectionTableView: UITableView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    static let shared = AddDiaryViewController()
    
    let realm = try! Realm()
    var diary = Diary()
    
    var dateCell = DateTableViewCell()
    var musicCell = MusicTableViewCell()
    var emotionCell = EmotionTableViewCell()
    var textCell = TextTableViewCell()
    var date = Date()
    var musicTitle = String()
    var musicImageURL: URL? = URL(string: "https://example.com")!
    var musicArtist = String()
    var musicID = String()
    var emotion = Int()
    var content = String()
    var emotionNum = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sectionTableView.delegate = self
        sectionTableView.dataSource = self
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("曲名!?\(musicTitle)")
        print("ジャケ写!?\(musicImageURL)")
        print("感情ナンバー\(emotionNum)")
        print("音楽のID\(musicID)")
        sectionTableView.reloadData()
    }
    
    func setTableView() {
        sectionTableView.register(UINib(nibName: "DateTableViewCell", bundle: nil), forCellReuseIdentifier: "dateCell")
        sectionTableView.register(UINib(nibName: "MusicTableViewCell", bundle: nil), forCellReuseIdentifier: "musicCell")
        sectionTableView.register(UINib(nibName: "EmotionTableViewCell", bundle: nil), forCellReuseIdentifier: "emotionCell")
        sectionTableView.register(UINib(nibName: "TextTableViewCell", bundle: nil), forCellReuseIdentifier: "textCell")
    }
    
    func read() -> Diary? {
        return realm.objects(Diary.self).first
    }
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save() {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        let diaryItem = Diary()
        print("日にち！\(dateCell.datePicker.date)")
        diaryItem.date = dateCell.datePicker.date
        diaryItem.musicImage = musicImageURL
        diaryItem.musicTitle = musicCell.titleLabel.text!
        diaryItem.artistName = musicArtist
        diaryItem.emotion = emotionNum
        diaryItem.content = textCell.diaryTextField.text!
        diaryItem.musicID = musicID
        
        do{
            let realm = try! Realm()
            try realm.write({ () -> Void in
                realm.add(diaryItem)
            })
        } catch {
            print("Save is Faild")
        }
        print("ちゃんと保存されてるーーーー？\(diary.date)")
        print("こっちはーーー？\(diary.content)")
        print("お願い。。。\(diary.musicID)")
        print("感情番号把握したい\(emotionNum)")
        NotificationCenter.default.post(name: Notification.Name("DiarySaved"), object: nil)
    }
    
    @IBAction func desimiss() {
        dismiss()
    }
}

extension AddDiaryViewController: UITableViewDelegate, UITableViewDataSource, EmotionTableViewCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            dateCell = tableView.dequeueReusableCell(withIdentifier: "dateCell") as! DateTableViewCell
            dateCell.selectionStyle = UITableViewCell.SelectionStyle.none
            return dateCell
        } else if indexPath.section == 1 {
            musicCell = tableView.dequeueReusableCell(withIdentifier: "musicCell") as! MusicTableViewCell
            musicCell.selectionStyle = UITableViewCell.SelectionStyle.none
            musicCell.titleLabel.text = musicTitle
            //取得してきた画像を表示
            if let url = musicImageURL {
                loadImage(from: url) { image in
                    DispatchQueue.main.async {
                        self.musicCell.musicImage.image = image
                    }
                }
            } else {
                musicCell.musicImage.image = nil
            }
            return musicCell
        } else if indexPath.section == 2 {
            emotionCell = tableView.dequeueReusableCell(withIdentifier: "emotionCell") as! EmotionTableViewCell
            emotionCell.selectionStyle = UITableViewCell.SelectionStyle.none
            emotionCell.delegate = self
            emotionCell.emotionButtons.enumerated().forEach { (index, button) in
//                button.tag = index + 1
                button.tag = index
            }
            emotionCell.emotionLabels.enumerated().forEach { (index, label) in
//                label.tag = index + 1
                label.tag = index
            }
            return emotionCell
        } else {
            textCell = tableView.dequeueReusableCell(withIdentifier: "textCell") as! TextTableViewCell
            textCell.selectionStyle = UITableViewCell.SelectionStyle.none
            return textCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            self.performSegue(withIdentifier: "toSelectMusic", sender: nil)
            print("画面遷移")
        } else {
            return
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 36
        } else if indexPath.section == 1 {
            return 120
        } else if indexPath.section == 2 {
            return 214
        } else if indexPath.section == 3 {
            return 380
        }
        return tableView.estimatedRowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .zero
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tappedBtn(cell: EmotionTableViewCell, didTapButtonWithTag tag: Int) {
        print(tag)
        emotionNum = tag
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
}
