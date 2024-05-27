import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var musicImageView: UIImageView!
    @IBOutlet weak var musicTitleLabel: UILabel!
    @IBOutlet weak var emotionImage: UIImageView!
    @IBOutlet weak var contentText: UITextView!
    
    
    var date = String()
    var musicImage = UIImage()
    var musicTitle = String()
    var emotion = Int()
    var content = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
    }
    
    func design() {
    }
    
    func setData() {
        dateLabel.text = date
//        musicImageView.image = musicImage
        musicTitleLabel.text = musicTitle
//        emotionImage.image = emotion
        contentText.text = content
    }
}
