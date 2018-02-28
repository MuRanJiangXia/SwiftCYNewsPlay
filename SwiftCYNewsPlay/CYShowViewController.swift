//
//  CYShowViewController.swift
//  SwiftCYNewsPlay
//
//  Created by cyan on 2018/2/28.
//  Copyright © 2018年 cyan. All rights reserved.
//

import UIKit

class CYShowViewController: UIViewController {

    var randomColor: UIColor {
        get {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = randomColor
        creatUI()
        
    }
    
    func creatUI (){
        let view = UIView()
        view.backgroundColor = UIColor.red
        self.view.addSubview(view)
     
    
        let label  = UILabel()
        label.backgroundColor = UIColor.white
        label.text = "我是label"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = NSTextAlignment.center
        self.view.addSubview(label)
        
        view.mas_makeConstraints { (make : MASConstraintMaker!) in
            make.top.mas_equalTo()(10)
            make.width.equalTo()(self.view)
            make.height.mas_equalTo()(60)
            
        }
        label.mas_makeConstraints { (make : MASConstraintMaker!) in
            make.top.equalTo()(view.mas_bottom)?.offset()(10)
            make.left.equalTo()(view)
            make.right.equalTo()(view)
            make.height.mas_equalTo()(50)
        }
       
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
