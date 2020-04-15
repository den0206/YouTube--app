//
//  ViewController.swift
//  You Tube -app
//
//  Created by 酒井ゆうき on 2020/04/15.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

private let reuseIdentifer = "VideoCell"

class HomeController: UICollectionViewController {
    
    var videos = [Video]()
    
    let menuBar : MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCV()
    }
    
    
    private func configureCV() {
        
        setupMenuBar()
        setNavBarButtons()
        
        collectionView.backgroundColor = .white
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: reuseIdentifer)
    }
    
    private func setupMenuBar() {
        
        configureNav(title: "Home", preferLargeTitle: false)
        
        view.addSubview(menuBar)
        menuBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,  right: view.rightAnchor,  width: view.frame.width, height: 50)
        
        /// set start line
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    }
    
    private func setNavBarButtons() {
        
        let searchButton = UIBarButtonItem(image: #imageLiteral(resourceName: "search_icon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
        
        let moreButton = UIBarButtonItem(image:UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [moreButton, searchButton]
        
    }
    
    //MARK: - Actions
    
    @objc func handleSearch() {
        print("search")
    }
    
    @objc func handleMore() {
        print("Mores")
    }

}

extension HomeController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifer, for: indexPath) as! VideoCell
        
        
        return cell
        
    }
}
extension HomeController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        
        return CGSize(width: view.frame.width, height: height + 16 + 68)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
}





