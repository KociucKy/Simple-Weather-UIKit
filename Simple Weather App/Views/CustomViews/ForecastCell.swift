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
        dateLabel.textColor                 = UIColor(named: "PrimaryColor")
        timeLabel.textColor                 = UIColor(named: "PrimaryColor")
        temperatureLabel.textColor          = UIColor(named: "PrimaryColor")
        dateLabel.textAlignment             = .center
        timeLabel.textAlignment             = .center
        temperatureLabel.textAlignment      = .center
        weatherImage.tintColor    = UIColor(named: "PrimaryColor")
        weatherImage.contentMode        = .scaleAspectFit
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let elements = [dateLabel, timeLabel, weatherImage, temperatureLabel]
        contentView.addSubview(container)
        
        for element in elements {
            container.addSubview(element)
            element.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                element.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
                element.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8),
            ])
        }
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            container.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
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
