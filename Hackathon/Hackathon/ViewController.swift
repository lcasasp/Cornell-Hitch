//
//  ViewController.swift
//  BackgroundView
//
//  Created by Marcel Pantin on 11/28/22.
//

import UIKit

class ViewController: UIViewController {
    let backgroundUIImage =  UIImageView()
    let backgroundUIImage1 = UIImageView()
    let backgroundUIImage2 = UIImageView()
    let backgroundUIImage3 = UIImageView()
    let backgroundUIImage4 = UIImageView()
    let backgroundUIImage5 = UIImageView()
//    let noteLabelView = UITextView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        title = "Push View"
        createBackgroundImage(imageV: backgroundUIImage, inputPaddingX: -50, inputPaddingY: 200)
        createBackgroundImage(imageV: backgroundUIImage1, inputPaddingX: -80, inputPaddingY: -130)
        createBackgroundImage(imageV: backgroundUIImage2, inputPaddingX: 50, inputPaddingY: -50)
        createBackgroundImage(imageV: backgroundUIImage3, inputPaddingX: -100, inputPaddingY: 100)
        createBackgroundImage(imageV: backgroundUIImage4, inputPaddingX: 120, inputPaddingY: 150)
        
        
        backgroundUIImage5.image = UIImage(named: "background2")
        backgroundUIImage5.layer.cornerRadius = 250
        backgroundUIImage5.clipsToBounds = true
        backgroundUIImage5.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundUIImage5)
        
//        noteLabelView.text = ViewController.
//        noteLabelView.text =
//        noteLabelView.font = .systemFont(ofSize: 20)
//        noteLabelView.layer.cornerRadius = 10
//        noteLabelView.alpha = 0.5
//        noteLabelView.backgroundColor = .systemGray6
//        noteLabelView.isEditable = false
//        noteLabelView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(noteLabelView)
        setConstraints()
        
        // Do any additional setup after loading the view.
    }
    func setConstraints(){
        let radius: CGFloat = 500.0
        NSLayoutConstraint.activate([
            backgroundUIImage5.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundUIImage5.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            backgroundUIImage5.widthAnchor.constraint(equalToConstant: radius),
            backgroundUIImage5.heightAnchor.constraint(equalToConstant: radius)
        ])
//        NSLayoutConstraint.activate([
//            noteLabelView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
//            noteLabelView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
//            noteLabelView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            noteLabelView.widthAnchor.constraint(equalToConstant: 300),
//            noteLabelView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 100)
//            
//        ])
    }
    
    func createBackgroundImage(imageV: UIImageView, inputPaddingX: CGFloat = 0, inputPaddingY: CGFloat = 0) {
        imageV.image = UIImage(named: "background2")
        imageV.layer.cornerRadius = 50
        imageV.clipsToBounds = true
        imageV.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageV)
        setC()
        func setC(){
            let radius: CGFloat = 100.0
            let paddingY = inputPaddingY
            let paddingX = inputPaddingX
            NSLayoutConstraint.activate([
                imageV.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: paddingY),
                imageV.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: paddingX),
                imageV.widthAnchor.constraint(equalToConstant: radius),
                imageV.heightAnchor.constraint(equalToConstant: radius)
            ])
        }
    }

}

