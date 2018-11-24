//
//  AppDelegate.swift
//  minipro13600193
//
//  Created by Phonnicha on 17/11/2561 BE.
//  Copyright © 2561 phonnichasilatong. All rights reserved.
//


import UIKit

struct Question {
    let imgName: String
    let questionText: String
    let options: [String]
    let correctAns: Int
    var wrongAns: Int
    var isAnswered: Bool
}

class QuizVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var myCollectionView: UICollectionView!
    var questionsArray = [Question]()
    var score: Int = 0
    var currentQuestionNumber = 1
    var timer = Timer()
    
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Home"
        self.view.backgroundColor=UIColor.white
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        myCollectionView=UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), collectionViewLayout: layout)
        myCollectionView.delegate=self
        myCollectionView.dataSource=self
        myCollectionView.register(QuizCVCell.self, forCellWithReuseIdentifier: "Cell")
        myCollectionView.showsHorizontalScrollIndicator = false
        myCollectionView.translatesAutoresizingMaskIntoConstraints=false
        myCollectionView.backgroundColor=UIColor.white
        myCollectionView.isPagingEnabled = true
        
        self.view.addSubview(myCollectionView)
        
        
        let que1 = Question(imgName: "img1", questionText: "Got7 อยู่ค่ายเพลงของอะไร ?", options: ["JYP", "YG", "SM", "CUBE"], correctAns: 0, wrongAns: -1, isAnswered: false)
        let que2 = Question(imgName: "img2", questionText: "โชว์เคสแรกของวง Got7 วันที่เท่าไหร่ ?", options: ["3 ม.ค. 57", "5 ม.ค. 57", "10 ม.ค. 57", "15 ม.ค. 57"], correctAns: 3, wrongAns: -1, isAnswered: false)
        let que3 = Question(imgName: "img3", questionText: "Got7 เดบิวต์วันที่เท่าไหร่ ?", options: ["13 ม.ค. 57", "14 ม.ค. 57", "15 ม.ค. 57", "16 ม.ค. 57"], correctAns: 3, wrongAns: -1, isAnswered: false)
        let que4 = Question(imgName: "img4", questionText: "สมาชิกคนไหนชื่อเหมือน JYP ?", options: ["แจ็คสัน", "จินยอง", "เจบี", "ยองแจ"], correctAns: 1, wrongAns: -1, isAnswered: false)
        let que5 = Question(imgName: "img5", questionText: "สมาชิกคนไหนเป็นลีดเดอร์ของวง Got7 ?", options: ["เจบี", "มาร์ค", "จินยอง", "แบมแบม"], correctAns: 0, wrongAns: -1, isAnswered: false)
        let que6 = Question(imgName: "img6", questionText: "สมาชิกในวงคนไหนทำเกาอี้หักใน                          Got7 1st Fan Party In Bangkok ?", options: ["จินยอง", "แบมแบม", "เจบี", "ยองแจ"], correctAns: 2, wrongAns: -1, isAnswered: false)
        let que7 = Question(imgName: "img7", questionText: "Got7 1st Fan Party In Bangkok                                 จัดขึ้นวันที่เท่าไหร่?", options: ["12-13 มี.ค. 58", "13-14 มี.ค. 58", "14-15 มี.ค. 58", "15-16 มี.ค. 58"], correctAns: 2, wrongAns: -1, isAnswered: false)
        let que8 = Question(imgName: "img8", questionText: "Got7 มาเมืองไทยครั้งแรกวันที่เท่าไหร่ ?", options: ["22 ส.ค. 57", "23 ส.ค. 57", "24 ส.ค. 57", "25 ส.ค. 57"], correctAns: 0, wrongAns: -1, isAnswered: false)
        let que9 = Question(imgName: "img9", questionText: "สมาชิกคนไหนของวงเป็นคนไทย ?", options: ["จินยอง", "แบมแบม", "เจบี", "ยองแจ"], correctAns: 1, wrongAns: -1, isAnswered: false)
        let que10 = Question(imgName: "img10", questionText: "สมาชิกคนไหนเป็นน้องเล็กของวง Got7 ?", options: ["จินยอง", "แบมแบม", "ยูคยอม", "ยองแจ"], correctAns: 2, wrongAns: -1, isAnswered: false)
        
        questionsArray = [que1, que2, que3, que4, que5, que6, que7, que8, que9, que10]
        
        setupViews()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questionsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! QuizCVCell
        cell.question=questionsArray[indexPath.row]
        cell.delegate=self
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setQuestionNumber()
    }
    
    func setQuestionNumber() {
        let x = myCollectionView.contentOffset.x
        let w = myCollectionView.bounds.size.width
        let currentPage = Int(ceil(x/w))
        if currentPage < questionsArray.count {
            lblQueNumber.text = "Question: \(currentPage+1) / \(questionsArray.count)"
            currentQuestionNumber = currentPage + 1
        }
    }
    
    @objc func btnPrevNextAction(sender: UIButton) {
        if sender == btnNext && currentQuestionNumber == questionsArray.count {
            let v=ResultVC()
            v.score = score
            v.totalScore = questionsArray.count
            self.navigationController?.pushViewController(v, animated: false)
            return
        }
        
        let collectionBounds = self.myCollectionView.bounds
        var contentOffset: CGFloat = 0
        if sender == btnNext {
            contentOffset = CGFloat(floor(self.myCollectionView.contentOffset.x + collectionBounds.size.width))
            currentQuestionNumber += currentQuestionNumber >= questionsArray.count ? 0 : 1
        } else {
            contentOffset = CGFloat(floor(self.myCollectionView.contentOffset.x - collectionBounds.size.width))
            currentQuestionNumber -= currentQuestionNumber <= 0 ? 0 : 1
        }
        self.moveToFrame(contentOffset: contentOffset)
        lblQueNumber.text = "Question: \(currentQuestionNumber) / \(questionsArray.count)"
    }
    
    func moveToFrame(contentOffset : CGFloat) {
        let frame: CGRect = CGRect(x : contentOffset ,y : self.myCollectionView.contentOffset.y ,width : self.myCollectionView.frame.width,height : self.myCollectionView.frame.height)
        self.myCollectionView.scrollRectToVisible(frame, animated: true)
    }
    
    func setupViews() {
        myCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive=true
        myCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive=true
        myCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive=true
        myCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive=true
        
        self.view.addSubview(btnPrev)
        btnPrev.heightAnchor.constraint(equalToConstant: 50).isActive=true
        btnPrev.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive=true
        btnPrev.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive=true
        btnPrev.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive=true
        
        self.view.addSubview(btnNext)
        btnNext.heightAnchor.constraint(equalTo: btnPrev.heightAnchor).isActive=true
        btnNext.widthAnchor.constraint(equalTo: btnPrev.widthAnchor).isActive=true
        btnNext.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive=true
        btnNext.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive=true
        
        self.view.addSubview(lblQueNumber)
        lblQueNumber.heightAnchor.constraint(equalToConstant: 20).isActive=true
        lblQueNumber.widthAnchor.constraint(equalToConstant: 150).isActive=true
        lblQueNumber.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive=true
        lblQueNumber.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80).isActive=true
        lblQueNumber.text = "Question: \(1) / \(questionsArray.count)"
        
        self.view.addSubview(lblScore)
        lblScore.heightAnchor.constraint(equalTo: lblQueNumber.heightAnchor).isActive=true
        lblScore.widthAnchor.constraint(equalTo: lblQueNumber.widthAnchor).isActive=true
        lblScore.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive=true
        lblScore.bottomAnchor.constraint(equalTo: lblQueNumber.bottomAnchor).isActive=true
        lblScore.text = "Score: \(score) / \(questionsArray.count)"
    }
    
    let btnPrev: UIButton = {
        let btn=UIButton()
        btn.setTitle("< Previous", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor=UIColor.red
        btn.translatesAutoresizingMaskIntoConstraints=false
        btn.addTarget(self, action: #selector(btnPrevNextAction), for: .touchUpInside)
        return btn
    }()
    
    let btnNext: UIButton = {
        let btn=UIButton()
        btn.setTitle("Next >", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor=UIColor.green
        btn.translatesAutoresizingMaskIntoConstraints=false
        btn.addTarget(self, action: #selector(btnPrevNextAction), for: .touchUpInside)
        return btn
    }()
    
    let lblQueNumber: UILabel = {
        let lbl=UILabel()
        lbl.text="0 / 0"
        lbl.textColor=UIColor.gray
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let lblScore: UILabel = {
        let lbl=UILabel()
        lbl.text="0 / 0"
        lbl.textColor=UIColor.gray
        lbl.textAlignment = .right
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
}

extension QuizVC: QuizCVCellDelegate {
    func didChooseAnswer(btnIndex: Int) {
        let centerIndex = getCenterIndex()
        guard let index = centerIndex else { return }
        questionsArray[index.item].isAnswered=true
        if questionsArray[index.item].correctAns != btnIndex {
            questionsArray[index.item].wrongAns = btnIndex
            score -= 1
        } else {
            score += 1
        }
        lblScore.text = "Score: \(score) / \(questionsArray.count)"
        myCollectionView.reloadItems(at: [index])
    }
    
    func getCenterIndex() -> IndexPath? {
        let center = self.view.convert(self.myCollectionView.center, to: self.myCollectionView)
        let index = myCollectionView!.indexPathForItem(at: center)
        print(index ?? "index not found")
        return index
    }
}














