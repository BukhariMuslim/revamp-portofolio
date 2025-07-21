//
//  CostumCalendarDatePickerView.swift
//  BottomSheetViewControllerExample
//
//  Created by sia santos on 18/07/25.
//

import UIKit
import SnapKit

class CostumCalendarDatePickerView: UIView {
    
    private let monthYearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Brimo.Title.smallSemiBold
        label.textColor = UIColor.Brimo.Black.main
        label.textAlignment = .center
        return label
    }()
    
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = UIColor.Brimo.Black.main
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = UIColor.Brimo.Black.main
        return button
    }()
    
    private let weekdayStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 0
        return stack
    }()
    
    private let calendarCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    private let startDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Brimo.Body.mediumRegular
        label.textColor = UIColor.Brimo.Black.x600
        label.text = "Tanggal Awal"
        return label
    }()
    
    private let startDateValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Brimo.Body.largeSemiBold
        label.textColor = UIColor.Brimo.Black.main
        label.text = "-"
        return label
    }()
    
    private let endDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Brimo.Body.mediumRegular
        label.textColor = UIColor.Brimo.Black.x600
        label.text = "Tanggal Akhir"
        return label
    }()
    
    private let endDateValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Brimo.Body.largeSemiBold
        label.textColor = UIColor.Brimo.Black.main
        label.text = "-"
        return label
    }()
    
    private let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Brimo.Black.x200
        return view
    }()
    
    private var currentDate = Date()
    private var selectedStartDate: Date?
    private var selectedEndDate: Date?
    private var isSelectingStartDate = true
    private var days: [Date?] = []
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        return formatter
    }()
    
    private let maxDate: Date = Date()
    private let maxSelectableRangeInDays = 92

    private lazy var minDate: Date = {
        let cal = Calendar.current
        guard let date = cal.date(byAdding: .year, value: -1, to: Date()) else {
            return Date()
        }
        return date
    }()
    
    var onDateRangeSelected: ((Date, Date) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupActions()
        setupCalendar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = UIColor.Brimo.White.main
        
        let weekdays = ["Min", "Sen", "Sel", "Rab", "Kam", "Jum", "Sab"]
        weekdays.forEach { day in
            let label = UILabel()
            label.text = day
            label.font = UIFont.Brimo.Body.mediumSemiBold
            label.textColor = UIColor.Brimo.Black.x600
            label.textAlignment = .center
            weekdayStackView.addArrangedSubview(label)
        }
        
        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = self
        calendarCollectionView.register(CostumCalendarCellView.self, forCellWithReuseIdentifier: "CostumCalendarCellView")
        
        addSubviews(
            monthYearLabel,
            previousButton,
            nextButton,
            weekdayStackView,
            calendarCollectionView,
            separatorLine,
            startDateLabel,
            startDateValueLabel,
            endDateLabel,
            endDateValueLabel
        )
    }
    
    private func setupConstraints() {
        monthYearLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
        
        previousButton.snp.makeConstraints { make in
            make.centerY.equalTo(monthYearLabel)
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(44)
        }
        
        nextButton.snp.makeConstraints { make in
            make.centerY.equalTo(monthYearLabel)
            make.trailing.equalToSuperview().offset(-20)
            make.width.height.equalTo(44)
        }
        
        weekdayStackView.snp.makeConstraints { make in
            make.top.equalTo(monthYearLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
        
        calendarCollectionView.snp.makeConstraints { make in
            make.top.equalTo(weekdayStackView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(240)
        }
        
        separatorLine.snp.makeConstraints { make in
            make.top.equalTo(calendarCollectionView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        
        startDateLabel.snp.makeConstraints { make in
            make.top.equalTo(separatorLine.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        startDateValueLabel.snp.makeConstraints { make in
            make.top.equalTo(startDateLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(20)
        }
        
        endDateLabel.snp.makeConstraints { make in
            make.top.equalTo(separatorLine.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        endDateValueLabel.snp.makeConstraints { make in
            make.top.equalTo(endDateLabel.snp.bottom).offset(4)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    private func setupActions() {
        previousButton.addTarget(self, action: #selector(previousMonth), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextMonth), for: .touchUpInside)
    }
    
    private func setupCalendar() {
        updateMonthYearLabel()
        generateDaysInMonth()
        calendarCollectionView.reloadData()
    }
    
    // MARK: - Calendar Logic
    private func updateMonthYearLabel() {
        dateFormatter.dateFormat = "MMMM yyyy"
        monthYearLabel.text = dateFormatter.string(from: currentDate)
    }
    
    private func generateDaysInMonth() {
        days.removeAll()
        
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: currentDate)!
        
        var components = calendar.dateComponents([.year, .month], from: currentDate)
        components.day = 1
        let firstDayOfMonth = calendar.date(from: components)!
        
        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth) - 1
        
        for _ in 0..<firstWeekday {
            days.append(nil)
        }
        
        for day in 1...range.count {
            components.day = day
            days.append(calendar.date(from: components))
        }
    }
    
    @objc private func previousMonth() {
        let cal = Calendar.current
        guard let candidate = cal.date(byAdding: .month, value: -1, to: currentDate) else {
            return
        }
        
        let candidateComponents = cal.dateComponents([.year, .month], from: candidate)
        let minComponents = cal.dateComponents([.year, .month], from: minDate)
        
        guard let minMonthStart = cal.date(from: minComponents),
              let candidateMonthStart = cal.date(from: candidateComponents),
              candidateMonthStart >= minMonthStart else {
            return
        }
        
        currentDate = candidate
        setupCalendar()
    }
    
    @objc private func nextMonth() {
        let cal = Calendar.current
        
        let maxComponents = cal.dateComponents([.year, .month], from: maxDate)
        guard let maxMonthStart = cal.date(from: maxComponents) else { return }
        
        guard let candidate = cal.date(byAdding: .month, value: 1, to: currentDate) else { return }
        let candidateComponents = cal.dateComponents([.year, .month], from: candidate)
        guard let candidateMonthStart = cal.date(from: candidateComponents) else { return }
        
        guard candidateMonthStart <= maxMonthStart else { return }
        currentDate = candidate
        setupCalendar()
    }
    
    private func updateDateLabels() {
        dateFormatter.dateFormat = "d MMMM yyyy"
        
        if let startDate = selectedStartDate {
            startDateValueLabel.text = dateFormatter.string(from: startDate)
        } else {
            startDateValueLabel.text = "-"
        }
        
        if let endDate = selectedEndDate {
            endDateValueLabel.text = dateFormatter.string(from: endDate)
        } else {
            endDateValueLabel.text = "-"
        }
    }
    
    func setDateRange(startDate: Date?, endDate: Date?) {
        self.selectedStartDate = startDate
        self.selectedEndDate = endDate
        updateDateLabels()
        calendarCollectionView.reloadData()
    }
}

extension CostumCalendarDatePickerView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ cv: UICollectionView, cellForItemAt idx: IndexPath) -> UICollectionViewCell {
        guard let cell = cv.dequeueReusableCell(withReuseIdentifier: "CostumCalendarCellView", for: idx) as? CostumCalendarCellView else {
            return UICollectionViewCell()
        }
        
        let date = days[idx.item]
        let cal  = Calendar.current

        let isDisabled: Bool = {
            guard let d = date else {
                return true
            }
            
            if d < minDate || d > maxDate {
                return true
            }
            
          if let start = selectedStartDate, selectedEndDate == nil {
            guard let daysDiff = cal.dateComponents([.day], from: start, to: d).day else {
              return false
            }
              
            if abs(daysDiff) > maxSelectableRangeInDays {
              return true
            }
          }
          return false
        }()
        
        cell.isUserInteractionEnabled = !isDisabled
        
        let isSelected = isDateSelected(date)
        let isInRange = isDateInRange(date)
        let isStart = isStartDate(date)
        let isEnd = isEndDate(date)
        cell.configure(
            date: date,
            isSelected: isSelected,
            isInRange: isInRange,
            isStart: isStart,
            isEnd: isEnd,
            isDisabled: isDisabled
        )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let date = days[indexPath.item],
              date >= minDate,
              date <= maxDate else {
            return
        }
        
        if selectedStartDate == nil || (selectedStartDate != nil && selectedEndDate != nil) {
            selectedStartDate = date
            selectedEndDate = nil
            isSelectingStartDate = false
        } else if selectedEndDate == nil {
            if date >= selectedStartDate! {
                selectedEndDate = date
            } else {
                selectedEndDate = selectedStartDate
                selectedStartDate = date
            }
            
            if let start = selectedStartDate, let end = selectedEndDate {
                onDateRangeSelected?(start, end)
            }
        }
        
        updateDateLabels()
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 48) / 7
        return CGSize(width: width, height: 40)
    }
    
    private func isDateSelected(_ date: Date?) -> Bool {
        guard let date = date else { return false }
        let calendar = Calendar.current
        
        if let start = selectedStartDate, calendar.isDate(date, inSameDayAs: start) {
            return true
        }
        
        if let end = selectedEndDate, calendar.isDate(date, inSameDayAs: end) {
            return true
        }
        
        return false
    }
    
    private func isDateInRange(_ date: Date?) -> Bool {
        guard let date = date,
              let start = selectedStartDate,
              let end = selectedEndDate else { return false }
        
        return date > start && date < end
    }
    
    private func isStartDate(_ date: Date?) -> Bool {
        guard let date = date, let start = selectedStartDate else { return false }
        return Calendar.current.isDate(date, inSameDayAs: start)
    }
    
    private func isEndDate(_ date: Date?) -> Bool {
        guard let date = date, let end = selectedEndDate else { return false }
        return Calendar.current.isDate(date, inSameDayAs: end)
    }
}
