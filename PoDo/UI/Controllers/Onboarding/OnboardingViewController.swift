//
//  ScreenOneViewController.swift
//  PO-DO
//
//  Created by Recep Taha Aydın on 23.12.2023.
//

import UIKit

class OnboardingViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var button: UIButton!
    
    var scrollWidth: CGFloat! = 0.0
    var scrollHeight: CGFloat! = 0.0
    
    //data for the slides
    var titles = ["Easy task & work management with Po-Do","Track your productivitiy & gain insights","Boost your productivity now & be successful"]
    
    var imgs = ["PLetter","PLetter","PLetter"]
    
    //get dynamic width and height of scrollview and save it
    override func viewDidLayoutSubviews() {
        scrollWidth = scrollView.frame.size.width
        scrollHeight = scrollView.frame.size.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        //to call viewDidLayoutSubviews() and get dynamic width and height of scrollview
        
        self.scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        //crete the slides and add them
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        for index in 0..<titles.count {
            frame.origin.x = scrollWidth * CGFloat(index)
            frame.size = CGSize(width: scrollWidth, height: scrollHeight)
            
            let slide = UIView(frame: frame)
            
            //subviews
            let imageView = UIImageView.init(image: UIImage.init(named: imgs[index]))
            imageView.frame = CGRect(x:0,y:0,width:300,height:300)
            imageView.contentMode = .scaleAspectFit
            imageView.center = CGPoint(x:scrollWidth/2,y: scrollHeight/2 - 50)
            
            let txt1 = UILabel.init(frame: CGRect(x:32,y:imageView.frame.maxY+30,width:scrollWidth-64,height:150))
            txt1.textAlignment = .center
            txt1.textColor = .label
            txt1.font = UIFont.boldSystemFont(ofSize: 34.0)
            txt1.numberOfLines = 0
            txt1.text = titles[index]
            
            slide.addSubview(imageView)
            slide.addSubview(txt1)
            scrollView.addSubview(slide)
        }
        
        //set width of scrollview to accomodate all the slides
        scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(titles.count), height: scrollHeight)
        
        //disable vertical scroll/bounce
        self.scrollView.contentSize.height = 1.0
        
        //initial state
        pageControl.numberOfPages = titles.count
        pageControl.currentPage = 0
        
    }
    
    //indicator
    @IBAction func pageChanged(_ sender: Any) {
        scrollView!.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat ((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        let nextPage = pageControl.currentPage + 1
        
        // Check if nextPage exceeds the total number of pages
        if nextPage < titles.count {
            // If not on the last page, scroll to the next page
            let xOffset = scrollWidth * CGFloat(nextPage)
            scrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
            
            // Update the pageControl to reflect the current page
            pageControl.currentPage = nextPage
            
            // Update the button text based on the current page
            updateButtonText()
        } else {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "signupVC")
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        }
    }
    
    func updateButtonText() {
        if pageControl.currentPage == 0 || pageControl.currentPage == 1 {
            button.setTitle("Next", for: .normal)
        } else {
            button.setTitle("Get Started", for: .normal)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setIndiactorForCurrentPage()
        updateButtonText()
    }
    
    func setIndiactorForCurrentPage()  {
        let page = (scrollView?.contentOffset.x)!/scrollWidth
        pageControl?.currentPage = Int(page)
    }
}
