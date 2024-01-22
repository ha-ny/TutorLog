//
//  ImageButton.swift
//  TutoringSchedule
//
//  Created by 김하은 on 1/22/24.
//

import UIKit

class ImageButton: UIButton {
    
    init(image: UIImage) {
        super.init(frame: .zero)
        
        setImage(image, for: .normal)
        setImage(image, for: .highlighted)
        contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
