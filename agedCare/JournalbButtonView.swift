import Foundation


import UIKit


class JournalbButtonView: UIButton {
    
    var nameLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.font =  UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.text = "View visit log"
        label.minimumScaleFactor = 0.5
        label.textColor = AgedColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var imageV: UIImageView = {
        var label = UIImageView(frame: .zero)
        label.image = .listIcon
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
  
   
    override init(frame: CGRect) {
           super.init(frame: frame)
           self.initial()
           self.layout()
        clipsToBounds = true
       
       }

       required init(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    func initial(){
        self.layer.cornerRadius = 25
        self.addSubview(nameLabel)
        self.addSubview(imageV)
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            imageV.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            imageV.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageV.widthAnchor.constraint(equalToConstant: 40),
            imageV.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: imageV.trailingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
