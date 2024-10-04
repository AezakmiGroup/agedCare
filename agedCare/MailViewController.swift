
import Foundation
import UIKit


class MailViewController: UIViewController {
    var smallLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "Rate our application!"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    lazy var imageView: UIImageView = {
       var view = UIImageView()
        view.image = .care1
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var privacyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = AgedColor.blue
        button.titleLabel?.font =   UIFont.systemFont(ofSize: 18, weight: .bold)
        button.setTitle("Privacy policy", for: .normal)
        return button
    }()
    
    var mailButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = AgedColor.blue
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 18, weight: .bold)
        button.setTitle("Contact us", for: .normal)
        return button
    }()
    
    var rateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = AgedColor.blue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.setTitle("Rate us", for: .normal)
        return button
    }()
    
    let defaults = UserDefaults.standard
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Help"
        view.backgroundColor = AgedColor.bgColor
        
        view.addSubview(imageView)
        view.addSubview(smallLabel)
        view.addSubview(rateButton)
        view.addSubview(mailButton)
        view.addSubview(privacyButton)
      
        
        privacyButton.addTarget(self, action: #selector(privacy), for: .touchUpInside)
        rateButton.addTarget(self, action: #selector(rate), for: .touchUpInside)
        mailButton.addTarget(self, action: #selector(openMail), for: .touchUpInside)
     
        setupConstraints()
        self.navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: AgedColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30, weight: .bold)
            ]
    }
    
   
    
    @objc func privacy(){
        guard let url = URL(string: AgesConst.site) else { return }
        UIApplication.shared.open(url)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
       return .lightContent
   }
    
    func setupConstraints(){
       
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/2),
        ])

        
        NSLayoutConstraint.activate([
            smallLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 80),
            smallLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            smallLabel.bottomAnchor.constraint(equalTo: rateButton.topAnchor, constant: -70),
//            smallLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            privacyButton.heightAnchor.constraint(equalToConstant: 45),
            privacyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            privacyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            privacyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80)
        ])
       
        privacyButton.layer.cornerRadius = 22.5
        rateButton.layer.cornerRadius = 22.5
        mailButton.layer.cornerRadius = 22.5
      
        NSLayoutConstraint.activate([
            mailButton.heightAnchor.constraint(equalToConstant: 45),
            mailButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            mailButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            mailButton.bottomAnchor.constraint(equalTo: privacyButton.topAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            rateButton.heightAnchor.constraint(equalToConstant: 45),
            rateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            rateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            rateButton.bottomAnchor.constraint(equalTo: mailButton.topAnchor, constant: -10)
        ])
    }
    
    @objc func rate(){
        if let url = URL(string: AgesConst.rate) {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func openMail(){
       
        let mail = AgesConst.mail
        if let url =  URL(string: "mailto:\(mail)") {
            if UIApplication.shared.canOpenURL(url){
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:])
                } else {
                  UIApplication.shared.openURL(url)
                }
            }
        }
    }
}
