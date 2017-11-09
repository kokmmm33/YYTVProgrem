//
//  HomeViewController.swift
//  YYTV
//
//  Created by 蔡杰 on 2017/11/9.
//  Copyright © 2017年 Joseph. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    

}

extension HomeViewController {
    private func setupUI() {
        view.backgroundColor = UIColor.randomColor()
        setupPageView()
    }
    
}

extension HomeViewController {
    private func setupPageView() {
        
        let titles = ["娱乐", "游戏", "游戏", "唱歌"]
         //let titles = ["娱乐", "游戏", "游戏游戏游戏", "唱歌", "表演","娱乐", "游戏", "游戏游戏游戏", "唱歌", "表演"]
        var chilVcs = [UIViewController]()
        for _ in 0 ..< titles.count {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.randomColor()
            chilVcs.append(vc)
        }
        
        let frame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height)
        let style = CJPageViewStyle()
        style.scrollEnable = false
        let pageView = CJPageView(frame: frame, titles: titles, childViewControllers: chilVcs, partnerVc:self, style : style)
        view.addSubview(pageView)
    }
}
