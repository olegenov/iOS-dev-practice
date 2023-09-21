//
//  ViewController.swift
//  nakitaevPW1
//
//  Created by Никита on 18.09.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet var views: [UIView]!
    
    // MARK: Function activates on complited view load.
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Function changes color and border radius on button pressed.
    
    @IBAction func buttonWasPressed(_ sender: Any) {
        for view in views {
            changeColor(view: view)
            changeCornerReduis(view: view)
        }
    }
    
    // MARK: Function returns a random color.
    
    func getUniqueColor() -> UIColor {
        var color = UIColor(
                red: .random(in: 0...1),
                green: .random(in: 0...1),
                blue: .random(in: 0...1),
                alpha: 1
            )
        
        return color
    }
    
    // MARK: Function changes view's color.
    
    func changeColor(view: UIView) {
        view.backgroundColor = getUniqueColor()
    }
    
    // MARK: Function changes view's border radius.
    
    func changeCornerReduis(view: UIView, maxRadius: CGFloat = 25) {
        view.layer.cornerRadius = .random(in: 0...maxRadius)
    }
}

