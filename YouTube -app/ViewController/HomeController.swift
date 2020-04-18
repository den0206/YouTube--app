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
    
    var videos = [Video]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    lazy var menuBar : MenuBar = {
        let mb = MenuBar()
        mb.delegate = self
        return mb
    }()
    
    lazy var settingLauncher = SettingLauncher()
    
    let titles = ["Home", "Trending", "Subscription", "Account" ]

    
    
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCV()
        
        APIService.shared.fetchVideos { (videos) in
            
            self.videos = videos
        }
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
        
        collectionView.isPagingEnabled = true
    }
    
    private func setNavBarButtons() {
        
        let searchButton = UIBarButtonItem(image: #imageLiteral(resourceName: "search_icon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
        
        let moreButton = UIBarButtonItem(image:UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [moreButton, searchButton]
        
    }
    
    //MARK: - Actions
    
    @objc func handleMore() {
        settingLauncher.delegate = self
        settingLauncher.showSettings()

    }
    
    @objc func handleSearch() {
        print("search")
    }
    
    //MARK: - ScrollView Delagate
    
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        menuBar.underLineView.anchor(left : menuBar.leftAnchor, paddingLeft: scrollView.contentOffset.x / 4)
//
//    }
//
//
//    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let index = Int(targetContentOffset.pointee.x / view.frame.width)
//
//        let indexPath = IndexPath(item: index, section: 0)
//
//        let cell = menuBar.collectionView.cellForItem(at: indexPath)
//
//        let xPosition = cell?.frame.origin.x ?? 0
//        print(xPosition)
//        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
//
//    }
//
    private func setTitleForIndex(index : Int) {
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "\(titles[index])"
        }
    }
    
}

extension HomeController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifer, for: indexPath) as! VideoCell
        
        cell.video = videos[indexPath.item]
        
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

extension HomeController : SettingLauncherDelegate, MenuBarDelegate {

    func showControllerForSetting(setting: Setting) {
        /// dummy Example
        
        let dummySerringViewController = UIViewController()
        dummySerringViewController.view.backgroundColor = .white
        dummySerringViewController.navigationItem.title = setting.name.rawValue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.pushViewController(dummySerringViewController, animated: true)
        
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        setTitleForIndex(index: menuIndex)
    }
    
    
}




