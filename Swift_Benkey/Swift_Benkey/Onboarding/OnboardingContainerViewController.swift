
//  OnboardingContainerViewController.swift
//  Bankey
//
//  Created by jrasmusson on 2021-09-28.
//

import UIKit

class OnboardingContainerViewController: UIViewController {

    //pageView controller 선언
    let pageViewController: UIPageViewController
    //uiviewcontroller가 들어갈 pages 선언
    var pages = [UIViewController]()
    //currentVC 가 들어갈 변수 선언
    var currentVC: UIViewController {
        didSet {
        }
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        //pageviewcontroller에 옵션을 넣어준다.
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        //viewcontroller들을 페이지로 담아준다.
        let page1 = ViewController1()
        let page2 = ViewController2()
        let page3 = ViewController3()

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

        view.backgroundColor = .systemPurple

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

        
        //pageviewcontroller에 대한 anchor를 설정한다.
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
        ])

        //pageviewcontroller에 setviewcontrollers로 pages의 첫번째를 담아준다.
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
        //currentVC에 pages.first로 강제로 담아준다.
        currentVC = pages.first!
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
        currentVC = pages[index - 2]
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

// MARK: - ViewControllers
class ViewController1: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
    }
}

class ViewController2: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
    }
}

class ViewController3: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
    }
}
