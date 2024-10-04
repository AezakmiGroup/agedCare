import Foundation
import UIKit

class MainCell: UITableViewCell {
    
    

    var titleLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.font = UIFont(name: AgesConst.font, size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .bold)//
        label.textAlignment = .left
        label.textColor = AgedColor.black
         label.minimumScaleFactor = 0.7
         label.adjustsFontSizeToFitWidth = true
         label.numberOfLines = 0
         label.sizeToFit()
         label.text = "Task njn nn"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var moneyLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.font =  UIFont.systemFont(ofSize: 18)//UIFont(name: Constants.detourne, size: 25)
        label.textAlignment = .left
        label.textColor =  .gray
        label.text = "cndjc cd bschdb cdbchksd cdsbc"
         label.minimumScaleFactor = 0.7
         label.adjustsFontSizeToFitWidth = true
         label.numberOfLines = 0
         label.sizeToFit()
      
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var frameView: ShadowView = {
       var view = ShadowView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var smallView: UIImageView = {
       var view = UIImageView()
        view.tintColor = AgedColor.red
        view.image = UIImage(systemName: "chevron.forward")
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var old: Aged! {
        didSet {
            titleLabel.text = old.name
            moneyLabel.text = old.adress
        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
//        frameView.addGradient()
    }
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(frameView)
        frameView.addSubview(titleLabel)
        frameView.addSubview(smallView)
        frameView.addSubview(moneyLabel)
        selectionStyle = .none
        backgroundColor = .clear
        configureConstarints()
       
       
    }
    override func layoutSubviews() {
        super.layoutSubviews()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureConstarints() {
    
        NSLayoutConstraint.activate([
           frameView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            frameView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
           frameView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
           frameView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
        ])
       
        frameView.layer.cornerRadius = 15
      
        
        NSLayoutConstraint.activate([
           titleLabel.leadingAnchor.constraint(equalTo: frameView.leadingAnchor, constant: 15),
           titleLabel.trailingAnchor.constraint(equalTo: smallView.leadingAnchor, constant: -5),
           titleLabel.topAnchor.constraint(equalTo: frameView.topAnchor, constant: 5),
        ])
        
        NSLayoutConstraint.activate([
           moneyLabel.leadingAnchor.constraint(equalTo: frameView.leadingAnchor, constant: 15),
           moneyLabel.trailingAnchor.constraint(equalTo: smallView.leadingAnchor, constant: -5),
           moneyLabel.bottomAnchor.constraint(equalTo: frameView.bottomAnchor, constant: -5),
        ])
        
       
        
        NSLayoutConstraint.activate([
            smallView.widthAnchor.constraint(equalToConstant: 30),
            smallView.heightAnchor.constraint(equalToConstant: 30),
            smallView.centerYAnchor.constraint(equalTo: frameView.centerYAnchor),
            smallView.trailingAnchor.constraint(equalTo: frameView.trailingAnchor, constant: -15),
        ])
      
   }
  
}
