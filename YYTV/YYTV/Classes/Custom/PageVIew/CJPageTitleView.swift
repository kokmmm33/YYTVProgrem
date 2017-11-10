//
//  CJPageTitleView.swift
//  YYTV
//
//  Created by 蔡杰 on 2017/11/9.
//  Copyright © 2017年 Joseph. All rights reserved.
//

import UIKit

protocol CJTitleViewDelegate : class {
 
    func titleLableClick(index : Int)
}

class CJPageTitleView: UIView {
    weak var delegate : CJTitleViewDelegate?
    private let titles : [String]
    private let style : CJPageViewStyle
    private var lastClickIndex : Int = 0
    
    private lazy var titleLables : [UILabel] = [UILabel]()
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.scrollsToTop = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
        
    }()
    private lazy var bottomLine : UIView = {
        let line = UIView()
        line.backgroundColor = self.style.bottomLineColor
        line.isHidden = !self.style.showBottomLine
        return line
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
            
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLableClick(_:)))
            lable.addGestureRecognizer(tapGes)
            lable.isUserInteractionEnabled = true
            
            scrollView.addSubview(lable)
            titleLables.append(lable)
        }
        setupLableFrame()
        
        scrollView.addSubview(bottomLine)
        let y = self.style.itemHeight - self.style.bottomLineHeight
        let x = titleLables.first!.frame.minX
        let w = titleLables.first!.frame.width
        bottomLine.frame = CGRect(x: x, y: y, width: w, height: self.style.bottomLineHeight)

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

extension CJPageTitleView {
    @objc fileprivate func titleLableClick(_ tapGes : UIGestureRecognizer) {
        let curLable = tapGes.view as! UILabel
        let curIndex = curLable.tag
        adjustTitleLableFrame(targetIndex: curIndex)
        delegate?.titleLableClick(index: curIndex)
    }
    
    fileprivate func adjustTitleLableFrame(targetIndex : Int) {
        if targetIndex == lastClickIndex {
            return
        }
        let lastLable = titleLables[lastClickIndex]
        let curLable = titleLables[targetIndex]
        
        curLable.textColor = style.selectedColor
        lastLable.textColor = style.nomalColor
        lastClickIndex = targetIndex
        
        if style.scrollEnable {
            let curCenterX = curLable.frame.midX
            var offset = curCenterX - scrollView.bounds.width * 0.5
            if offset < 0 {
                offset = 0
            }
            if offset > scrollView.contentSize.width - scrollView.bounds.width {
                offset = scrollView.contentSize.width - scrollView.bounds.width
            }
            scrollView.setContentOffset( CGPoint(x: offset, y: 0), animated: true)
        }
        
        bottomLine.frame.origin.x = titleLables[targetIndex].frame.minX
        bottomLine.frame.size.width = titleLables[targetIndex].frame.width
    }
}


extension CJPageTitleView : CJPageContentViewDelegate {
    func pageContentViewScrollToIndex(index: Int) {
        adjustTitleLableFrame(targetIndex: index)
    }
}
