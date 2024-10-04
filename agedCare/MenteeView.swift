
import Foundation


import UIKit


class MenteeView: UIView {
    
    var titleLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.font =  UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .center
        label.minimumScaleFactor = 0.5
        label.textColor = .white
        label.text = "Information"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var nameLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.font =  UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.minimumScaleFactor = 0.5
        label.textColor = .white//AgedColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var adressLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.font =  UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .left
        label.minimumScaleFactor = 0.5
        label.textColor = .white//AgedColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var dateLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.font =  UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .left
        label.minimumScaleFactor = 0.5
        label.textColor =  .white//AgedColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var timeLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.font =  UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left
        label.textColor = .white//AgedColor.black
        label.text = "0 ml"
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
        self.addSubview(timeLabel)
        self.addSubview(dateLabel)
        self.addSubview(titleLabel)
        self.addSubview(adressLabel)
       
    }
    
  
   
    
    func layout() {
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
        ])
     
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
        ])
       
        
        NSLayoutConstraint.activate([
            adressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            adressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            adressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
        ])
        
       
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            dateLabel.topAnchor.constraint(equalTo: adressLabel.bottomAnchor, constant: 10),
        ])
        
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            timeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
        ])
        
       
        
        layer.cornerRadius = 30
    }
}
