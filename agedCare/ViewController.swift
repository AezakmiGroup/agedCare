import UIKit

class ViewController: UIViewController {
  
    lazy var tableView: UITableView = {
        var tableView = UITableView(frame:  .zero)
        tableView.backgroundColor = .clear
        tableView.register(MainCell.self, forCellReuseIdentifier: "MainCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 200, right: 0)
        tableView.contentInsetAdjustmentBehavior = .never
        return tableView
    }()
    
    lazy var emptylistView: EmptylistView = {
       var view = EmptylistView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AgedColor.blue
        view.isHidden = true
        view.layer.cornerRadius = 30
        view.titleLabel.text = "The list of your wards is empty"
        view.smallLabel.text = "Click on + to add"
        return view
    }()
    
  
    var selectIndex = 0
    var olds = [Aged]()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = AgedColor.bgColor
        view.addSubview(tableView)
        view.addSubview(emptylistView)
       
        configureConstraints()
        getMentees()
      
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let isFirst = UserDefaults.standard.value(forKey: "first") as? Bool ?? true
        if !isFirst {
            setupNavigationBar()
        } else {
            let vc = OneVC()
            tabBarController?.tabBar.isHidden = true
            navigationController?.pushViewController(vc, animated: false)
            vc.callback = {() in
                self.setupNavigationBar()
                self.tabBarController?.tabBar.isHidden = false
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        setupNavigationBar()
        getMentees()
    }
    
    private func getMentees(){
        let agedLength = UserDefaults.standard.value(forKey: "agedLength") as? Int ?? 0
        olds = []

        if agedLength > 0 {
            for i in 1...agedLength {
                let name = defaults.value(forKey: "\(i) name") as? String ?? ""
                let adress = defaults.value(forKey: "\(i) adress") as? String ?? ""
                let time = defaults.value(forKey: "\(i) time") as? String ?? ""
                let id = defaults.value(forKey: "\(i) id") as? Int ?? 0
                let del = defaults.value(forKey: "\(i) del") as? Bool ?? false
                
                let servicesLenghth = defaults.value(forKey: "\(i) servicesLenghth") as? Int ?? 0
                var common = [Service]()
             
                for index in 0...servicesLenghth-1 {
                    let service = defaults.value( forKey: "\(i) \(index) service name") as? String ?? ""
                    let date = defaults.value( forKey: "\(i) \(index) service date") as? String ?? ""
                    let doneServ = defaults.value( forKey: "\(i) \(index) service done") as? Bool ?? false
                    common.append(Service(name: service, done: doneServ, date: date))
                }
                
                let old = Aged(name: name, adress: adress, time: time, service: common, allServices: dateServices(old: id, serviceCount: common), del: del, id: id)
                olds.append(old)
            }
        }

       print(olds)
        self.tableView.reloadData()
        emptylistView.isHidden = olds.count > 0
    }
    
    func dateServices(old i: Int, serviceCount: [Service]) -> [[Service]]{
     
        let daysLength = defaults.value(forKey: "\(i) days") as? Int ?? 0
        var allServices = [[Service]]()
            if daysLength > 0 {
                var common = [Service]()
            for day in 0...daysLength-1 {
                common = []
                for serviceNumber in 0...serviceCount.count-1 {
                    let service = serviceCount[serviceNumber].name
                    let date = defaults.value( forKey: "\(i) \(serviceNumber) \(day) service date") as? String ?? ""
                    let doneServ = defaults.value( forKey: "\(i) \(serviceNumber) \(day) service done") as? Bool ?? false
                    common.append(Service(name: service, done: doneServ, date: date))
                }
                    allServices.append(common)
            }
        }
        return allServices
    }
    
    func getImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }
    
    @objc func openSeriesAdd(){
        let vc = AddOldPersonVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func openDetails(at index: Int){
        let vc = ActionVC()
        vc.old = olds[index]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupNavigationBar(){
        title = "My mentees"
        let userInfo = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(openSeriesAdd))
        self.navigationItem.rightBarButtonItem = userInfo
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
    
    func configureConstraints(){

       
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            emptylistView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor, constant: -50),
            emptylistView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emptylistView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emptylistView.heightAnchor.constraint(equalToConstant: 350)
        ])
        
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return olds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell") as! MainCell
        cell.old = olds[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openDetails(at: indexPath.row)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
   
}
