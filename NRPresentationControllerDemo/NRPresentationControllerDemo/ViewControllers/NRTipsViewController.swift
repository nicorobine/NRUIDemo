//
//  NRTipsViewController.swift
//  NRPresentationControllerDemo
//
//  Created by NicoRobine on 2020/12/1.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

import UIKit

class NRTipsViewController: UIViewController {

    final let tips: String
    
    final var textView: UITextView!
    
    init(with tips: String) {
        self.tips = tips
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView = UITextView(frame: CGRect(origin: CGPoint(x: 100.0, y: 100.0), size: CGSize(width: 100.0, height: 100.0)))
        textView.text = tips
        view.addSubview(textView)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
