//
//  DTJKDataSourecePickerView.swift
//  Test
//
//  Created by gaof on 2019/4/17.
//  Copyright © 2019 bsy. All rights reserved.
//

import UIKit

typealias DataSourceSuccessBlock = (String,String,String)->()
class DTJKDataSourecePickerView: DTJKPickerView {

    private var index = 0
    private var indexNext = 0
    private var indexLast = 0
    var successBlock : DataSourceSuccessBlock?
    
    lazy var dataSourece: NSMutableArray = {
        let arr = NSMutableArray()
        return arr
    }()
    lazy var citys: NSMutableArray = {
        let arr = NSMutableArray()
        return arr
    }()
    lazy var countys: NSMutableDictionary = {
        let arr = NSMutableDictionary()
        return arr
    }()
    override func DTJK_initSubViews() {
        super.DTJK_initSubViews()
        self.readCityPlist()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self

    }
    override func selectClick() {
        let province = self.dataSourece .object(at: index) as! Test.DTJKCityModel
        let city = self.citys.object(at: index) as! NSArray
        let model = city[indexNext] as! DTJKModel
        let countyDic = self.countys .object(forKey: model.city!) as! NSDictionary
        var county = ""
        if countyDic.count > 0 {
            let countyArr = countyDic.object(forKey: model.city!) as! NSArray
            county = countyArr .object(at: indexLast) as! String
        }
        if (self.successBlock != nil) {
            self.dissmis()
            self.successBlock?(province.state,model.city!,county)
        }
    }
    func readCityPlist() -> Void {
        let cityPlist = Bundle.main.path(forResource: "area", ofType: "plist")
        let citys = NSArray(contentsOfFile: cityPlist!)
        for dic in citys! {
            let d = dic as! NSDictionary
            let model = DTJKCityModel(dic: d)
            self.dataSourece.add(model)
        }
        for model in self.dataSourece {
            let m = model as! DTJKCityModel
            let cits = NSMutableArray()
            for dic in m.cities {
                let model = DTJKModel(dic:dic as! NSDictionary)
                cits .add(model)
            }
            self.citys .add(cits)
        }
        for countys in self.citys {
            let arr = countys as! NSArray
            for model in arr {
                let m = model as! DTJKModel
                let areas = NSMutableDictionary()
                let county = NSMutableArray()
                for dic in m.areas {
                    let d = dic as! NSDictionary
                    county.add(d["county"] as! String)
                    areas.setObject(county, forKey: m.city! as NSCopying)
                }
                self.countys.setObject(areas, forKey: m.city! as NSCopying)
            }
        }
    }
    
}

extension DTJKDataSourecePickerView:UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return self.dataSourece.count
        }else if component == 1 {
            return (self.citys[index] as AnyObject).count
        }else {
            let category = self.citys[index] as! NSArray
            let citys = category[indexNext] as! DTJKModel
            let dic = self.countys .object(forKey: citys.city!) as! NSDictionary
            if dic.count > 0 {
                let values = dic.object(forKey: citys.city!) as! NSArray
                return values.count
            }
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0  {
            let categoryModel = self.dataSourece[row] as! DTJKCityModel
            return categoryModel.state!
        }else if component == 1 {
            let category = self.citys[index] as! NSArray
            let citys = category[row] as! DTJKModel
            return citys.city!
        }else {
//            county
            let category = self.citys[index] as! NSArray
            let citys = category[indexNext] as! DTJKModel
            let dic = self.countys .object(forKey: citys.city!) as! NSDictionary
            let values = dic.object(forKey: citys.city!) as! NSArray
            if values.count == 0{
                return " "
            }
            return (values .object(at: row) as! String)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            index = row
            indexNext = 0
            pickerView.reloadComponent(1);
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 1, animated: false)
            pickerView.selectRow(0, inComponent: 2, animated: true)
        }else if component == 1{
            indexNext = row
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 2, animated: true)
        }else {
            indexLast = row
        }
        
    }
}
