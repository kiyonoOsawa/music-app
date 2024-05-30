import UIKit
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
    var musicImage: URL? = URL(string: "https://example.com")!
    var musicTitle = String()
    var emotion = Int()
    var content = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sectionTableView.delegate = self
        sectionTableView.dataSource = self
        setTableView()
        //        setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("曲名!?\(musicTitle)")
        print("ジャケ写!?\(musicImage)")
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
    
    //    func setData() {
    //        dateCell.datePicker.date = date
    //        musicCell.musicImage.image = musicImage
    //        musicCell.titleLabel.text = musicTitle
    ////        emotionCell.
    //        textCell.diaryTextField.text = content
    //    }
    
    @IBAction func save() {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        let diaryItem = Diary()
        print("日にち！\(dateCell.datePicker.date)")
        diaryItem.date = dateCell.datePicker.date
        //        diaryItem.musicImage = UIImage(data: musicCell.musicImage)
        diaryItem.musicTitle = musicCell.titleLabel.text!
        diaryItem.content = textCell.diaryTextField.text!
        
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
        NotificationCenter.default.post(name: Notification.Name("DiarySaved"), object: nil)
    }
    
    @IBAction func desimiss() {
        dismiss()
    }
}

extension AddDiaryViewController: UITableViewDelegate, UITableViewDataSource {
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
            if let url = musicImage {
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
            return 152
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
