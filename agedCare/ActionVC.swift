
import Foundation
import UIKit

class ActionVC: UIViewController {
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private let scrollStackViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nameField: MenteeView = {
        var view = MenteeView()
        view.backgroundColor = AgedColor.blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var button: JournalbButtonView = {
        var view = JournalbButtonView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

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
    
 
    var old: Aged! {
        didSet {
            nameField.nameLabel.text = "Name: \(old.name)"
            nameField.adressLabel.text = "Adress: \(old.adress)"
            nameField.timeLabel.text = "Time: \(old.time)"
        }
    }
    var service: [Service]!
    let defaults = UserDefaults.standard
    private var tableViewHeight: NSLayoutConstraint?
    var today = "" {
        didSet{
            nameField.dateLabel.text = "Date: \(today)"
        }
    }

    var isHistory: Bool!
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        today = Date().getFormattedDate(format: "LLLL dd")
        if old.allServices.count > 0 {
            if old.allServices.last!.last!.date == today {
                self.service = old.allServices.last
            } else {
                self.service = [Service]()
                for i in 0...old.service.count-1 {
                    self.service.append(Service(name: old.service[i].name, done: false, date: today))
                    defaults.setValue(old.service[i].name, forKey: "\(old.id) \(i) \(old.allServices.count) service name")
                    defaults.setValue(false, forKey: "\(old.id) \(i) \(old.allServices.count) service done")
                    defaults.setValue(today, forKey: "\(old.id) \(i) \(old.allServices.count) service date")
                }
//                defaults.setValue(old.allServices.count, forKey: "\(old.id) days")
//                old.allServices.append(self.service)
                old.allServices.append(self.service)
                defaults.setValue(old.allServices.count, forKey: "\(old.id) days")
            }
        } else {
            self.service = [Service]()
            for i in 0...old.service.count-1 {
                self.service.append(Service(name: old.service[i].name, done: false, date: today))
                defaults.setValue(old.service[i].name, forKey: "\(old.id) \(i) \(old.allServices.count-1) service name")
                defaults.setValue(false, forKey: "\(old.id) \(i) \(old.allServices.count) service done")
                defaults.setValue(today, forKey: "\(old.id) \(i) \(old.allServices.count) service date")
            }
            old.allServices.append(self.service)
            defaults.setValue(old.allServices.count, forKey: "\(old.id) days")
        }
    
        view.backgroundColor = AgedColor.bgColor
      
   
        setupScrollView()
       
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.barTintColor = AgedColor.bgColor
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.tintColor = .white.withAlphaComponent(0.7)
        
        self.navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor:AgedColor.black,
            NSAttributedString.Key.font: UIFont(name: AgesConst.font, size: 30) ?? UIFont.systemFont(ofSize: 30, weight: .bold)
            ]
            self.navigationController?.navigationBar.titleTextAttributes =  [
                NSAttributedString.Key.foregroundColor:AgedColor.black,
                NSAttributedString.Key.font:  UIFont(name: AgesConst.font, size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
        
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        setupConstraints()
        var historyServices = [[Service]]()
       
        for i in old.allServices {
            var t = 0
            for el in i {
                if el.done {
                    t+=1
                }
            }
            if t > 0 {
                historyServices.append(i)
            }
        }
        button.isEnabled = historyServices.count > 0
    }

    @objc func tap(){
        let vc = JournalVC()
        var historyServices = [[Service]]()
       
        for i in old.allServices {
            var t = 0
            for el in i {
                if el.done {
                    t+=1
                }
            }
            if t > 0 {
                historyServices.append(i)
            }
        }
        vc.services = historyServices
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tableViewHeight?.constant = self.tableView.contentSize.height
    }
  
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollStackViewContainer)
        scrollStackViewContainer.addSubview(nameField)
        scrollStackViewContainer.addSubview(button)
        scrollStackViewContainer.addSubview(tableView)
      
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 12),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            nameField.topAnchor.constraint(equalTo: scrollStackViewContainer.topAnchor, constant: 16),
            nameField.leadingAnchor.constraint(equalTo: scrollStackViewContainer.leadingAnchor, constant: 16),
            nameField.trailingAnchor.constraint(equalTo: scrollStackViewContainer.trailingAnchor, constant: -16),
            nameField.heightAnchor.constraint(equalToConstant: 210),
            
            button.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 15),
            button.leadingAnchor.constraint(equalTo: scrollStackViewContainer.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: scrollStackViewContainer.trailingAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 55),
            
            tableView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: scrollStackViewContainer.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: scrollStackViewContainer.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: scrollStackViewContainer.bottomAnchor, constant: 10),
            
           
        ])
        tableViewHeight = tableView.heightAnchor.constraint(equalToConstant: 50)
        tableViewHeight?.isActive = true
       
        var scrollContentGuide = scrollView.contentLayoutGuide
        var scrollFrameGuide = scrollView.frameLayoutGuide
        NSLayoutConstraint.activate([
            scrollStackViewContainer.leadingAnchor.constraint(equalTo: scrollContentGuide.leadingAnchor),
            scrollStackViewContainer.trailingAnchor.constraint(equalTo: scrollContentGuide.trailingAnchor),
            scrollStackViewContainer.topAnchor.constraint(equalTo: scrollContentGuide.topAnchor),
            scrollStackViewContainer.bottomAnchor.constraint(equalTo: scrollContentGuide.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            scrollStackViewContainer.leadingAnchor.constraint(equalTo: scrollFrameGuide.leadingAnchor),
            scrollStackViewContainer.trailingAnchor.constraint(equalTo: scrollFrameGuide.trailingAnchor),
//            scrollStackViewContainer.bottomAnchor.constraint(equalToConstant: 1500),
           
        ])
    }
   
}

//MARK: TextFieldDelegate


extension ActionVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return old.service.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell") as! TaskCell
        cell.titleLabel.text = old.allServices.last![indexPath.row].name
        cell.button.isSelected = old.allServices.last![indexPath.row].done
        cell.callback = { [self] in
          
            if cell.button.isSelected {
                print("\(self.old.id) \(indexPath.row) \(old.allServices.count-1) service done")
                self.defaults.set(true, forKey: "\(self.old.id) \(indexPath.row) \(old.allServices.count-1) service done")
            } else {
                self.defaults.set(false, forKey: "\(self.old.id) \(indexPath.row) \(old.allServices.count-1) service done")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
}


extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
    
    public var removeTimeStamp : Date? {
           guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self)) else {
            return nil
           }
           return date
       }
}
