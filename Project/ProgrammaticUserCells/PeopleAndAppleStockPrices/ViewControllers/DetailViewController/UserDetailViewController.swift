//
//  DetailViewControllerOne.swift
//  PeopleAndAppleStockPrices
//
//  Created by Phoenix McKnight on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit

class DetailViewControllerOne:UIViewController {
    var passingInfo:Results!
    var rgbColor = RGBValue()
    var randomColor:UIColor!
    
    
    lazy var name:UILabel = {
        let userName = UILabel()
        return userName
    }()
    lazy var emailAddressLabel:UILabel = {
        let email = UILabel()
        return email
    }()
    
    lazy var profilePic: UIImageView = {
        let profilePic = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
        return profilePic
    }()
    
    lazy var dateOfBirth: UILabel = {
        let DOB = UILabel()
        return DOB
    }()
    
    lazy var stackView:UIStackView = {
        
        return createStackView()
    
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(profilePic)
        self.view.addSubview(stackView)
        setUpConstraints()
        setUpDetailVC()
    }
    func createStackView() -> UIStackView {
        let stacky = UIStackView(arrangedSubviews: [profilePic,name,dateOfBirth,emailAddressLabel])
        
        stacky.axis = .vertical
        stacky.distribution = .fillEqually
        stacky.alignment = .fill
        stacky.spacing = 25
        stacky.translatesAutoresizingMaskIntoConstraints = false
        
        return stacky
    }
    
    func setUpDetailVC() {
        name.text = passingInfo.name.getName()
        emailAddressLabel.text = passingInfo.email
        dateOfBirth.text = passingInfo.dob.date
        ImageHelper.shared.getImage(urlStr: passingInfo.picture.large) {
            (results) in
            DispatchQueue.main.async {
                switch results {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    self.profilePic.image = image
                }
            }
        }
        navigationItem.title = "User Information"
        setUpColors()
    }
    func setUpColors() {
        navigationController?.navigationBar.backgroundColor = randomColor
        view.backgroundColor = randomColor
        
    }
    
    func setUpConstraints() {

        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }


}
