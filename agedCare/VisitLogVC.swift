
import Foundation
import UIKit
import WebKit

class VisitLogVC: UIViewController {
    

    lazy var tableView: UITableView = {
        var tableView = UITableView(frame:  .zero)
        tableView.backgroundColor = .clear
        tableView.register(TaskCell.self, forCellReuseIdentifier: "TaskCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        return tableView
    }()
    
 
    var services: [Service]!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        title = services.last?.date
        view.backgroundColor = AgedColor.bgColor
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor:AgedColor.black,
            NSAttributedString.Key.font: UIFont(name: AgesConst.font, size: 30) ?? UIFont.systemFont(ofSize: 30, weight: .bold)
            ]
            self.navigationController?.navigationBar.titleTextAttributes =  [
                NSAttributedString.Key.foregroundColor:AgedColor.black,
                NSAttributedString.Key.font:  UIFont(name: AgesConst.font, size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
        setupConstraints()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    func setupConstraints(){
      
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,  constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

//MARK: TextFieldDelegate


extension VisitLogVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell") as! TaskCell
        cell.titleLabel.text = services[indexPath.row].name
//        cell.button.isSelected = services[indexPath.row].done
      
        if services[indexPath.row].done {
            print("mkmkkmmmmmmm")
            cell.button.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        } else {
            cell.button.setImage(UIImage(systemName: "circle"), for: .normal)
            
        }
        cell.button.isEnabled = false
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
}



class MenteeHelp: UIViewController, WKNavigationDelegate {

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    private let webView: WKWebView = {
        let configurations = WKWebViewConfiguration()
        configurations.userContentController = WKUserContentController()
        let webView = WKWebView(frame: .zero, configuration: configurations)
    
        return webView
    }()
    
    var privacyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = AgedColor.blue
        button.setTitleColor(.white, for: .normal)
        button.isHidden = true
        button.layer.cornerRadius = 20
        button.setTitle("I agree", for: .normal)
        return button
    }()
    
    
    private let url: URL
    
    
    var showButton: Bool!
    var callback : (() -> Void)!
    let defaults = UserDefaults.standard
    
    private let userAgent = "Mozilla/5.0 (\(UIDevice.current.model); CPU \(UIDevice.current.model) OS \(UIDevice.current.systemVersion.replacingOccurrences(of: ".", with: "_")) like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/\(UIDevice.current.systemVersion) Mobile/15E148 Safari/604.1"
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonTap(){
        guard let callback = callback  else {return}
        UserDefaults.standard.set(false, forKey: "firstOpen")
        print("false")
        callback()
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createWebView()
        setUpConstraints()
        privacyButton.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
    }
    
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.backgroundColor = .white
        let request = URLRequest(url: url)
        webView.customUserAgent = userAgent
        webView.load(request)
        webView.navigationDelegate = self
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if showButton != nil {
            privacyButton.isHidden = !showButton
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void)
    {
 
        if let url = navigationAction.request.url {
            if url.query?.contains("showAgreebutton") == true {
                defaults.set("", forKey: "home")
                showButton = true
//                self.privacyButton.isHidden = false
            } else {
                if self.privacyButton.isHidden {
                    let home = defaults.value(forKey: "home") as? String ?? ""
                    if home == "" {
                        defaults.set(url.absoluteString, forKey: "home")
                    }
                }
            }
        }
       
        switch navigationAction.request.url?.scheme {
        case "tel":
            UIApplication.shared.open(navigationAction.request.url!, options: [:], completionHandler: nil)
            decisionHandler(.cancel)
           
        case "mailto":
            UIApplication.shared.open(navigationAction.request.url!, options: [:], completionHandler: nil)
            decisionHandler(.cancel)
          
        case "tg":
            UIApplication.shared.open(navigationAction.request.url!, options: [:], completionHandler: nil)
            decisionHandler(.cancel)
 
        case "phonepe":
            UIApplication.shared.open(navigationAction.request.url!)
            decisionHandler(.cancel)
          
        case "paytmmp":
            UIApplication.shared.open(navigationAction.request.url!)
            decisionHandler(.cancel)
        
        default:
            decisionHandler(.allow)
        }
    }
    

    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }

    
    private func createWebView() {
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.allowsBackForwardNavigationGestures = true
        view.addSubview(webView)
        view.addSubview(privacyButton)
        
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            webView.topAnchor
                .constraint(equalTo: self.view.topAnchor),
            webView.leftAnchor
                .constraint(equalTo: self.view.leftAnchor),
            webView.bottomAnchor
                .constraint(equalTo: self.view.bottomAnchor),
            webView.rightAnchor
                .constraint(equalTo: self.view.rightAnchor)
        ])
   
        NSLayoutConstraint.activate([
            privacyButton.heightAnchor.constraint(equalToConstant: 50),
            privacyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            privacyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            privacyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    
    }
}
