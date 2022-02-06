//
//  CollectionViewController.swift
//  Elections
//
//  Created by Vladimir Bulakhov on 30/04/2020.
//  Copyright © 2020 Vladimir Bulakhov. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    var citizen : Citizen?
    
    var arrayOfCadnidates = Candidate.fillArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let itemsPerRow = CGFloat(2)
        let paddingWidth = CGFloat(20 * (itemsPerRow + 1))
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        view.backgroundColor = .systemBlue
        collectionView.backgroundColor = .systemTeal
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.itemSize = CGSize(width: widthPerItem, height: widthPerItem+113)
            layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
            layout.minimumLineSpacing = 20
            layout.minimumInteritemSpacing = 20
            layout.scrollDirection = .vertical
        
            collectionView.showsVerticalScrollIndicator = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let  ref = citizen?.ref
        ref?.observe(.value, with: { (snapshot) in
            let snapshotValue = snapshot.value as? [String : AnyObject] ?? [:]
            guard let name = snapshotValue["name"],let surname = snapshotValue["surname"],let numberOfPassport = snapshotValue["numberOfPassport"], let vote = snapshotValue["isCitizenVoted"] else {return}
            let nameOfCitizen = name as! String
            let surnameOfCitizen = surname as! String
            let numberOfPasspot = numberOfPassport as! String
            let isVoted = vote as! Bool
            let citizen = Citizen(name: nameOfCitizen, surname: surnameOfCitizen, numberOfPassport: numberOfPasspot, isCitizenVoted: isVoted, ref: ref)
            self.citizen = citizen
        })
    }

   
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return arrayOfCadnidates.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "candidateCell", for: indexPath) as! CollectionViewCell
    
        cell.imageView.image = UIImage(named: arrayOfCadnidates[indexPath.item].image)
        cell.shortName.text = arrayOfCadnidates[indexPath.item].shortName
        cell.backgroundColor = .systemGray5
        cell.indexpath = indexPath
        cell.dropShadow()
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
    
        return cell
    }
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "candidateView"{
            let candidateVC = segue.destination  as! CandidateViewController
            let cell = sender as! CollectionViewCell
            
            candidateVC.SelectedCanidate = arrayOfCadnidates[cell.indexpath!.item]
            candidateVC.citizen = citizen
            
        }
        
    }
}

fileprivate extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        //layer.shadowOffset = .zero
        layer.shadowRadius = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
