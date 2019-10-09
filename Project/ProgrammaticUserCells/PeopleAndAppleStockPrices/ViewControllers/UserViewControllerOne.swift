//
//  ViewControllerOne.swift
//  PeopleAndAppleStockPrices
//
//  Created by Phoenix McKnight on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit

class RandomUserViewController:UIViewController {
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    var cellSpacing = UIScreen.main.bounds.width * 0.05

   lazy var collectionView: UICollectionView = {
    let theCollectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
    theCollectionView.backgroundColor = .white

    theCollectionView.dataSource = self
    theCollectionView.delegate = self
       
    theCollectionView.register(RandomCollectionViewCell.self, forCellWithReuseIdentifier: "randomCell")
       
         return theCollectionView
     }()
    
    
    
    
    var rgbColor = RGBValue()
    var randomUser = [Results]() {
        didSet {
            DispatchQueue.main.async {
               
                self.collectionView.reloadData()
              
        }
        }
    }
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(collectionView)
        colorGenerator()
        setConstraints()
        getData()
        
    }
  private func getData() {
         UserAPIClient.shared.getUsers { (results) in
             switch results {
             case .success(let user):
                 self.randomUser =  user.sorted(by: {$0.name.first < $1.name.first})
             case .failure(let failure):
                 print("could not retrieve Data \(failure)")
             }
         }
     }
    func setConstraints() {
           self.collectionView.translatesAutoresizingMaskIntoConstraints = false
               self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
               self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
               self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
               self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
             }
}

extension RandomUserViewController: UICollectionViewDelegate{}

    


extension RandomUserViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return randomUser.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "randomCell", for: indexPath) as? RandomCollectionViewCell {
            
            let randomUserPath = randomUser[indexPath.row]
            cell.nameLabel.text = randomUserPath.name.getName()
           
            ImageHelper.shared.getImage(urlStr: randomUserPath.picture.large) { (results) in
                DispatchQueue.main.async {
                    switch results {
                    case .failure(let error):
                        print(error)
                    case .success(let image):
                        cell.randomImage.image = image
                    }
                }
    }
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
   
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         
        let detailVC = DetailViewControllerOne()
        
        detailVC.passingInfo = randomUser[indexPath.row]
                   
                   colorGenerator()
        detailVC.randomColor = collectionView.backgroundColor
        
        navigationController?.pushViewController(detailVC, animated: true)

                
    }
    
    func colorGenerator(){
        let rgbColor = RGBValue()
          
        navigationController?.navigationBar.backgroundColor = rgbColor.createRGBColor()
        collectionView.backgroundColor = rgbColor.createRGBColor()
      }
      
        }
    
    
    
      
//        self.navigationItem.title = "Contacts"
//        colorGenerator()
        
    
  



extension RandomUserViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numCells: CGFloat = 3
        let numSpaces: CGFloat = numCells + 1
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        return CGSize(width: (screenWidth - (cellSpacing * numSpaces)) / numCells, height: screenHeight * 0.25)
    }
}
