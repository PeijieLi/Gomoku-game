//
//  Gomoku.swift
//  game
//
//  Created by Peijie on 5/2/18.
//  Copyright © 2018 Peijie Li. All rights reserved.
//

import Foundation
import UIKit

class Gomoku {
    var gameEnd: Bool
    
    var backboard: BoardView
    
    init(board: BoardView) {
        self.gameEnd = true
        self.backboard = board
    }
    
    func check_win_diagonal(positionx: Int, positiony: Int) -> Bool {
        var count = 1
        
        var currx = positionx - 1
        var curry = positiony - 1
        while (currx >= 0 && curry >= 0 && backboard.chessarray[currx][curry] == backboard.blackorwhite) {
            count += 1
            currx = currx - 1
            curry = curry - 1
        }
        if (count >= 5) {
            return true
        }
        currx = positionx + 1
        curry = positiony + 1
        while (currx < 19 && curry < 19 && backboard.chessarray[currx][curry] == backboard.blackorwhite) {
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
        while (currx < 19 && curry >= 0 && backboard.chessarray[currx][curry] == backboard.blackorwhite) {
            count += 1
            currx = currx + 1
            curry = curry - 1
        }
        if (count >= 5) {
            return true
        }
        currx = positionx - 1
        curry = positiony + 1
        while (currx >= 0 && curry < 19 && backboard.chessarray[currx][curry] == backboard.blackorwhite) {
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
        while (left >= 0 && backboard.chessarray[left][positiony] == backboard.blackorwhite) {
            count += 1
            if (count >= 5) {
                return true
            }
            left = left - 1
        }
        var right = positionx + 1
        while (right < 19 && backboard.chessarray[right][positiony] == backboard.blackorwhite) {
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
            if (backboard.chessarray[positionx][lower] == backboard.blackorwhite) {
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
            if (backboard.chessarray[positionx][higher] == backboard.blackorwhite) {
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

    


//
//    @objc func tapBoard(tap: UITapGestureRecognizer) {
//        if (gameEnd == 1) {
//            return
//        }
//        let boardsize = Double(frame.size.width - 20)
//        let interval = boardsize / Double(19 - 1)
//        //black = 1, white =2
//        let point = tap.location(in: tap.view)
//        var y = Int(floor((Double(lroundf(Float(Double(point.x - 10)/interval))) * interval+2 - 2) / ((386 - 2) / 19)))
//        var x = Int(floor((Double(lroundf(Float(Double(point.y - 10)/interval))) * interval+2 - 2) / ((386 - 2) / 19)))
//        if x == 19 {
//            x = 18
//        }
//        if y == 19 {
//            y = 18
//        }
//        if chessarray[x][y] == 0{
//            let chessView = UIView()
//
//            let chesspoint = CGPoint(x: Double(lroundf(Float(Double(point.x - 10)/interval))) * interval+2, y: Double(lroundf(Float(Double(point.y - 10)/interval))) * interval + 2)
//
//            chessView.frame = CGRect(origin: chesspoint,
//                                     size: CGSize(width: Double(15), height: Double(15)))
//            chessView.layer.cornerRadius = 7.5
//            chessarray[x][y] = blackorwhite
//            addSubview(chessView)
//
//            print(check_win(positionx: x, positiony: y))
//            if (check_win(positionx: x, positiony: y)) {
//                if (blackorwhite == 1) {
//                    let alert = UIAlertView(title: "Black Win", message: "Black has won!", delegate: self, cancelButtonTitle: "Restart")
//                    alert.show()
//                } else {
//                    let alert = UIAlertView(title: "White Win", message: "White has won!", delegate: self, cancelButtonTitle: "Restart")
//
//                    alert.show()
//                }
//                gameEnd = 1
//
//                // restart and set blackorwhite to 1
//                //                blackorwhite = 1
//                //                restart()
//            } else {
//                if blackorwhite == 1{
//                    chessView.backgroundColor = UIColor.black
//                    blackorwhite = 2
//                }else{
//                    chessView.backgroundColor = UIColor.white
//                    blackorwhite = 1
//                }
//            }
//        }else{
//            let alert = UIAlertView(title: "Error", message: "Position already been taken", delegate: self, cancelButtonTitle: "OK")
//            alert.show()
//        }
//    }
//
//
    
}
