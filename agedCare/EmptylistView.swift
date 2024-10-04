import Foundation
import UIKit


class EmptylistView: UIView {
  
    lazy var firstImage: UIImageView = {
       var view = UIImageView()
        view.image = UIImage(named: "care2")
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var titleLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.font =  UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.textColor = .white
        label.text = "The list is empty"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var smallLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "Click on the + button to add a new student"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
       override init(frame: CGRect) {
           super.init(frame: frame)
           self.initial()
           self.layout()
       }

       required init(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    private func initial(){
       
        self.backgroundColor = .white
        self.addSubview(firstImage)
        self.addSubview(titleLabel)
        self.addSubview(smallLabel)
        layer.cornerRadius = 35

    }
    
    private func layout() {
        
        NSLayoutConstraint.activate([
            firstImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            firstImage.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            firstImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            firstImage.heightAnchor.constraint(equalToConstant: 200),
        ])
        firstImage.layer.cornerRadius = 20
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: firstImage.bottomAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            smallLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            smallLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            smallLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
}

