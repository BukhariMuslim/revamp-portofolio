//
//  CostumeMonthPickerView.swift
//  BottomSheetViewControllerExample
//
//  Created by sia santos on 21/07/25.
//

import UIKit
import SnapKit

final class CostumeMonthPickerView: UIView {
    
    var onMonthYearSelected: ((Date) -> Void)?
    
    private let monthPickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = .clear
        return picker
    }()
    
    private let months = ["Jan", "Feb", "Mar", "Apr", "Mei", "Jun", "Jul", "Agu", "Sep", "Okt", "Nov", "Des"]
    private var years: [Int] = []
    
    private var selectedMonthIndex: Int = 0
    private var selectedYearIndex: Int = 0
    
    private var previousSelectedMonth: Int?
    private var previousSelectedYear: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupYears()
        setupViews()
        setupConstraints()
        setupInitialSelection()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupYears() {
        let currentYear = Calendar.current.component(.year, from: Date())
        years = Array((currentYear - 1)...currentYear)
    }
    
    private func setupViews() {
        backgroundColor = UIColor.Brimo.White.main
        addSubview(monthPickerView)
        
        monthPickerView.delegate = self
        monthPickerView.dataSource = self
    }
    
    private func setupConstraints() {
        monthPickerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(250)
        }
    }
    
    private func setupInitialSelection() {
        let calendar = Calendar.current
        
        if let previousMonth = previousSelectedMonth,
           let previousYear = previousSelectedYear {
            let testMonthIndex = previousMonth - 1
            let testYearIndex = years.firstIndex(of: previousYear) ?? 0
            
            var testComponents = DateComponents()
            testComponents.year = years[testYearIndex]
            testComponents.month = testMonthIndex + 1
            testComponents.day = 1
            
            if let testDate = calendar.date(from: testComponents),
               isDateWithinAllowedRange(testDate) {
                selectedMonthIndex = testMonthIndex
                selectedYearIndex = testYearIndex
            } else {
                setToCurrentMonth()
            }
        } else {
            setToCurrentMonth()
        }
        
        monthPickerView.selectRow(selectedMonthIndex, inComponent: 0, animated: false)
        monthPickerView.selectRow(selectedYearIndex, inComponent: 1, animated: false)
    }
    
    private func setToCurrentMonth() {
        let currentDate = Date()
        let calendar = Calendar.current
        
        selectedMonthIndex = calendar.component(.month, from: currentDate) - 1
        let currentYear = calendar.component(.year, from: currentDate)
        selectedYearIndex = years.firstIndex(of: currentYear) ?? 0
    }
    
    func setPreviousSelection(month: Int, year: Int) {
        previousSelectedMonth = month
        previousSelectedYear = year
        setupInitialSelection()
    }
    
    func getCurrentSelection() -> (month: Int, year: Int) {
        return (selectedMonthIndex + 1, years[selectedYearIndex])
    }
    
    private func notifySelection() {
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = years[selectedYearIndex]
        components.month = selectedMonthIndex + 1
        components.day = 1
        
        guard let date = calendar.date(from: components) else {
            return
        }
        
        if isDateWithinAllowedRange(date) {
            onMonthYearSelected?(date)
        }
    }
    
    private func isDateWithinAllowedRange(_ date: Date) -> Bool {
        let calendar = Calendar.current
        let currentDate = Date()
        
        let selectedYear = calendar.component(.year, from: date)
        let selectedMonth = calendar.component(.month, from: date)
        let currentYear = calendar.component(.year, from: currentDate)
        let currentMonth = calendar.component(.month, from: currentDate)
        
        if selectedYear < currentYear - 1 {
            return false
        }
        
        if selectedYear > currentYear {
            return false
        }
        
        if selectedYear == currentYear && selectedMonth > currentMonth {
            return false
        }
        
        return true
    }
}

extension CostumeMonthPickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return months.count
        case 1:
            return years.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return months[row]
        case 1:
            return "\(years[row])"
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let previousMonthIndex = selectedMonthIndex
        let previousYearIndex = selectedYearIndex
        
        switch component {
        case 0:
            selectedMonthIndex = row
        case 1:
            selectedYearIndex = row
        default:
            break
        }
        
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = years[selectedYearIndex]
        dateComponents.month = selectedMonthIndex + 1
        dateComponents.day = 1
        
        guard let dateComponent = calendar.date(from: dateComponents),
              isDateWithinAllowedRange(dateComponent) else {
            
            selectedMonthIndex = previousMonthIndex
            selectedYearIndex = previousYearIndex
            
            DispatchQueue.main.async {
                pickerView.selectRow(self.selectedMonthIndex, inComponent: 0, animated: true)
                pickerView.selectRow(self.selectedYearIndex, inComponent: 1, animated: true)
                pickerView.reloadAllComponents()
            }
            return
        }
        
        DispatchQueue.main.async {
            pickerView.reloadAllComponents()
        }
        
        notifySelection()
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let containerView = UIView()
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.Brimo.Title.mediumSemiBold
        
        switch component {
        case 0:
            label.text = months[row]
        case 1:
            label.text = "\(years[row])"
        default:
            break
        }
        
        let isSelected = (component == 0 && row == selectedMonthIndex) || (component == 1 && row == selectedYearIndex)
        
        let calendar = Calendar.current
        var testComponents = DateComponents()
        testComponents.year = component == 1 ? years[row] : years[selectedYearIndex]
        testComponents.month = component == 0 ? row + 1 : selectedMonthIndex + 1
        testComponents.day = 1
        
        let isValidDate = calendar.date(from: testComponents).map(isDateWithinAllowedRange) ?? false
        
        if !isValidDate {
            label.textColor = UIColor.Brimo.Black.x300
        } else if isSelected {
            label.textColor = UIColor.Brimo.Primary.main
        } else {
            label.textColor = UIColor.Brimo.Black.x600
        }
        
        containerView.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return containerView
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
}
