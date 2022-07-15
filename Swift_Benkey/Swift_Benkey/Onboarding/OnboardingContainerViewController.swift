
//  OnboardingContainerViewController.swift
//  Bankey
//
//  Created by jrasmusson on 2021-09-28.
//

import UIKit

protocol OnboardingContainerViewControllerDelegate: AnyObject {
    func didFinishiOnboarding()
}

class OnboardingContainerViewController: UIViewController {

    weak var delegate:OnboardingContainerViewControllerDelegate?
    
    //pageView controller 선언
    let pageViewController: UIPageViewController
    //uiviewcontroller가 들어갈 pages 선언
    var pages = [UIViewController]()
    //currentVC 가 들어갈 변수 선언
    var currentVC: UIViewController {
        didSet {
            guard let index = pages.firstIndex(of: currentVC) else {return}
            print("ff - \(index)")
            nextButton.isHidden = index == pages.count - 1 //라스트 페이지에 숨김
            backButton.isHidden = index == pages.startIndex //첫페이지일때 숨김
            doneButton.isHidden = !(index == pages.count - 1) //라스트 페이지일 때 안숨김.
            closeButton.isEnabled = index == pages.count - 1 //라스트 페이지일 때 안숨김.
        }
    }
    let nextButton :UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: [])
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextTapped), for: .primaryActionTriggered)
        return button
    }()
    let doneButton :UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: [])
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeTapped), for: .primaryActionTriggered)
        return button
    }()
    let backButton :UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Back", for: [])
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backTapped), for: .primaryActionTriggered)
        return button
    }()
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: [])
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeTapped), for: .primaryActionTriggered)
        return button
    }()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        //pageviewcontroller에 옵션을 넣어준다.
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        //viewcontroller들을 페이지로 담아준다.
        let page1 = OnboardingViewController(heroImageName: "delorean", titleText: "1abcdef")
        let page2 = OnboardingViewController(heroImageName: "thumbs", titleText: "2abcdef")
        let page3 = OnboardingViewController(heroImageName: "world", titleText: "3abcdef")

        //위에서 선언한 pages에 담아준다.
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)

        //currentVC도 pages.first! 첫번째 contoller를 담아준다.
        currentVC = pages.first!

        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
    
    private func setup(){
        //부모뷰 컨트롤러에 자식뷰 컨트롤러를 추가시키는것.
        addChild(pageViewController)
        //뷰에 자식컨트롤러의 뷰만 추가시킨다.
        view.addSubview(pageViewController.view)
        //pageviewcontroller가 움직였다 부모쪽에서
        pageViewController.didMove(toParent: self)

        //pageviewcontroller 의 datasource를 선언.
        pageViewController.dataSource = self
        //pageviewcontroller.view의
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        //userinteraction = 스와이프를 false로 만들어줌
        pageViewController.view.isUserInteractionEnabled = false
        


        //pageviewcontroller에 setviewcontrollers로 pages의 첫번째를 담아준다.
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
        //currentVC에 pages.first로 강제로 담아준다.
        currentVC = pages.first!
    }
    private func style(){
        view.backgroundColor = .systemPurple
        view.addSubview(closeButton)
        view.addSubview(nextButton)
        view.addSubview(doneButton)
        view.addSubview(backButton)
    }
    private func layout(){
        //pageviewcontroller에 대한 anchor를 설정한다.
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
        ])
        //close
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            closeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2)
        ])
        //next
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: nextButton.trailingAnchor, multiplier: 2),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: nextButton.bottomAnchor, multiplier: 8)
        ])
        //back
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: backButton.bottomAnchor, multiplier: 8)
        ])
        //next
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: doneButton.trailingAnchor, multiplier: 2),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: doneButton.bottomAnchor, multiplier: 8)
        ])
    }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingContainerViewController: UIPageViewControllerDataSource {

    //앞에있어야할 뷰컨트롤러는 무엇인가 묻는것
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }
    //스와이프 하고난 후 뷰컨트롤러는 무엇인가 묻는것
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }

    //preview
    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        currentVC = pages[index - 1]
        return pages[index - 1]
    }

    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        currentVC = pages[index + 1]
        return pages[index + 1]
    }

    //presentaionCount pageviewcontroller의 count를 확인한다.
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    //pageviewcontroller의 첫번재 인덱스를 설정해준다.
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
}

extension OnboardingContainerViewController {
    //actions
    @objc func nextTapped(_ sender: UIButton) {
        guard let NextVC = getNextViewController(from: currentVC) else { return }
        pageViewController.setViewControllers([NextVC], direction: .forward, animated: true)
    }
    
    @objc func backTapped(_ sender: UIButton) {
        guard let BackVC = getPreviousViewController(from: currentVC) else { return}
        pageViewController.setViewControllers([BackVC], direction: .reverse, animated: true)
    }
    @objc func closeTapped(_ sender: UIButton) {
        delegate?.didFinishiOnboarding()
    }
    
    @objc func doneTapped(_ sender: UIButton) {
        delegate?.didFinishiOnboarding()
    }
    
    
    
    
}
