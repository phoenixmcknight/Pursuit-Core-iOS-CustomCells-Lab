//
//  RandomCollectionViewCell.swift
//  PeopleAndAppleStockPrices
//
//  Created by Phoenix McKnight on 10/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class RandomCollectionViewCell: UICollectionViewCell {
    
    var nameLabel:UILabel = {
        
        var myLabel = UILabel()
        
        return myLabel
        
    }()
    
    var randomImage:UIImageView = {
        var myImage = UIImageView()
       myImage.layer.cornerRadius = myImage.frame.height / 2
              myImage.layer.masksToBounds = true
              myImage.layer.borderWidth = 0
        return myImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setUpview()
        constraints()
        
    }
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    func setUpview() {
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(randomImage)
    }
    func constraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
              nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
              nameLabel.bottomAnchor.constraint(equalTo: self.randomImage.topAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        
        randomImage.translatesAutoresizingMaskIntoConstraints = false
                     randomImage.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor).isActive = true
        randomImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
                     randomImage.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
          }
        
    }
   
    

