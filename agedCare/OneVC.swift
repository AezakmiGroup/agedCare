import UIKit


class OneVC: UIViewController {
    
   
    lazy var buttonOne: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = AgedColor.blue
        button.layer.cornerRadius = 20
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return button
    }()

    
    lazy var imageViews: [UIImageView] = {
        var img = [UIImageView]()
        for i in 0...1 {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            img.append(imageView)
        }
       
        return img
    }()
    
    var label: UILabel = {
        var label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .center
        label.textColor = AgedColor.black
        label.numberOfLines = 0
        label.text = "Check off each task you complete for your mentee."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var titleLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .center
        label.textColor = AgedColor.black
        label.text = "Organize your work to visit your mentees"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var isOnboard: Bool!
    var callback: (() -> Void)!
    static let shared = OneVC()
    private let scrollView = UIScrollView()
    var index = 0
    var images: [UIImage] = [.care2, .care1]
    var texts = ["Check off each task you complete for your mentee.", "All data about your visit will be available to you."]
    var texts2 = ["Organize your work to visit your mentees", "Follow the schedule of assistance to your wards."]
    
    var completionOpenStudy: (() -> Void)!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        view.backgroundColor = AgedColor.bgColor
            self.setupUI()
    }
    

    private func setupUI(){
        view.addSubview(scrollView)
        view.addSubview(buttonOne)
        scrollView.delegate = self
        view.addSubview(label)
        view.addSubview(titleLabel)
       
      
        configureActions()
        configureScrollView()
        var framegrn: CGRect = self.scrollView.frame
        framegrn.origin.x = framegrn.size.width * CGFloat(0)
        framegrn.origin.y = 0
        self.scrollView.scrollRectToVisible(framegrn, animated: false)
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
   
    private func configureScrollView() {
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize(
            width: view.frame.size.width * 2,
            height: UIScreen.main.bounds.height)
        scrollView.isPagingEnabled = true
        scrollView.isScrollEnabled = false
        for w in 0..<2 {
            scrollView.addSubview(imageViews[w])
            imageViews[w].image = images[w]
        }
        scrollView.showsHorizontalScrollIndicator = false
    }
    
    func showVC(isOnboard: Bool){
        if isOnboard {
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            view.window!.layer.add(transition, forKey: kCATransition)
            completionOpenStudy?()
        }
        navigationController?.popViewController(animated: true)
    }
    
    func setupConstraints() {
   
       let height = UIScreen.main.bounds.height
       scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: height)
       
       for i in imageViews {
           NSLayoutConstraint.activate([
               i.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 45 - (height > 800 ? 0 : 40) ),
           i.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 45  - (height > 800 ? 20 : 60) ),
            i.topAnchor.constraint(equalTo: view.topAnchor, constant: 90  - (height > 800 ? 0 : 40) ),
           ])
       }
        
        NSLayoutConstraint.activate([
           imageViews[0].centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
           imageViews[1].centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: view.frame.size.width ),
        ])
      
       NSLayoutConstraint.activate([
           buttonOne.widthAnchor.constraint(equalToConstant: 280),
           buttonOne.heightAnchor.constraint(equalToConstant: 50),
           buttonOne.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25 - (height > 800 ? 0 : 20)),
           buttonOne.centerXAnchor.constraint(equalTo: view.centerXAnchor)
       ])
       
       NSLayoutConstraint.activate([
           label.widthAnchor.constraint(equalToConstant: 280),
           label.bottomAnchor.constraint(equalTo: buttonOne.topAnchor, constant: -70),
           label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
       ])
        
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 90),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -10),
        ])
   }
}


extension OneVC {
    
    func configureActions() {
        buttonOne.addTarget(self, action: #selector(firstContinueTap), for: .touchUpInside)
       
    }
    
    @objc func firstContinueTap() {
      
        if index < 1 {
            index+=1
            scrollToPage(page: index, animated: true)
            label.text = texts[index]
            titleLabel.text = texts2[index]
        } else {
            UserDefaults.standard.setValue(false, forKey: "first")
            self.showVC(isOnboard: true)
            callback()
        }
    }
}


extension OneVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
       
        index = Int(pageNumber)
    }
    
    func scrollToPage(page: Int, animated: Bool) {
        var framegrn: CGRect = self.scrollView.frame
        framegrn.origin.x = framegrn.size.width * CGFloat(page)
        framegrn.origin.y = 0
        self.scrollView.scrollRectToVisible(framegrn, animated: animated)
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
       
    }
}
