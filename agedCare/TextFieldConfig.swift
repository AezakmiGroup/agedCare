import Foundation

import UIKit


class TextFieldConfig: UIView {
    
    var titleLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.font =  UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .left
        label.textColor = AgedColor.black
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var textField: UITextField = {
        var textField = MyTextField.shared.createTextField(title: "Message")
        textField.layer.borderWidth = 0
        textField.backgroundColor = .white
        textField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        textField.autocorrectionType = .yes
        textField.spellCheckingType = .yes
        textField.attributedPlaceholder = NSAttributedString(
            string: "Placeholder Text",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.5)]
        )
       
        return textField
    }()
    
    var title: String! {
        didSet{
            titleLabel.text = title
        }
    }
    
    var placeHolder: String! {
        didSet{
            textField.placeholder = placeHolder
        }
    }

   
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           self.initial()
           self.layout()
        textField.leftView =  UIView(frame: CGRect(x: 16, y: 16, width: 24, height: 24))
       }

       required init(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    func initial(){
      
        self.addSubview(titleLabel)
        self.addSubview(textField)
        
    }
   
    
    func layout() {
        
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
        ])
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 45),
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
        ])
    }
}


class MyTextField {
    
   static let shared = MyTextField()
    
    func createTextField (title: String) -> UITextField {
        let textField =  UITextField()
        textField.placeholder = title
        textField.textColor = AgedColor.black
        textField.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done // done
        textField.clearsOnBeginEditing = true
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 15
        textField.leftViewMode = .always
        textField.autocorrectionType = .yes
        textField.spellCheckingType = .yes
    
        return textField
    }
}
