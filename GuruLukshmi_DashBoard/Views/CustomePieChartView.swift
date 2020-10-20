//
//  CustomePieChartView.swift
//  GuruLukshmi_DashBoard
//
//  Created by Dhruvil Patel on 2020-10-20.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import SwiftUI

struct CustomePieChartView: View {
    @State var selectedPie: String = ""
    @ObservedObject var orderVM = OrderViewModel()
    @State var arrayOfMostSoldFood : [Food] = []
    var sample1 : [ChartCellModel]
    @State var colorArray : [Color] = [Color.red, Color.yellow, Color.green, Color.blue, Color.purple]
    var body: some View {
        VStack(spacing: 15.0) {
                Text("Most Item Sold").bold().font(.largeTitle)
                HStack(spacing: 20) {
                    PieChart(dataModel: ChartDataModel.init(dataModel: sample1), onTap: {
                        dataModel in
                        if let dataModel = dataModel {
                            self.selectedPie = "Food Name: \(dataModel.name)\nSold: \(String(format: "%.0f", dataModel.value))"
                        } else {
                            self.selectedPie = ""
                        }
                    })
                    .frame(width: 300, height: 300, alignment: .center)
                    .padding()
                    Text(selectedPie)
                        .font(.title3)
                        .multilineTextAlignment(.leading)
                    
                    
                }
                
                HStack(spacing: 30.0) {
                    ForEach(sample1) { dataSet in
                        VStack {
                            Circle().foregroundColor(dataSet.color)
                                .frame(width: 30, height: 30, alignment: .center)
                            Text(dataSet.name).font(.title3)
                        }
                    }
                    
                }
            }.padding(.bottom, 50)
            
    }
}

struct CustomePieChartView_Previews: PreviewProvider {
    static var previews: some View {
        CustomePieChartView( sample1: sample)
    }
}

let sample = [ ChartCellModel(color: Color.red, value: 123, name: "Math"),
               ChartCellModel(color: Color.yellow, value: 233, name: "Physics"),
               ChartCellModel(color: Color.purple, value: 73, name: "Chemistry"),
               ChartCellModel(color: Color.blue, value: 7, name: "Litrature"),
               ChartCellModel(color: Color.green, value: 51, name: "Art")]

struct PieChartCell: Shape {
    let startAngle: Angle
    let endAngle: Angle
    func path(in rect: CGRect) -> Path {
        let center = CGPoint.init(x: (rect.origin.x + rect.width)/2, y: (rect.origin.y + rect.height)/2)
        let radii = min(center.x, center.y)
        let path = Path { p in
            p.addArc(center: center,
                     radius: radii,
                     startAngle: startAngle,
                     endAngle: endAngle,
                     clockwise: true)
            p.addLine(to: center)
        }
        return path
    }
}

struct PieChart: View {
    @State private var selectedCell: UUID = UUID()
    
    let dataModel: ChartDataModel
    let onTap: (ChartCellModel?) -> ()
    var body: some View {
        ZStack {
            ForEach(dataModel.chartCellModel) { dataSet in
                PieChartCell(startAngle: self.dataModel.angle(for: dataSet.value), endAngle: self.dataModel.startingAngle)
                    .foregroundColor(dataSet.color)
                    .onTapGesture {
                        withAnimation {
                            if self.selectedCell == dataSet.id {
                                self.onTap(nil)
                                self.selectedCell = UUID()
                            } else {
                                self.selectedCell = dataSet.id
                                self.onTap(dataSet)
                            }
                        }
                    }.scaleEffect((self.selectedCell == dataSet.id) ? 1.05 : 1.0)
            }
        }
    }
}

struct ChartCellModel: Identifiable {
    let id = UUID()
    let color: Color
    let value: CGFloat
    let name: String
}

final class ChartDataModel: ObservableObject {
    var chartCellModel: [ChartCellModel]
    var startingAngle = Angle(degrees: 0)
    private var lastBarEndAngle = Angle(degrees: 0)
    
    
    init(dataModel: [ChartCellModel]) {
        chartCellModel = dataModel
    }
    
    var totalValue: CGFloat {
        chartCellModel.reduce(CGFloat(0)) { (result, data) -> CGFloat in
            result + data.value
        }
    }
    
    func angle(for value: CGFloat) -> Angle {
        if startingAngle != lastBarEndAngle {
            startingAngle = lastBarEndAngle
        }
        lastBarEndAngle += Angle(degrees: Double(value / totalValue) * 360 )
        print(lastBarEndAngle.degrees)
        return lastBarEndAngle
    }
}


