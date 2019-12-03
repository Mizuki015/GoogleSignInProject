//
//  ViewController.swift
//  GoogleSignInProject
//
//  Created by 城間海月 on 2019/12/03.
//  Copyright © 2019 Mizuki. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }


}

extension ViewController: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            // errorfがnilでない場合（エラーが存在する場合）
            print(error.localizedDescription)
            // 処理を中断
            return
        }
        
        guard let authentication = user.authentication else {
            // 認証情報が取れなければ、処理を中断
            return
        }
        
        let credenital = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credenital) { (result, error) in
            
            if let error = error {
                // エラーがある場合
                print(error.localizedDescription)
            } else {
                // ログインに成功した場合
                print("ログインに成功")
                self.performSegue(withIdentifier: "toHome", sender: nil)
            }
            
        }
        
    }
}
