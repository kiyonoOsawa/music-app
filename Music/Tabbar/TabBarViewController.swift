import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
        
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        UITabBarItem.appearance().setTitleTextAttributes([.font: UIFont.init(name: "HelveticaNeue-Bold", size: 13), .foregroundColor: UIColor(named: "MainColor")], for: .selected)
        setupMiddleButton()
    }
    
    // TabBarButton – 中央ボタンの設定
    func setupMiddleButton() {
        let middleBtn = UIButton(frame: CGRect(x: (self.view.bounds.width / 2)-30, y: -30, width: 60, height: 60))
        // ボタンを自分好みのスタイルに設定する
        middleBtn.setImage(UIImage(systemName: "plus"), for: .normal)
        middleBtn.tintColor = .white
        middleBtn.backgroundColor = UIColor(named: "MainColor")
        middleBtn.layer.cornerRadius = 30
        
        // タブバーに追加し、クリック イベントを追加する
        self.tabBar.addSubview(middleBtn)
        middleBtn.addTarget(self, action: #selector(self.menuButtonAction), for: .touchUpInside)
        
        self.view.layoutIfNeeded()
    }
    
    // メニュー ボタンのタッチ アクション
    @objc func menuButtonAction(sender: UIButton) {
        self.selectedIndex = 2 // 中央のタブを選択します。タブが 3 つしかない場合は "1" を使用します。
        let storyboard: UIStoryboard = UIStoryboard(name: "AddDiary", bundle: nil)
        let addVC = storyboard.instantiateViewController(withIdentifier: "addNC")
        self.present(addVC, animated: true, completion: nil)
    }
}
