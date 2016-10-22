//
//  ViewController.swift
//  2048
//
//  Created by 李恺林 on 16/3/13.
//  Copyright © 2016年 李恺林. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //定义主工作数组
    var GameTable = [
        [0,0,0,0],
        [0,0,0,0],
        [0,0,0,0],
        [0,0,0,0],
    ]
    
    
    //加载UILabel
    @IBOutlet weak var GT11: UILabel!
    @IBOutlet weak var GT12: UILabel!
    @IBOutlet weak var GT13: UILabel!
    @IBOutlet weak var GT14: UILabel!
    @IBOutlet weak var GT21: UILabel!
    @IBOutlet weak var GT22: UILabel!
    @IBOutlet weak var GT23: UILabel!
    @IBOutlet weak var GT24: UILabel!
    @IBOutlet weak var GT31: UILabel!
    @IBOutlet weak var GT32: UILabel!
    @IBOutlet weak var GT33: UILabel!
    @IBOutlet weak var GT34: UILabel!
    @IBOutlet weak var GT41: UILabel!
    @IBOutlet weak var GT42: UILabel!
    @IBOutlet weak var GT43: UILabel!
    @IBOutlet weak var GT44: UILabel!
    @IBOutlet weak var STEP: UILabel!
    @IBOutlet weak var SUM:  UILabel!
    @IBOutlet weak var BACKGROUNDCOLOR: UIView!
    
    var stepCount    = 0 //记录步数
    var highestScore = 0 //记录最高步数
    var ifMoved      = 0 //判断是否移动
    var ifGameOver   = 0 //判断游戏是否结束
    var backgroundColor = 50 //背景色变换参数
    
    //开始函数
    func BEGIN ()->() {
        for i in 0 ..< 4 {
            for j in 0 ..< 4 {
                GameTable[i][j] = 0
            }
        }
        RAM()
        backgroundColor = 50
        ifGameOver      = 0
        stepCount       = 0
        STEP.text = String(stepCount)
    }
    
    //计算最高分
    func summary ()-> (Int){
        var judgement = 1
        for i in 0 ..< 4 {
            var j = 0
            while j < 4 {
                if GameTable[i][j] > highestScore{
                    highestScore = GameTable[i][j]
                }
                    judgement *= GameTable[i][j]
                    j += 1
            }
        }
        return judgement
    }
    
    
    //随机函数产生
    func RAM () ->(Int){
        var k = 33
        var count : UInt32 = 0
        for i in 0 ..< 4 {
            var j = 0
            while j < 4 {
                if GameTable[i][j] == 0{
                    GameTable[i][j] = k
                    k += 1
                    count += 1
                }
                j += 1
            }
        }
                if k == 33{ //判断空格数目，如果没有空位，即为失败
                    let over = UIAlertController(title: "失败", message: "\nYou Have Died", preferredStyle: UIAlertControllerStyle.alert)
                    over.addAction(UIAlertAction(title: "再玩一次", style: .destructive, handler: nil))
                    self.present(over, animated: true, completion: nil)
                    BEGIN()
                }
                if k == 34{ //产生一个随机数
                    let u = arc4random_uniform(count) + 33
                    for i in 0 ..< 4 {
                        var j = 0
                        while j < 4 {
                            if GameTable[i][j] == Int(u){
                                GameTable[i][j] = arc4random_uniform(9) == 2 ? 2 :4
                            }
                            j += 1
                        }
                    }
                }
                if k > 34{ //产生两个空格数据
                    let u = arc4random_uniform(count) + 33
                    var v = arc4random_uniform(count) + 33
                    var t = 0
                    while t < 10000 {
                        if u == v{
                            v = arc4random_uniform(count) + 33
                        }
                        else{
                            break
                        }
                        t += 1
                    }
                    for i in 0 ..< 4 {
                        var j = 0
                        while j < 4 {
                            if GameTable[i][j] == Int(u) || GameTable[i][j] == Int(v){
                                GameTable[i][j] = arc4random_uniform(9) == 2 ? 4 : 2 //控制 2 和 4 产生的比例
                            }
                            j += 1
                        }
                    }
                
        }
        for i in 0 ..< 4 {
            var j = 0
            while j < 4 {
                if GameTable[i][j] > 32 && GameTable[i][j] < 64{
                    GameTable[i][j] = 0
                }
                j += 1
            }
        }
        return k;
    }
    
    //显示数字
    func SHOW (_ back : Int) -> (){
        GT11.text = (String(GameTable[0][0]) == "0") ? "" : String(GameTable[0][0])
        GT12.text = (String(GameTable[0][1]) == "0") ? "" : String(GameTable[0][1])
        GT13.text = (String(GameTable[0][2]) == "0") ? "" : String(GameTable[0][2])
        GT14.text = (String(GameTable[0][3]) == "0") ? "" : String(GameTable[0][3])
        GT21.text = (String(GameTable[1][0]) == "0") ? "" : String(GameTable[1][0])
        GT22.text = (String(GameTable[1][1]) == "0") ? "" : String(GameTable[1][1])
        GT23.text = (String(GameTable[1][2]) == "0") ? "" : String(GameTable[1][2])
        GT24.text = (String(GameTable[1][3]) == "0") ? "" : String(GameTable[1][3])
        GT31.text = (String(GameTable[2][0]) == "0") ? "" : String(GameTable[2][0])
        GT32.text = (String(GameTable[2][1]) == "0") ? "" : String(GameTable[2][1])
        GT33.text = (String(GameTable[2][2]) == "0") ? "" : String(GameTable[2][2])
        GT34.text = (String(GameTable[2][3]) == "0") ? "" : String(GameTable[2][3])
        GT41.text = (String(GameTable[3][0]) == "0") ? "" : String(GameTable[3][0])
        GT42.text = (String(GameTable[3][1]) == "0") ? "" : String(GameTable[3][1])
        GT43.text = (String(GameTable[3][2]) == "0") ? "" : String(GameTable[3][2])
        GT44.text = (String(GameTable[3][3]) == "0") ? "" : String(GameTable[3][3])
        
        self.GT11.backgroundColor = CHANGE(GT11.text!)
        self.GT12.backgroundColor = CHANGE(GT12.text!)
        self.GT13.backgroundColor = CHANGE(GT13.text!)
        self.GT14.backgroundColor = CHANGE(GT14.text!)
        self.GT21.backgroundColor = CHANGE(GT21.text!)
        self.GT22.backgroundColor = CHANGE(GT22.text!)
        self.GT23.backgroundColor = CHANGE(GT23.text!)
        self.GT24.backgroundColor = CHANGE(GT24.text!)
        self.GT31.backgroundColor = CHANGE(GT31.text!)
        self.GT32.backgroundColor = CHANGE(GT32.text!)
        self.GT33.backgroundColor = CHANGE(GT33.text!)
        self.GT34.backgroundColor = CHANGE(GT34.text!)
        self.GT41.backgroundColor = CHANGE(GT41.text!)
        self.GT42.backgroundColor = CHANGE(GT42.text!)
        self.GT43.backgroundColor = CHANGE(GT43.text!)
        self.GT44.backgroundColor = CHANGE(GT44.text!)
        
        //如果空格过少，背景色变色警告
        self.BACKGROUNDCOLOR.backgroundColor = (back <= 36) ? ((back <= 34) ? UIColor(red: 215/255, green: 155/255, blue: 254/255, alpha: 1) : UIColor(red: 242/255, green: 187/255, blue: 254/255, alpha: 1)) : UIColor(red: 254/255, green: 247/255, blue: 196/255, alpha: 1)
    }
    
    //据显示数字进行变色
    func CHANGE(_ name:String)->UIColor{
        var col = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.000)
        switch name{
            case "2":
            col = UIColor(red: 255/255, green: 168/255, blue: 156/255, alpha: 1)
            case "4":
            col = UIColor(red: 255/255, green: 132/255, blue: 127/255, alpha: 1)
            case "8":
            col = UIColor(red: 255/255, green: 103/255, blue: 115/255, alpha: 1)
            case "16":
            col = UIColor(red: 255/255, green: 78/255,  blue: 95/255,  alpha: 1)
            case "32":
            col = UIColor(red: 255/255, green: 70/255,  blue: 74/255,  alpha: 1)
            case "64":
            col = UIColor(red: 216/255, green: 42/255,  blue: 71/255,  alpha: 1)
            case "128":
            col = UIColor(red: 255/255, green: 52/255,  blue: 121/255, alpha: 1)
            case "256":
            col = UIColor(red: 197/255, green: 120/255, blue: 188/255, alpha: 1)
            case "512":
            col = UIColor(red: 230/255, green: 179/255, blue: 255/255, alpha: 1)
            case "1024":
            col = UIColor(red: 168/255, green: 126/255, blue: 255/255, alpha: 1)
            case "2048":
            col = UIColor(red: 139/255, green: 85/255,  blue: 255/255, alpha: 1)
        default:
            break

        }
        return col
    }
    
    //主运行函数
    override func viewDidLoad() {
        super.viewDidLoad()
        //判断滑动方向
        ARight.addTarget(self, action: #selector(ViewController.SRight))
        ARight.direction = UISwipeGestureRecognizerDirection.right
        Right.addGestureRecognizer(ARight)
        Right.isUserInteractionEnabled = true
        
        ALeft.addTarget(self, action: #selector(ViewController.SLeft))
        ALeft.direction = UISwipeGestureRecognizerDirection.left
        Left.addGestureRecognizer(ALeft)
        Left.isUserInteractionEnabled = true
        
        AUp.addTarget(self, action: #selector(ViewController.SUp))
        AUp.direction = UISwipeGestureRecognizerDirection.up
        Up.addGestureRecognizer(AUp)
        Up.isUserInteractionEnabled = true
        
        ADown.addTarget(self, action: #selector(ViewController.SDown))
        ADown.direction = UISwipeGestureRecognizerDirection.down
        Down.addGestureRecognizer(ADown)
        Down.isUserInteractionEnabled = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //向右滑
    @IBOutlet var Right: UIView!
    let ARight = UISwipeGestureRecognizer()
    func SRight(){
        for i in 0 ..< 4 {
            var j = 3
            while j > 0 {
                if GameTable[i][j] == GameTable[i][j-1] && GameTable[i][j] != 0{
                    GameTable[i][j] *= 2
                    ifMoved = 1
                    if j > 1 {
                        GameTable[i][j-1] = GameTable[i][j-2]
                        if j>2 {
                            GameTable[i][j-2] = GameTable[i][j-3]
                            GameTable[i][j-3] = 0
                        }
                        else {
                            GameTable[i][j-2] = 0
                        }
                    }
                    else{
                        GameTable[i][j-1] = 0
                    }
                    j = j+1
                }
                if j < 4{
                    if GameTable[i][j] == 0{
                        var ADD = 0
                        var k = j
                        while k >= 0 {
                            ADD += GameTable[i][k]
                            k -= 1
                        }
                        if ADD != 0{
                            ifMoved = 1
                            GameTable[i][j] = GameTable[i][j-1]
                            if j > 1 {
                                GameTable[i][j-1] = GameTable[i][j-2]
                                if j>2 {
                                    GameTable[i][j-2] = GameTable[i][j-3]
                                    GameTable[i][j-3] = 0
                                }
                                else {
                                    GameTable[i][j-2] = 0
                                }
                            }
                            else{
                                GameTable[i][j-1] = 0
                            }
                            j = j+1
                            if j == 2 || j == 3 {
                                j += 1
                            }
                        }
                    }
                }
                j -= 1
            }
        }
        if ifMoved == 1 {
            backgroundColor = RAM()
            ifGameOver = summary()
            SUM.text = String(highestScore)
            STEP.text = String(stepCount)
            stepCount += 1
        }
        else {
            if ifGameOver != 0 {
                let over = UIAlertController(title: "失败", message: "\nYou Have Died", preferredStyle: UIAlertControllerStyle.alert)
                over.addAction(UIAlertAction(title: "再玩一次", style: .destructive, handler: nil))
                self.present(over, animated: true, completion: nil)
                BEGIN()
            }
        }
        if stepCount == 0 {
            BEGIN()
        }
        ifMoved = 0
        SHOW(backgroundColor)
    }
    
    //向左滑
    @IBOutlet var Left: UIView!
    let ALeft = UISwipeGestureRecognizer()
    func SLeft(){
        for i in 0 ..< 4 {
            var j = 0
            while j < 3 {
                if GameTable[i][j] == GameTable[i][j+1] && GameTable[i][j] != 0{
                    GameTable[i][j] *= 2
                    ifMoved = 1
                    if j < 2 {
                        GameTable[i][j+1] = GameTable[i][j+2]
                        if j < 1 {
                            GameTable[i][j+2] = GameTable[i][j+3]
                            GameTable[i][j+3] = 0
                        }
                        else {
                            GameTable[i][j+2] = 0
                        }
                    }
                    else {
                        GameTable[i][j+1] = 0
                    }
                    j = j-1
                }
                if j > -1 {
                    if GameTable[i][j] == 0{
                        var ADD = 0
                        var k = j
                        while k <= 3 {
                            ADD += GameTable[i][k]
                            k += 1
                        }
                        if ADD != 0{
                            ifMoved = 1
                            GameTable[i][j] = GameTable[i][j+1]
                            if j < 2 {
                                GameTable[i][j+1] = GameTable[i][j+2]
                                if j < 1 {
                                    GameTable[i][j+2] = GameTable[i][j+3]
                                    GameTable[i][j+3] = 0
                                }
                                else {
                                    GameTable[i][j+2] = 0
                                }
                            }
                            else{
                                GameTable[i][j+1] = 0
                            }
                            j = j-1
                            if j == 0 || j == 1{
                                j -= 1
                            }
                        }
                    }
                }
                j += 1
            }
        }
        if ifMoved == 1 {
            backgroundColor = RAM()
            ifGameOver = summary()
            SUM.text = String(highestScore)
            STEP.text = String(stepCount)
            stepCount += 1
        }
        else {
            if ifGameOver != 0 {
                let over = UIAlertController(title: "失败", message: "\nYou Have Died", preferredStyle: UIAlertControllerStyle.alert)
                over.addAction(UIAlertAction(title: "再玩一次", style: .destructive, handler: nil))
                self.present(over, animated: true, completion: nil)
                BEGIN()
            }
        }
        if stepCount == 0 {
            BEGIN()
        }
        ifMoved = 0
        SHOW(backgroundColor)
    }
    
    //向上滑动
    @IBOutlet var Up: UIView!
    let AUp = UISwipeGestureRecognizer()
    func SUp(){
        for j in 0 ..< 4 {
            var i = 0
            while i < 3 {
                if GameTable[i][j] == GameTable[i+1][j] && GameTable[i][j] != 0{
                    GameTable[i][j] *= 2
                    ifMoved = 1
                    if i < 2 {
                        GameTable[i+1][j] = GameTable[i+2][j]
                        if i < 1 {
                            GameTable[i+2][j] = GameTable[i+3][j]
                            GameTable[i+3][j] = 0
                        }
                        else {
                            GameTable[i+2][j] = 0
                        }
                    }
                    else{
                        GameTable[i+1][j] = 0
                    }
                    i = i-1
                }
                if i > -1{
                    if GameTable[i][j] == 0{
                        var ADD = 0
                        var k = i
                        while k <= 3 {
                            ADD += GameTable[k][j]
                            k += 1
                        }
                        if ADD != 0{
                            ifMoved = 1
                            GameTable[i][j] = GameTable[i+1][j]
                            if i < 2 {
                                GameTable[i+1][j] = GameTable[i+2][j]
                                if i < 1 {
                                    GameTable[i+2][j] = GameTable[i+3][j]
                                    GameTable[i+3][j] = 0
                                }
                                else {
                                    GameTable[i+2][j] = 0
                                }
                            }
                            else{
                                GameTable[i+1][j] = 0
                            }
                            i = i-1
                            if i == 0 || i == 1{
                                i -= 1
                            }
                        }
                    }
                }
                i += 1
            }
        }
        if ifMoved == 1 {
            backgroundColor = RAM()
            ifGameOver = summary()
            SUM.text = String(highestScore)
            STEP.text = String(stepCount)
            stepCount += 1
        }
        else {
            if ifGameOver != 0 {
                let over = UIAlertController(title: "失败", message: "\nYou Have Died", preferredStyle: UIAlertControllerStyle.alert)
                over.addAction(UIAlertAction(title: "再玩一次", style: .destructive, handler: nil))
                self.present(over, animated: true, completion: nil)
                BEGIN()
            }
        }
        if stepCount == 0 {
            BEGIN()
        }
        ifMoved = 0
        SHOW(backgroundColor)
    }
    
    //向下滑动
    @IBOutlet var Down: UIView!
    let ADown = UISwipeGestureRecognizer()
    func SDown(){
        for j in 0 ..< 4 {
            var i = 3
            while i > 0 {
                if GameTable[i][j] == GameTable[i-1][j] && GameTable[i][j] != 0{
                    GameTable[i][j] *= 2
                    ifMoved = 1
                    if i > 1 {
                        GameTable[i-1][j] = GameTable[i-2][j]
                        if i > 2 {
                            GameTable[i-2][j] = GameTable[i-3][j]
                            GameTable[i-3][j] = 0
                        }
                        else {
                            GameTable[i-2][j] = 0
                        }
                    }
                    else{
                        GameTable[i-1][j] = 0
                    }
                    i = i + 1
                }
                if i < 4{
                    if GameTable[i][j] == 0{
                        var ADD = 0
                        var k = i
                        while k >= 0 {
                            ADD += GameTable[k][j]
                            k -= 1
                        }
                        if ADD != 0{
                            ifMoved = 1
                            GameTable[i][j] = GameTable[i-1][j]
                            if i > 1 {
                                GameTable[i-1][j] = GameTable[i-2][j]
                                if i > 2 {
                                    GameTable[i-2][j] = GameTable[i-3][j]
                                    GameTable[i-3][j] = 0
                                }
                                else {
                                    GameTable[i-2][j] = 0
                                }
                            }
                            else{
                                GameTable[i-1][j] = 0
                            }
                            i = i+1
                            if i == 2 || i == 3{
                                i += 1
                            }
                        }
                    }
                }
                i -= 1
            }
        }
        if ifMoved == 1 {
            backgroundColor = RAM()
            ifGameOver = summary()
            SUM.text = String(highestScore)
            STEP.text = String(stepCount)
            stepCount += 1
        }
        else {
            if ifGameOver != 0 {
                let over = UIAlertController(title: "失败", message: "\nYou Have Died", preferredStyle: UIAlertControllerStyle.alert)
                over.addAction(UIAlertAction(title: "再玩一次", style: .destructive, handler: nil))
                self.present(over, animated: true, completion: nil)
                BEGIN()
            }
        }
        if stepCount == 0 {
            BEGIN()
        }
        ifMoved = 0
        SHOW(backgroundColor)
    }

}

