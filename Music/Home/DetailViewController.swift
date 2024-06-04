import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var musicImageView: UIImageView!
    @IBOutlet weak var musicTitleLabel: UILabel!
    @IBOutlet weak var emotionImage: UIImageView!
    @IBOutlet weak var contentText: UITextView!
    
    
    var date = String()
    var musicImageURL: URL? = URL(string: "https://example.com")!
    var musicTitle = String()
    var emotionNum = Int()
    var content = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        design()
        setData()
    }
    
    func design() {
        contentText.isEditable = false
    }
    
    func setData() {
        dateLabel.text = date
        musicTitleLabel.text = musicTitle
        setEmotion()
        contentText.text = content
        
        if let url = musicImageURL {
            loadImage(from: url) { image in
                DispatchQueue.main.async {
                    self.musicImageView.image = image
                }
            }
        }
    }
    
    func setEmotion() {
        let emotionImageName = ["happy", "regret", "anxiety", "angry", "sad", "love", "joy", "tired"]
        for i in 0..<8 {
            emotionImage.image = UIImage(named: emotionImageName[emotionNum])
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
}
