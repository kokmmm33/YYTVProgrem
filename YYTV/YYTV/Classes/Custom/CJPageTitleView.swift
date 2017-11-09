//
//  CJPageTitleView.swift
//  YYTV
//
//  Created by 蔡杰 on 2017/11/9.
//  Copyright © 2017年 Joseph. All rights reserved.
//

import UIKit

class CJPageTitleView: UIView {
    
    private let titles : [String]
    private let style : CJPageViewStyle
    private lazy var titleLables : [UILabel] = [UILabel]()
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.scrollsToTop = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
        
    }()
    

    init(frame : CGRect, titles : [String], style : CJPageViewStyle) {
        self.titles = titles
        self.style = style
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CJPageTitleView {
    private func setupUI() {
        addSubview(scrollView)
        
        for (i, title) in titles.enumerated() {
            let lable = UILabel()
            lable.text = title
            lable.font = UIFont.systemFont(ofSize: style.titleFont)
            lable.textColor = style.nomalColor
            lable.textAlignment = .center
            lable.tag = i
            scrollView.addSubview(lable)
            titleLables.append(lable)
        }
        
        setupLableFrame()
        
        
        scrollView.contentSize = style.scrollEnable ? CGSize(width: titleLables.last!.frame.maxX + style.itemMargin * 0.5, height: bounds.height) : CGSize.zero
        titleLables.first!.textColor = style.selectedColor
    }
    
    private func setupLableFrame() {
        var x : CGFloat = 0.0
        let y : CGFloat = 0.0
        var w : CGFloat = 0.0
        let h : CGFloat = self.bounds.height
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: 0)
        
        for (i, lable) in titleLables.enumerated() {
            if style.scrollEnable {
                w = (titles[i] as NSString).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : lable.font], context: nil).width
                if i == 0 {
                    x = style.itemMargin * CGFloat(0.5)
                }else {
                    x = style.itemMargin + titleLables[i - 1].frame.maxX
                }
                
                
            }else {
                w = bounds.width / CGFloat(titles.count)
                x = w * CGFloat(i)
            }
            
            lable.frame = CGRect(x: x, y: y, width: w, height: h)
        }
        
        
        
    }
    
}
