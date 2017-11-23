//
//  DetailViewController.swift
//  Wiki App
//
//  Created by Mayank Gupta on 04/11/17.
//  Copyright © 2017 Mayank Gupta. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIWebViewDelegate {
    //MARK: - Instance Variables
    var associatedURL : String?
    
    //MARK: - IBOutlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var webView: UIWebView!
    
    //MARK: - View Controller Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard associatedURL != nil && !associatedURL!.isEmpty else {
            self.performSegue(withIdentifier: "DismissSegue", sender: nil)
            return
        }

        guard let url = URL(string: self.associatedURL!) else {
            self.performSegue(withIdentifier: "DismissSegue", sender: nil)
            return
        }
        
        self.webView.loadRequest(URLRequest(url: url))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UIWebViewDelegate Methods
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        self.activityIndicator.stopAnimating()
    }
   
}
