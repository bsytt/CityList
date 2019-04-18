//
//  ViewController.swift
//  Test
//
//  Created by gaof on 2019/4/17.
//  Copyright © 2019 bsy. All rights reserved.
//

import UIKit
//屏幕宽度
let kScreenWidth = UIScreen.main.bounds.size.width
//屏幕高度
let kScreenHeight = UIScreen.main.bounds.size.height
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let categoryPikerView = DTJKDataSourecePickerView(frame: CGRect.init(x: 0, y: 0, width:kScreenWidth, height: kScreenHeight))
            categoryPikerView.successBlock = { [weak self](province,city,county) in
               print(province,city,county)
            }
        categoryPikerView.show()
    }
}

