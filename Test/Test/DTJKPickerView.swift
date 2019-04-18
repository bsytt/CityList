//
//  DTJKPickerView.swift
//  Test
//
//  Created by gaof on 2019/4/17.
//  Copyright © 2019 bsy. All rights reserved.
//

import UIKit
let isIPhoneX = kScreenHeight == 812 ? true : false

class DTJKPickerView: UIView {

    let backView = UIView()
    let cancelBtn = UIButton()
    let selectBtn = UIButton()
    
    let pickerView = UIPickerView()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        self.DTJK_initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func DTJK_initSubViews() {
    
        self.backView.backgroundColor = UIColor.white
        self.backView.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: 270)
        self.addSubview(self.backView)
        
        self.cancelBtn.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        self.cancelBtn.setTitle("取消", for: UIControl.State.normal)
        self.cancelBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        self.backView.addSubview(self.cancelBtn)
        self.cancelBtn .addTarget(self, action: #selector(cancelClick), for: UIControl.Event.touchDown)
        
        self.selectBtn.frame = CGRect(x: self.frame.width-100, y: 0, width: 100, height: 40)
        self.selectBtn.setTitle("确定", for: UIControl.State.normal)
        self.selectBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.selectBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        self.backView.addSubview(self.selectBtn)
        self.selectBtn .addTarget(self, action: #selector(selectClick), for: UIControl.Event.touchDown)
        
        self.pickerView.backgroundColor = UIColor.clear
        self.backView.addSubview(self.pickerView)
        self.pickerView.frame = CGRect(x: 0, y: 40, width: self.frame.width, height: 230)
        
//        self.pickerView.showsSelectionIndicator = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dissmis))
        self.addGestureRecognizer(tap)
    }
    
    func show()  {
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.3) {
            self.backgroundColor = UIColor(white: 0, alpha: 0.4)
            if isIPhoneX{
                self.backView.transform = CGAffineTransform(translationX: 0, y: -320)
            }else{
                self.backView.transform = CGAffineTransform(translationX: 0, y: -270)
            }
//
        }
    }
    @objc func dissmis()  {
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundColor = UIColor(white: 0, alpha: 0)
            self.backView.transform = CGAffineTransform.identity
        }) { (success) in
            self.removeFromSuperview()
        }
    }
    
    @objc func cancelClick() {
        self.dissmis()

    }
    @objc func selectClick() {
        
    }
}
