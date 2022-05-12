//
//  MainCollectionViewController.swift
//  HW.2.10.Networking
//
//  Created by Sergey Yurtaev on 30.04.2022.
//

import UIKit

class MainCollectionViewController: UICollectionViewController {
    
    let urlPlanetInfo = "https://raw.githubusercontent.com/Lazzaro83/Solar-System/master/planets.json"
    
    private var planets: [Planets] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNetworkData()
        collectionView.backgroundView = UIImageView(image: UIImage(named: "space.jpeg"))
        
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return planets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PlanetCell
        cell.planetName.text = planets[indexPath.item].name
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
        let planet = planets[indexPath.row]
        let detailsVC = segue.destination as! DetailsViewController
        detailsVC.planetDetail = planet
    }
}

extension MainCollectionViewController {
    private func setNetworkData() {
        NetworkManager.shared.fetchData(from: urlPlanetInfo) { info in
            DispatchQueue.main.async {
                self.planets = info
                self.collectionView.reloadData()
            }
        }
    }
}

extension MainCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 40, height: 80)
    }
}


