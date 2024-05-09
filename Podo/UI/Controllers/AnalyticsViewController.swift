//
//  AnalyticsViewController.swift
//  PoDo
//
//  Created by Recep Taha Aydın on 11.03.2024.
//

import UIKit
import Charts

class AnalyticsViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var barChart: BarChartView!
    
    let firestoreManager = FirestoreManager()
    private var selectedSliceIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TaskManager.shared.tasks = []
        TaskManager.shared.filteredTasks = []
        showLoadingIndicator()
        self.firestoreManager.readTasksFromDatabase { [weak self] in
            self?.hideLoadingIndicator()
            self?.setupPieChart()
            self?.setupBarChart()
        }
        pieChart.delegate = self
        barChart.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupPieChart()
        setupBarChart()
    }
    
    private func setupPieChart() {
        // TaskManager içindeki tasks array'ini kullanarak kategorilere göre görev sayısını hesapla
        let categoryCounts = Dictionary(grouping: TaskManager.shared.tasks, by: { $0.category })
            .mapValues { $0.count }

        // Veri noktalarını oluştur
        let entries = categoryCounts.map { (category, count) in
            PieChartDataEntry(value: Double(count), label: category)
        }
        
        // Veri setini oluştur
        let dataSet = PieChartDataSet(entries: entries, label: "")
        dataSet.colors = ChartColorTemplates.pastel()

        // Veri setini kullanarak veri oluştur
        let data = PieChartData(dataSet: dataSet)

        // Pasta grafiği görünümüne veriyi ata
        pieChart.data = data
        pieChart.drawEntryLabelsEnabled = false
        pieChart.usePercentValuesEnabled = true

        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        formatter.multiplier = 1.0

        // Değer formatlayıcıyı kullanarak yüzde değerlerini güncelle
        dataSet.valueFormatter = DefaultValueFormatter(formatter: formatter)
        pieChart.holeColor = .systemBackground
        pieChart.highlightPerTapEnabled = true
    }
    
    private func setupBarChart() {
        var entries = [BarChartDataEntry]()
        for x in 0..<5 {
            entries.append(BarChartDataEntry(x: Double(x), y: Double(x)))
        }
        let set = BarChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.pastel()
        let data = BarChartData(dataSet: set)
        barChart.data = data
    }
}
