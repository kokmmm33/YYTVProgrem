//
//  WaterFlowLayout.swift
//  YYTV
//
//  Created by 蔡杰 on 2017/11/10.
//  Copyright © 2017年 Joseph. All rights reserved.
//

import UIKit

class WaterFlowLayout: UICollectionViewFlowLayout {
    var cols : Int = 3
    
    fileprivate lazy var layoutAttris : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    
    fileprivate lazy var colsheights : [CGFloat] = {
        return Array(repeating: self.sectionInset.top, count: self.cols)
    }()

}

extension WaterFlowLayout {
    override func prepare() {
        let count = collectionView!.numberOfItems(inSection: 0)
        var lowesIndex : Int = 0
        for i in 0..<count {
            let itemIndexPath = IndexPath(item: i, section: 0)
            
            var x : CGFloat = 0
            var y : CGFloat = 0
            let w : CGFloat = (collectionView!.bounds.width - sectionInset.left - sectionInset.right - minimumInteritemSpacing * 2) / CGFloat(cols)
            let h : CGFloat = CGFloat(arc4random_uniform(100)) + CGFloat(100)
     
            x = sectionInset.left + CGFloat(lowesIndex) * (w + minimumInteritemSpacing)
            y = colsheights.min()!
            
            let itemAttri = UICollectionViewLayoutAttributes(forCellWith: itemIndexPath)
            itemAttri.frame = CGRect(x: x, y: y, width: w, height: h)
            layoutAttris.append(itemAttri)
            
            colsheights[lowesIndex] = colsheights.min()! + h + minimumLineSpacing
            lowesIndex = colsheights.index(of: colsheights.min()!)!
            
            
        }
    }
}

extension WaterFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttris
        
    }
}

extension WaterFlowLayout {
    override var collectionViewContentSize: CGSize {
        
        return CGSize(width: collectionView!.bounds.width, height: colsheights.max()! + sectionInset.bottom)
    }
}
