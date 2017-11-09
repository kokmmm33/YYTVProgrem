//
//  CJPageView.swift
//  YYTV
//
//  Created by 蔡杰 on 2017/11/9.
//  Copyright © 2017年 Joseph. All rights reserved.
//

import UIKit

class CJPageView: UIView {
    
    fileprivate let titles : [String]
    fileprivate let childVcs : [UIViewController]
    fileprivate let partnerVc : UIViewController
    fileprivate var titleView : CJPageTitleView!
    fileprivate let style : CJPageViewStyle

    init(frame : CGRect, titles : [String], childViewControllers: [UIViewController], partnerVc : UIViewController, style : CJPageViewStyle) {
        self.titles = titles
        self.childVcs = childViewControllers
        self.partnerVc = partnerVc
        self.style = style
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK:- 设置UI界面
extension CJPageView {
    private func setupUI() {
        setupTitleView()
        setupContentView()
    }
    
}

extension CJPageView {
    private func setupTitleView() {
        let frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: style.itemHeight)
        
        titleView = CJPageTitleView(frame: frame, titles: titles, style:style)
        titleView.backgroundColor = UIColor.randomColor()
        addSubview(titleView)
    }
    
}

extension CJPageView {
    private func setupContentView() {
        let frame = CGRect(x: 0, y: titleView.bounds.height, width: self.bounds.width, height: self.bounds.height - titleView.bounds.height)
        
        let contentView = CJPageContentView(frame: frame, childVcs: childVcs, partnerVc: partnerVc)
        addSubview(contentView)
    }
    
}
