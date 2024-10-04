import Foundation

import UIKit

class TaskVC: UIViewController {
    

  
    lazy var tableView: UITableView = {
        var tableView = UITableView(frame:  .zero)
        tableView.backgroundColor = .clear
        tableView.register(TaskCell.self, forCellReuseIdentifier: "TaskCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 100, right: 0)
        tableView.contentInsetAdjustmentBehavior = .never
        return tableView
    }()

    var callback: (()->Void)!
    var callbackService: (([String])->Void)! {
        didSet {
            title = "Select a service"
        }
       
    }
    var myTasks = [String]()
    let defaults = UserDefaults.standard
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        view.backgroundColor = AgedColor.bgColor
      
        view.addSubview(tableView)
    
        tableView.delegate = self
        tableView.dataSource = self
        
            let settings = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(tap))
            self.navigationItem.rightBarButtonItem = settings
            navigationItem.rightBarButtonItem?.isEnabled = false
       
       configureConstraints()
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.barTintColor = AgedColor.bgColor
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = AgedColor.black
        
        self.navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor:AgedColor.black,
            NSAttributedString.Key.font: UIFont(name: AgesConst.font, size: 30) ?? UIFont.systemFont(ofSize: 30, weight: .bold)
            ]
            self.navigationController?.navigationBar.titleTextAttributes =  [
                NSAttributedString.Key.foregroundColor:AgedColor.black,
                NSAttributedString.Key.font:  UIFont(name: AgesConst.font, size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
    }
    
  
    
    @objc func tap(){
        self.callbackService(myTasks)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
       
    }
    
  
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
   
}

extension TaskVC {
    
    func configureConstraints(){
        
      
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

    }
}


extension TaskVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return AgesConst.services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell") as! TaskCell
        cell.titleLabel.text = AgesConst.services[indexPath.row]
        cell.callback = {
          
            if cell.button.isSelected {
             
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                self.myTasks.append(AgesConst.services[indexPath.row])
   
            } else {

                var index = 0
                for i in 0...self.myTasks.count-1 {
                    for task in AgesConst.services {
                        if self.myTasks[i] == task {
                           index = i
                        }
                    }
                }
                self.myTasks.remove(at: index)
                self.navigationItem.rightBarButtonItem?.isEnabled = self.myTasks.count > 0
            }
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TaskCell
      
    
    }

 
}

