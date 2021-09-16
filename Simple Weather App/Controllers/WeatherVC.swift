import UIKit

class WeatherVC: UIViewController {
    @IBOutlet weak var forecastTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forecastTableView.dataSource = self
        forecastTableView.delegate = self
    }
}

//MARK: - UITableView DataSource Methods
extension WeatherVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.white
        return cell
    }
}

//MARK: - UITableView Delegate Methods
extension WeatherVC: UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return CGFloat(150)
//    }
}
