import Foundation

import UIKit

class JournalCell: UICollectionViewCell {
  
    var titleLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.font =  UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .center
        label.textColor = AgedColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var frameView: ShadowView = {
        var view = ShadowView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
  
    func configConsztraints (){
    
        
        NSLayoutConstraint.activate([
            frameView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            frameView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            frameView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            frameView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
       
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: frameView.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: frameView.leadingAnchor, constant: 5),
        ])
    }
   
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        contentView.addSubview(frameView)
        contentView.addSubview(titleLabel)
        configConsztraints()
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
