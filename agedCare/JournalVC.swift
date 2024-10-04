
import UIKit

class JournalVC: UIViewController {
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 40 , height: 40)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(JournalCell.self, forCellWithReuseIdentifier: "JournalCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
   
    var services: [[Service]]!

    override func viewDidLoad() {
        super.viewDidLoad()
      
        view.backgroundColor = AgedColor.bgColor
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
       configureConstraints()
    }
    
    func setupNavigationBar(){
        title = "Visit log"

        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.barTintColor = AgedColor.bgColor
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.tintColor = AgedColor.black
 
        self.navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: AgedColor.black,
            NSAttributedString.Key.font: UIFont(name: AgesConst.font, size: 30) ?? UIFont.systemFont(ofSize: 30, weight: .bold)
            ]
            self.navigationController?.navigationBar.titleTextAttributes =  [
                NSAttributedString.Key.foregroundColor: AgedColor.black,
                NSAttributedString.Key.font:  UIFont(name: AgesConst.font, size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        setupNavigationBar()
        collectionView.reloadData()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func collectionLayout() -> UICollectionViewFlowLayout {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left:0, bottom: 0, right: 0)
        let width = UIScreen.main.bounds.width / 2
        let height = 70.0
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = 0
      
        layout.scrollDirection = .vertical
        return layout
    }

}

extension JournalVC {
    
    func configureConstraints(){
        collectionView.collectionViewLayout = collectionLayout()
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,  constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


extension JournalVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return services.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "JournalCell", for: indexPath) as! JournalCell
        cell.titleLabel.text = services[indexPath.row].last!.date
      return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let vc = VisitLogVC()
        vc.services = services[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

