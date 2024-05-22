import UIKit

class AddDiaryViewController: UIViewController {
    
    @IBOutlet weak var sectionTableView: UITableView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var dateCell = DateTableViewCell()
    var musicCell = MusicTableViewCell()
    var emotionCell = EmotionTableViewCell()
    var textCell = TextTableViewCell()

    override func viewDidLoad() {
        super.viewDidLoad()
        sectionTableView.delegate = self
        sectionTableView.dataSource = self
        setTableView()
    }
    
    func setTableView() {
        sectionTableView.register(UINib(nibName: "DateTableViewCell", bundle: nil), forCellReuseIdentifier: "dateCell")
        sectionTableView.register(UINib(nibName: "MusicTableViewCell", bundle: nil), forCellReuseIdentifier: "musicCell")
        sectionTableView.register(UINib(nibName: "EmotionTableViewCell", bundle: nil), forCellReuseIdentifier: "emotionCell")
        sectionTableView.register(UINib(nibName: "TextTableViewCell", bundle: nil), forCellReuseIdentifier: "textCell")
    }
    
    @IBAction func desimiss() {
        dismiss(animated: true, completion: nil)
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
            return 50
        } else if indexPath.section == 1 {
            return 90
        } else if indexPath.section == 3 {
            return 380
        }
        return tableView.estimatedRowHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
}
