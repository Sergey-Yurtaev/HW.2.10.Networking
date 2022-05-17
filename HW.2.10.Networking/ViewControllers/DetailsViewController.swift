//
//  DetailsViewController.swift
//  HW.2.10.Networking
//
//  Created by Sergey Yurtaev on 29.04.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var namePlanetLabel: UILabel!
    @IBOutlet weak var velocityLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var planetDetail: Planets!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
        activityIndicator.color = .green
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "space.jpeg")
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    private func setupLabels() {
        namePlanetLabel.text = planetDetail.name ?? "No Info"
        velocityLabel.text = "Orbital speed - \(planetDetail.velocity ?? "No Info") km/s"
        distanceLabel.text = "Distance to the Sun - \(planetDetail.distance ?? "No Info") million km"
        descriptionLabel.text = planetDetail.description ?? "No Info"
        
        DispatchQueue.global().async { //убираем задержку при переходе. выводим в глобальный поток. (ассинхронно) сначала экран а потом загрузка картинок
            guard let imageData = ImageManager.shared.fetchImage(from: self.planetDetail.image) else { return }
            
            DispatchQueue.main.async {  //обновляем интерфейс в основном потоке. (ассинхронно)
                self.activityIndicator.stopAnimating()
                self.imageView.image = UIImage(data: imageData)
            }
        }
    }
}

