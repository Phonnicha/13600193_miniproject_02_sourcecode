//
//  ViewController.swift
//  minipro13600193
//
//  Created by Phonnicha on 17/11/2561 BE.
//  Copyright © 2561 phonnichasilatong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Quiz"
        self.view.backgroundColor=UIColor.black
        
        setupViews()
    }
    
    @objc func btnGetStartedAction() {
        let v=QuizVC()
        self.navigationController?.pushViewController(v, animated: true)
    }
    var timer = Timer()
    var seconds = 30
    let MyLabel : UILabel = UILabel(frame: CGRect(x: 20, y: 20, width: 50, height: 50))
    
    func clock(){
        seconds = seconds - 1
        MyLabel.text = " หมดเวลาแล้ว"
        timer.invalidate()
    }
    
    func setupViews() {
        self.view.addSubview(lblTitle)
        lblTitle.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 230).isActive=true
        lblTitle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        lblTitle.widthAnchor.constraint(equalToConstant: 350).isActive=true
        lblTitle.heightAnchor.constraint(equalToConstant: 100).isActive=true
        
        self.view.addSubview(btnGetStarted)
        btnGetStarted.heightAnchor.constraint(equalToConstant: 50).isActive=true
        btnGetStarted.widthAnchor.constraint(equalToConstant: 150).isActive=true
        btnGetStarted.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        btnGetStarted.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 50).isActive=true
    }
    
    let lblTitle: UILabel = {
        let lbl=UILabel()
        lbl.text="FANPANTAE GOT7"
        lbl.textColor=UIColor.darkGray
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 34)
        lbl.numberOfLines=2
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let btnGetStarted: UIButton = {
        let btn=UIButton()
        btn.setTitle("Start", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor=UIColor.red
        btn.layer.cornerRadius=5
        btn.layer.masksToBounds=true
        btn.translatesAutoresizingMaskIntoConstraints=false
        btn.addTarget(self, action: #selector(btnGetStartedAction), for: .touchUpInside)
        return btn
    }()
}

