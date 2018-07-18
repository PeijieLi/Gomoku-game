//
//  BoardView.swift
//  game
//
//  Created by Peijie Li on 4/30/18.
//  Copyright © 2018 Peijie Li. All rights reserved.
//

import UIKit

class BoardView: UIView {
    
    //Step One: Draw the Board
    let chessPiecesNumber = 19
    var blackorwhite = 1
    var chessarray = Array(repeating: Array(repeating: 0, count: 19), count: 19)
    var allchessview = Array<UIView>()
    var allchessposition = Array<(Int, Int)>()
    var textfield = UITextField()
    
    func start() {
        self.blackorwhite = 1
        var i = 0
        var j = 0
        while (i < 19) {
            while (j < 19) {
                self.chessarray[i][j] = 0
                j += 1
            }
            i += 1
        }
        
    }
    
    func check_win(positionx: Int, positiony: Int) -> Bool {
        //black = 1, white =2
        // check horizontal
        if (check_win_horizontal(positionx: positionx, positiony: positiony)) {
            return true
        }
        if (check_win_vertical(positionx: positionx, positiony: positiony)) {
            return true
        }
        if (check_win_diagonal(positionx: positionx, positiony: positiony)) {
            return true
        }
        return false
    }

    
    func check_win_diagonal(positionx: Int, positiony: Int) -> Bool {
        var count = 1
        
        var currx = positionx - 1
        var curry = positiony - 1
        while (currx >= 0 && curry >= 0 && chessarray[currx][curry] == blackorwhite) {
            count += 1
            currx = currx - 1
            curry = curry - 1
        }
        if (count >= 5) {
            return true
        }
        currx = positionx + 1
        curry = positiony + 1
        while (currx < 19 && curry < 19 && chessarray[currx][curry] == blackorwhite) {
            count += 1
            currx = currx + 1
            curry = curry + 1
        }
        if (count >= 5) {
            return true
        }
        
        currx = positionx + 1
        curry = positiony - 1
        count = 1
        while (currx < 19 && curry >= 0 && chessarray[currx][curry] == blackorwhite) {
            count += 1
            currx = currx + 1
            curry = curry - 1
        }
        if (count >= 5) {
            return true
        }
        currx = positionx - 1
        curry = positiony + 1
        while (currx >= 0 && curry < 19 && chessarray[currx][curry] == blackorwhite) {
            count += 1
            currx = currx - 1
            curry = curry + 1
        }
        if (count >= 5) {
            return true
        }
        return false
    }
    
    func check_win_horizontal(positionx: Int, positiony: Int) -> Bool {
        var count = 1
        
        var left = positionx-1
        while (left >= 0 && chessarray[left][positiony] == blackorwhite) {
            count += 1
            if (count >= 5) {
                return true
            }
            left = left - 1
        }
        var right = positionx + 1
        while (right < 19 && chessarray[right][positiony] == blackorwhite) {
            count += 1
            if (count >= 5) {
                return true
            }
            right = right + 1
        }
        return false
    }
    
    func check_win_vertical(positionx: Int, positiony: Int) -> Bool {
        var count = 1
        
        var lower = positiony-1
        while (lower >= 0) {
            if (chessarray[positionx][lower] == blackorwhite) {
                count += 1
                if (count >= 5) {
                    return true
                }
                lower = lower - 1
            } else {
                break
            }
        }
        var higher = positiony + 1
        while (higher < 19) {
            if (chessarray[positionx][higher] == blackorwhite) {
                count += 1
                if (count >= 5) {
                    return true
                }
                higher = higher + 1
            } else {
                break
            }
        }
        return false
    }
    
    func update_turn() {
        if (blackorwhite == 1) {
            textfield.placeholder = "White Turn"
        } else {
            textfield.placeholder = "Black Turn"
        }
        
    }
    
    func undo() {
        allchessview.popLast()?.isHidden = true
        update_turn()
        var lastaction: (Int, Int)
        lastaction = (allchessposition.popLast())!
        blackorwhite = chessarray[lastaction.0][lastaction.1]
        chessarray[lastaction.0][lastaction.1] = 0
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor(red: 240.0 / 255.0, green: 211.0 / 255.0, blue: 159.0 / 255.0, alpha: 1.0)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let context = UIGraphicsGetCurrentContext()
        let boardsize = Double(frame.size.width - 20)
        let interval = boardsize / Double(chessPiecesNumber - 1)
        context?.setLineWidth(1.0)
        
        
        for i in 0..<chessPiecesNumber {
            context?.move(to: CGPoint(x: 10, y: 10 + interval * Double(i)))
            context?.addLine(to: CGPoint(x: boardsize + 10,y: 10 + interval * Double(i)))
            context?.strokePath()
        }
        
        for i in 0..<chessPiecesNumber {
            context?.move(to: CGPoint(x: 10 + interval * Double(i), y: 10))
            context?.addLine(to: CGPoint(x: 10 + interval * Double(i), y: boardsize + 10))
            context?.strokePath()
        }
        for i in 0...2{
            for j in 0...2{
                context?.beginPath()
                context?.addArc(center: CGPoint(x:Double(3+6*i)*interval+0.5 * interval-0.5,y:Double(3+6*j)*interval+0.5 * interval-0.5), radius: 3, startAngle: 0, endAngle: CGFloat(2*Double.pi), clockwise: true)
                context?.strokePath()
            }
            
        }
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapBoard)))

        
    }
    
    func restart() {
        chessarray = Array(repeating: Array(repeating: 0, count: 19), count: 19)
        // how to init a new view?
        for each in subviews {
            each.isHidden = true
        }
        
    }
    @objc func tapBoard(tap: UITapGestureRecognizer) {
        let boardsize = Double(frame.size.width - 20)
        let interval = boardsize / Double(19 - 1)
        //black = 1, white = 2
        let point = tap.location(in: tap.view)
        var y = Int(floor((Double(lroundf(Float(Double(point.x - 10)/interval))) * interval+2 - 2) / ((386 - 2) / 19)))
        var x = Int(floor((Double(lroundf(Float(Double(point.y - 10)/interval))) * interval+2 - 2) / ((386 - 2) / 19)))
        if x == 19 {
            x = 18
        }
        if y == 19 {
            y = 18
        }
        if chessarray[x][y] == 0 {
            let chessView = UIView()
            
            let chesspoint = CGPoint(x: Double(lroundf(Float(Double(point.x - 10)/interval))) * interval+2, y: Double(lroundf(Float(Double(point.y - 10)/interval))) * interval + 2)
            
            chessView.frame = CGRect(origin: chesspoint,
                                     size: CGSize(width: Double(15), height: Double(15)))
            chessView.layer.cornerRadius = 7.5
            chessarray[x][y] = blackorwhite
            allchessview.append(chessView)
            allchessposition.append((x, y))
            addSubview(chessView)
            update_turn()
            
            if (check_win(positionx: x, positiony: y)) {
                restart()
                if (blackorwhite == 1) {
                    let alert = UIAlertView(title: "Black Win", message: "Black has won!", delegate: self, cancelButtonTitle: "Restart")
                    alert.show()
                } else {
                    let alert = UIAlertView(title: "White Win", message: "White has won!", delegate: self, cancelButtonTitle: "Restart")
                    
                    alert.show()
                }
                
                // restart and set blackorwhite to 1
                blackorwhite = 1
                
            } else {
                if blackorwhite == 1{
                    chessView.backgroundColor = UIColor.black
                    blackorwhite = 2
                }else{
                    chessView.backgroundColor = UIColor.white
                    blackorwhite = 1
                }
            }
        }else{
            let alert = UIAlertView(title: "Error", message: "Position already been taken", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
    }
    
}
