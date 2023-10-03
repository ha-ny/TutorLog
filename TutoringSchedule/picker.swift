//
//  picker.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/03.
//

import UIKit
import SnapKit

class picker: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let maxCount = 24
    
    
    let dayLabel = {
        let view = UILabel()
        view.text = "화요일"
        view.textColor = .black
        view.font = .boldSystemFont(ofSize: 30)
        return view
    }()
    
    let startLabel = {
        let view = UILabel()
        view.text = "시작 시간"
        view.textAlignment = .center
        view.textColor = .black
        view.font = .boldSystemFont(ofSize: 13)
        return view
    }()
    
    let endLabel = {
        let view = UILabel()
        view.text = "종료 시간"
        view.textAlignment = .center
        view.textColor = .black
        view.font = .boldSystemFont(ofSize: 13)
        return view
    }()
    
    lazy var pickerVIew = {
        let view = UIPickerView()
        view.delegate = self
        view.dataSource = self
        return view
    }()

    override func viewDidLoad() {
        view.backgroundColor = .backgroundColor
        
        view.addSubview(dayLabel)
        view.addSubview(startLabel)
        view.addSubview(endLabel)
        view.addSubview(pickerVIew)

        
        dayLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(4)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        startLabel.snp.makeConstraints { make in
            make.top.equalTo(dayLabel.snp.bottom).offset(10)
            make.left.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.snp.width).multipliedBy(0.5)
        }
        
        endLabel.snp.makeConstraints { make in
            make.top.equalTo(dayLabel.snp.bottom).offset(10)
            make.right.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.snp.width).multipliedBy(0.5)
        }
        
        pickerVIew.snp.makeConstraints { make in
            make.top.equalTo(startLabel.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(6)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(24)
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 6
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if(component == 2 || component == 5)
        {
            return 2
        }
        else
        {
            return maxCount
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        if(component == 0 || component == 3)
        {
            return String(format: "%02d", (row%12)+1)
        }
        else if(component == 1 || component == 4)
        {

            return String(format: "%02d", (row%12)*5)
        }
        else
        {
            return row == 0 ? "AM" : "PM"
        }
    }
    private func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       // self.pickerViewLoaded(row,component: component)
    }
    
    func pickerViewLoaded(row:Int,component:Int)
    {
        let base = (maxCount/2)-(maxCount/2)%12;
        self.pickerVIew.selectRow(row%12+base, inComponent: component, animated: false)
    }
}
