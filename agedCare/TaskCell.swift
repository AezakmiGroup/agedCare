import Foundation
import UIKit

class TaskCell: UITableViewCell {
    
    

    var titleLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.font = UIFont(name: AgesConst.font, size: 19) ?? UIFont.systemFont(ofSize: 19)//
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
    
   
    lazy var frameView: ShadowView = {
       var view = ShadowView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var button: UIButton = {
       var view = UIButton()
        view.imageView?.tintColor = AgedColor.red
        view.setImage(UIImage(systemName: "circle"), for: .normal)
        view.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var callback: (()->Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        frameView.addGradient()
    }
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(frameView)
        frameView.addSubview(titleLabel)
        frameView.addSubview(button)
     
        selectionStyle = .none
        backgroundColor = .clear
        configureConstarints()
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
    }
    
    @objc func tap(_ sender: UIButton){
        print("mkmkmk")
        sender.isSelected.toggle()
        self.callback()
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
           titleLabel.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -5),
           titleLabel.centerYAnchor.constraint(equalTo: frameView.centerYAnchor),
        ])
        
       
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 38),
            button.heightAnchor.constraint(equalToConstant: 38),
            button.centerYAnchor.constraint(equalTo: frameView.centerYAnchor),
            button.trailingAnchor.constraint(equalTo: frameView.trailingAnchor, constant: -15),
        ])
   }
}

