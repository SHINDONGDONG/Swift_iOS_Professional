//
//  ExPageViewController.swift
//  Swift_Benkey
//
//  Created by 申民鐡 on 2022/07/19.
//

import UIKit

class ExPageViewController: UIViewController {

    var pageViewController = UIPageViewController()
    var pages = [UIViewController]()
    //현재페이지를 설정하고, 모든것을 추적할 수 있다.
    var currentVC: UIViewController {
        didSet {
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        let page1 = ViewController1()
        let page2 = ViewController2()
        let page3 = ViewController3()
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        currentVC = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //베이스 uiviewcontroller색상
        view.backgroundColor = .systemPurple
        
        //pageviewcontroller를 위에다가 자식처럼 추가시켜준다.
        addChild(pageViewController)
        //view에 pageviewcontroller의 view를 추가시켜준다
        view.addSubview(pageViewController.view)
        //pageview controller에서 이동시켜줌 자기 자신을.
        pageViewController.didMove(toParent: self)
        //pageview controller의 datasource를 사용한다.
        pageViewController.dataSource = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
        ])
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: true)
        currentVC = pages.first!
    }
    
}

//페이지 datasource로 전 페이지와 후 페이지를 보여주여야함.
extension ExPageViewController:UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPre(from: viewController)
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNext(from: viewController)
    }
    private func getPre(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else {
            return nil
        }
        self.currentVC = pages[index - 1]
        return pages[index - 1]
    }
    private func getNext(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else {
            return nil
        }
        self.currentVC = pages[index + 1]
        return pages[index + 1]
    }
    
    //밑에 인디케이터의 count수
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    //index인디게이터 표현 first가 어떤것인지 알려줭야한다.
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
}

class ViewController1:UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor  = .systemPink
    }
}

class ViewController2:UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor  = .systemRed
    }
}

class ViewController3:UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor  = .systemBlue
    }
}
