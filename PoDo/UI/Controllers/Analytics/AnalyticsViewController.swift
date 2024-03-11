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
    
    let firestoreManager = FirestoreManager()
    private var selectedSliceIndex: Int?
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .podoRed
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TaskManager.shared.tasks = []
        TaskManager.shared.filteredTasks = []
        showLoadingIndicator()
        self.firestoreManager.readTaskFromDatabase { [weak self] in
            self?.hideLoadingIndicator()
            self?.setupPieChart()
        }
        pieChart.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupPieChart()
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
    
    private func showLoadingIndicator() {
        view.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        loadingIndicator.startAnimating()
    }
    
    private func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
        loadingIndicator.removeFromSuperview()
    }
}
