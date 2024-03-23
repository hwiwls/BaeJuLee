//
//  RecipeRecommendViewController.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/11/24.
//

import UIKit
import Lottie
import SnapKit
import Then

final class RecipeRecommendViewController: BaseViewController {

    var animationView = LottieAnimationView()
    // 네트워크 요청의 결과를 다루는 로직을 외부에서 정의하고, 요청의 결과가 준비되었을 때 해당 로직을 실행할 수 있게
    var completionHandler: (([String]) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // Lottie 애니메이션 설정
        animationView = LottieAnimationView(name: "Animation - 1711202389333")
        animationView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        animationView.center = view.center
        animationView.loopMode = .loop
        animationView.play()

        view.addSubview(animationView)
    }

    // 네트워크 요청 결과 처리
    func handleNetworkResponse(result: [String]) {
        animationView.stop()
        animationView.isHidden = true

        print("네트워크 요청 결과:", result)
        
        // 결과 처리를 위한 클로저 호출
        completionHandler?(result)
    }
}
