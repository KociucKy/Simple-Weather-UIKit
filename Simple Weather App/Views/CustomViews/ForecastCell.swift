import UIKit

class ForecastCell: UICollectionViewCell {
    //MARK: - Properites
    static let reuseID = "ForecastCell"
    
    
    //MARK: - UI Elements
    let container           = UIView()
    let dateLabel           = UILabel()
    let timeLabel           = UILabel()
    let weatherImage        = UIImageView()
    let temperatureLabel    = UILabel()
    
    //MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Methods
    func configure(){
        //Temporary dummy data
        dateLabel.text          = "21 Jan 2021"
        timeLabel.text          = "01:00 AM"
        weatherImage.image      = UIImage(systemName: "sun.max")
        temperatureLabel.text   = "21 °C"
        
        let elements = [dateLabel, timeLabel, weatherImage, temperatureLabel]
        self.addSubview(container)
        
        for element in elements {
            container.addSubview(element)
            element.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                element.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
                element.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8),
            ])
        }
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            container.heightAnchor.constraint(equalTo: self.heightAnchor),
            container.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            dateLabel.heightAnchor.constraint(equalToConstant: 12),
            
            timeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            timeLabel.heightAnchor.constraint(equalToConstant: 12),
            
            weatherImage.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10),
            weatherImage.heightAnchor.constraint(equalToConstant: 50),
            
            temperatureLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 10),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 12),
            
        ])
    }
}
