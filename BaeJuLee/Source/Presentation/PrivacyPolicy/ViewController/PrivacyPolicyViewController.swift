//
//  PrivacyPolicyViewController.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/27/24.
//

import UIKit

class PrivacyPolicyViewController: BaseViewController {
    
    private let privacyPolicyLable = UILabel().then {
        $0.text = "배줄이는 「개인정보 보호법」 제30조에 따라 정보주체의 개인정보를 보호하고 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리방침을 수립·공개합니다.\n\n제1조(개인정보의 처리목적) 배줄이가 개인정보 보호법 제32조에 따라 등록․공개하는 개인정보파일의 처리목적은 다음과 같습니다.\n\n제2조(처리하는 개인정보의 항목)\n① 배줄이는 개인정보 항목을 처리하고 있지 않습니다.\n\n제3조(개인정보 파일의 현황)\n① 배줄이는 개인정보 파일, 쿠키 등 을 사용하지 않고, 저장하지 않습니다.\n\n제4조(개인정보의 처리 및 보유 기간)\n① 배줄이는 개인정보 파일, 쿠키 등 을 사용하지 않고, 저장하지 않습니다. 따라서 이용자의 개인정보를 처리할 내용과 보유기간이 존재하지 않습니다.\n\n제5조(개인정보의 제3자 제공에 관한 사항)\n① 배줄이는 개인정보를 제3자에게 제공하지 않습니다.\n\n제6조(개인정보처리 위탁)\n① 배줄이는 개인정보의 위탁을 하고 있지 않습니다.\n\n제7조(정보주체와 법정대리인의 권리·의무 및 그 행사방법에 관한 사항)\n① 배줄이는 개인정보 파일, 쿠키 등 을 사용하지 않고, 저장하지 않습니다.\n\n제8조(개인정보의 파기)\n① 배줄이는 독립 실행 방식의 어플리케이션으로 별도의 서버에서 개인정보를 저장하고 있지 않습니다. 따라서 정보주체가 원할 시 어플리케이션을 삭제 함으로서 모든 데이터를 파기 가능합니다."
        $0.textAlignment = .left
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .darkGray
        $0.numberOfLines = 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configNav()
    }
    
    override func configHierarchy() {
        view.addSubview(privacyPolicyLable)
    }
    
    override func configLayout() {
        privacyPolicyLable.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
    }
    
    private func configNav() {
        let backImage = UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysOriginal).withTintColor(.pointNavy)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTapped))
    }

    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
