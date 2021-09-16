import UIKit

class WeatherVC: UIViewController {
    @IBOutlet weak var forecastCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        forecastCollectionView.dataSource = self
    }
}

//MARK: - UICollectionView DataSource Methods
//extension WeatherVC: UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 7
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = UICollectionViewCell()
//        cell.backgroundColor = UIColor.white
//        return cell
//    }
//}

