//
//  ViewController.swift
//  firstapp
//
//  Created by Никита on 14.09.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(normalizeGrades())
    }


    func normalizeGrades() -> [String: Double] {
        IOSNis.students = [
            Student(grades: [3.51, 10, 9], fullName: "Ушакова Ангелина"),
            Student(grades: [7, 8, 7.5], fullName: "Алибек Адхамов")
        ]
        
        var normalizedGrades: [String: Double] = [:]
        var maxAverageGrade: Double = 0
        
        for student in IOSNis.students {
            var averageGrade = student.getGrade()
            
            if averageGrade > maxAverageGrade {
                maxAverageGrade = averageGrade
            }
        }
        
        for student in IOSNis.students {
            normalizedGrades[student.fullName] = student.getNormilizedGrade(
                maxGrade: maxAverageGrade
            )
        }

        return normalizedGrades
    }
}
