
import Foundation
import UIKit

class AddOldPersonVC: UIViewController {
    
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
    
    
    lazy var nameField: TextFieldConfig = {
        var view = TextFieldConfig()
        view.title = "Name"
        view.placeHolder = "Name"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var adressField: TextFieldConfig = {
        var view = TextFieldConfig()
       
        view.title = "Adress"
        view.placeHolder = "Adress"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var timeField: TextFieldConfig = {
        var view = TextFieldConfig()
        view.title = "Visiting time"
        view.placeHolder = "00:00"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()


    var button: UIButton = {
        var label = UIButton(frame: .zero)
        label.clipsToBounds = true
        label.setTitle("Add a service", for: .normal)
        label.setTitleColor(.white, for: .normal)
        label.titleLabel?.font =   UIFont.systemFont(ofSize: 18, weight: .bold)
        label.backgroundColor = AgedColor.blue
       
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 22.5
        return label
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
    
    var saveButton: UIButton = {
        var label = UIButton(frame: .zero)
        label.clipsToBounds = true
        label.setTitle("Save", for: .normal)
        label.setTitleColor(.white, for: .normal)
        label.titleLabel?.font =   UIFont.systemFont(ofSize: 18, weight: .bold)
        label.backgroundColor = .gray
        label.isEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 22.5
        return label
    }()
    
    var services = [String]()
    let defaults = UserDefaults.standard
    private var tableViewHeight: NSLayoutConstraint?
    lazy var timepickerView: UIDatePicker = {
        var picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.tag = 1
        picker.frame.size = CGSize(width: 0, height: 250)
        return picker
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
        view.backgroundColor = AgedColor.bgColor
        title = "Add a mentee"
        nameField.textField.delegate = self
        adressField.textField.delegate = self
        timeField.textField.delegate = self
//        imageDescrioptionView.textView.delegate = self
        setupScrollView()
        tableView.delegate = self
        tableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
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
        
        
        setupConstraints()
        timeField.textField.inputView = timepickerView
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        timepickerView.addTarget(self, action: #selector(chooseDay), for: .valueChanged)
        timepickerView.addTarget(self, action: #selector(exitt), for: .editingDidEnd)
        }
    
    @objc func exitt(){
        self.timeField.textField.resignFirstResponder()
    }
    
    @objc func chooseDay(_ sender: UIDatePicker){
  
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            timeField.textField.text = formatter.string(from: sender.date)
        nextButtonEnabled()
    }
   
    
    @objc func buttonTap(_ sender: UIButton){
        let vc = TaskVC()
       
        vc.callbackService = { (service) in
            self.services = service
            self.tableView.reloadData()
            self.nextButtonEnabled()
            self.tableViewHeight?.constant = self.tableView.contentSize.height + 30
        }
        navigationController?.pushViewController(vc, animated: true)
       
           
    }
    
  
    
    @objc func save(){
        saveOrder()
        navigationController?.popViewController(animated: true)
       
    }
 
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
  
 
    @objc func keyboardWillShow(notification:NSNotification) {

        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification) {

        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tableViewHeight?.constant = self.tableView.contentSize.height + 30
    }
    
    
    func nextButtonEnabled(){
        saveButton.isEnabled = nameField.textField.text != "" && timeField.textField.text != "" && adressField.textField.text != "" && services.count > 0
        saveButton.backgroundColor = button.isEnabled ? AgedColor.red : .gray
    }
    
  
    
    private func saveOrder(){
   
        guard let name = nameField.textField.text, name != "" else {return}
        guard let adress = adressField.textField.text, adress != "" else {return}
        guard let time = timeField.textField.text, time != "" else {return}
     
        var i = UserDefaults.standard.value(forKey: "agedLength") as? Int ?? 0
        i+=1

        defaults.setValue(i, forKey: "agedLength")
 
      
        defaults.setValue(name, forKey: "\(i) name")
        defaults.setValue(adress, forKey: "\(i) adress")
        defaults.setValue(time, forKey: "\(i) time")
        
        for index in 0...services.count-1 {
            defaults.setValue(services[index],  forKey: "\(i) \(index) service name")
        }
       
        defaults.setValue(i, forKey: "\(i) id")
        defaults.setValue(services.count, forKey: "\(i) servicesLenghth")

    }
    
    
  
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollStackViewContainer)
        scrollStackViewContainer.addSubview(nameField)
        scrollStackViewContainer.addSubview(adressField)
        scrollStackViewContainer.addSubview(timeField)
        scrollStackViewContainer.addSubview(tableView)
        scrollStackViewContainer.addSubview(saveButton)
        scrollStackViewContainer.addSubview(button)
     
       
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
            nameField.heightAnchor.constraint(equalToConstant: 80),
           
           
         
            adressField.heightAnchor.constraint(equalToConstant: 80),
            adressField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 16),
            adressField.leadingAnchor.constraint(equalTo: scrollStackViewContainer.leadingAnchor, constant: 16),
            adressField.trailingAnchor.constraint(equalTo: scrollStackViewContainer.trailingAnchor, constant: -16),
            
            timeField.heightAnchor.constraint(equalToConstant: 80),
            timeField.topAnchor.constraint(equalTo: adressField.bottomAnchor, constant: 16),
            timeField.leadingAnchor.constraint(equalTo: scrollStackViewContainer.leadingAnchor, constant: 16),
            timeField.trailingAnchor.constraint(equalTo: scrollStackViewContainer.trailingAnchor, constant: -16),
            
            
          
            
            button.heightAnchor.constraint(equalToConstant: 50),
            button.topAnchor.constraint(equalTo: timeField.bottomAnchor, constant: 16),
            button.leadingAnchor.constraint(equalTo: scrollStackViewContainer.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: scrollStackViewContainer.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: scrollStackViewContainer.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: scrollStackViewContainer.trailingAnchor, constant: 0),
            
            
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16),
            saveButton.leadingAnchor.constraint(equalTo: scrollStackViewContainer.leadingAnchor, constant: 16),
            saveButton.trailingAnchor.constraint(equalTo: scrollStackViewContainer.trailingAnchor, constant: -16),
            saveButton.bottomAnchor.constraint(equalTo: scrollStackViewContainer.bottomAnchor, constant: -26),
           
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


extension AddOldPersonVC: UITextFieldDelegate {
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = ""
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, text != "" else {return true}
        nextButtonEnabled()
       
        self.view.endEditing(true)
        return true
    }
    
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nextButtonEnabled()
       
        self.view.endEditing(true)
    }
}

extension AddOldPersonVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell") as! TaskCell
        cell.button.isHidden = true
        cell.titleLabel.text = services[indexPath.row]
//        cell.callback = {
//            self.openDetails(at: indexPath.row)
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
  
            let deleteAction = UIContextualAction(style: .destructive, title: nil, handler: { [weak self] (_, _, completionHandler) in
                guard let self else { return }
               
                services.remove(at: indexPath.row)
                tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
               
            })
            
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            deleteAction.backgroundColor = #colorLiteral(red: 0.9529605508, green: 0.9624274373, blue: 0.9988391995, alpha: 0)
            deleteAction.image = UIImage(systemName: "trash.fill")
            return configuration
    }
}
