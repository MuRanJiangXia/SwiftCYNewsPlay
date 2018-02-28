//
//  ViewController.swift
//  SwiftCYNewsPlay
//
//  Created by cyan on 2018/2/28.
//  Copyright © 2018年 cyan. All rights reserved.
//

import UIKit

// 屏幕宽度
 let  MainScreenWidth = UIScreen.main.bounds.width
// 屏幕高度
 let MainScreenHeight  = UIScreen.main.bounds.height

class ViewController: UIViewController,UIScrollViewDelegate {
    //静态变量
    struct MyClassConstants{
        static let testStr = "test"
        static let arrayOfTests: [String] = ["foo", "bar", testStr]
        static let baseTag:Int = 20180228
    }
    /*
     var listVCQueue : NSMutableArray!
     声明一个 数组 但是没有创建
     
     var listVCQueue2 = NSMutableArray()
     声明并且创建一个数组
     
     */
    //存储showVC字典
    var listVCQueue : NSMutableDictionary!
    //记录当前选择的tag
    var btnTag :Int!
    //头部按钮背景视图
    var topBgView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.showScrollView)
        addListVCWithIndex(index: 0)
        topView()
    
    }
    
    //创建头部按钮
    func topView(){
        
        let arr:Array = ["新鲜事","简单点","温柔"]
        topBgView = UIView.init(frame: CGRect(x: 0, y: 0, width: MainScreenWidth, height: 50))
        topBgView.backgroundColor = UIColor.white
        self.view.addSubview(topBgView)
        
        let width = MainScreenWidth/3
        //for 循环
        for (index,value) in arr.enumerated(){
            //创建button
            let button = UIButton(type: UIButtonType.custom)
            button.frame = CGRect(x: width * CGFloat(index), y: 0, width: width, height: 50)
            button.setTitle(value, for: UIControlState.normal)
            button.setTitleColor(UIColor.black, for: UIControlState.normal)
            button.setTitleColor(UIColor.init(red: 66/255.0, green: 164/255.0, blue: 182/255.0, alpha: 1), for: UIControlState.selected)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.tag = MyClassConstants.baseTag + index
            button.addTarget(self, action:#selector(topAction(btn:)), for: UIControlEvents.touchUpInside)
            topBgView.addSubview(button)
            if index == 0{
                btnTag = MyClassConstants.baseTag + index
                button.isSelected = true
            }
        }
    }
   
   @objc func topAction(btn:UIButton)  {
       btn.isSelected = true
    if btnTag != 0 && btnTag != btn.tag{
        let preBtn:UIButton = topBgView.viewWithTag(btnTag) as! UIButton
        preBtn.isSelected = !preBtn.isSelected
       }
    let point = CGPoint(x: CGFloat(btn.tag - MyClassConstants.baseTag) * MainScreenWidth , y: showScrollView.contentOffset.y )
      showScrollView.setContentOffset(point, animated: true)
      btnTag = btn.tag
    }
    
    //懒加载 showScrollview
    lazy var showScrollView:UIScrollView = {
        () -> UIScrollView in
        let showScrollView = UIScrollView()
        showScrollView.frame = CGRect(x: 0, y: 50, width: MainScreenWidth, height: MainScreenHeight - 50)
        showScrollView.backgroundColor = UIColor.groupTableViewBackground
        showScrollView.contentSize = CGSize(width: MainScreenWidth * 3, height: 50)
        showScrollView.indicatorStyle = UIScrollViewIndicatorStyle.black
        showScrollView.bounces = true
        showScrollView.isPagingEnabled = true
        showScrollView.delegate = self
        return showScrollView
    }()
    
    
    
    // MARK: - scrollViewDelegate
    //手动滑动
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        showScrollView.isHidden = false
        scrollBy(scrollView: scrollView)
    }
    //代码移动
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        showScrollView.isHidden = false
        scrollBy(scrollView: scrollView)
    }
    // MARK: - 滑动到指定位置，改变button选中效果
    func scrollBy(scrollView : UIScrollView) {
        let row:Int = Int((scrollView.contentOffset.x + MainScreenWidth/2)/MainScreenWidth)
        
        //根据页数添加相应的视图
        addListVCWithIndex(index: row)
        //上一个btn
        let button:UIButton = topBgView.viewWithTag(btnTag) as! UIButton
        button.isSelected = false
        //当前选中btn
        btnTag = row + MyClassConstants.baseTag
        let button1:UIButton = topBgView.viewWithTag(btnTag) as!UIButton
        button1.isSelected = true
        
    }
    // MARK: - 添加VC 到队列
    func addListVCWithIndex(index : Int){
        if listVCQueue == nil{
            listVCQueue = NSMutableDictionary()
        }
        //根据页数添加相应视图 并存入数组
        if listVCQueue.object(forKey: String(index)) == nil {
            let contentVC = CYShowViewController()
            self.addChildViewController(contentVC)
            contentVC.view.left = CGFloat(index) * MainScreenWidth
            contentVC.view.top = 0
            showScrollView.addSubview(contentVC.view)
            listVCQueue.setValue(contentVC, forKey: String(index))
            
        }else{
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

