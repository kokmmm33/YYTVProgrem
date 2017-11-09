//
//  CJPageContentView.swift
//  YYTV
//
//  Created by 蔡杰 on 2017/11/9.
//  Copyright © 2017年 Joseph. All rights reserved.
//

import UIKit


let kCellIdentifier = "cellIndent"

class CJPageContentView: UIView {
    
    private let childVcs : [UIViewController]
    private let partnerVc : UIViewController
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self , forCellWithReuseIdentifier: kCellIdentifier)
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.scrollsToTop = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    init(frame : CGRect, childVcs : [UIViewController], partnerVc : UIViewController) {

        
        self.childVcs = childVcs
        self.partnerVc = partnerVc
        
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CJPageContentView {
    private func setupUI() {
        
        for chidVc in childVcs {
            partnerVc.addChildViewController(chidVc)
        }
        
        addSubview(collectionView)
        
    }
    
}

extension CJPageContentView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellIdentifier, for: indexPath)
        
        for sub in cell.contentView.subviews {
            sub.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.row]
        childVc.view.frame = self.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
    
}


