//
//  GraphChartView.swift
//  MoneyBuzz
//
//  Created by Consid  on 2022-11-29.
//

import SwiftUI

// In call make sure to convert the values to normalized

struct GraphChartShape: Shape {
    
    var graphDataPoints: [CGFloat]
    func path(in rect: CGRect) -> Path {
        
        func makeGraphPoint(at ix: Int) -> CGPoint {
            let graphPoint = graphDataPoints[ix]
            let x = rect.width * CGFloat(ix) / CGFloat(graphDataPoints.count - 1)
            let y = (1-graphPoint) * rect.height
            
            return CGPoint(x: x, y: y)
        }
        
        return Path { path in
            guard graphDataPoints.count > 1 else {
                return
            }
            let start = graphDataPoints[0]
            path.move(to: CGPoint(x: 0, y: (1-start) * rect.height))
            
            for ix in graphDataPoints.indices {
                path.addLine(to: makeGraphPoint(at: ix))
            }
        }
        
    }
    
    
}

struct GraphCharView: View {
    var body: some View {
        GraphChartShape(graphDataPoints: [0.1, 0.2, 0.5, 0.3, 0.1, 0.5, 0.7])
            .stroke()
            .frame(width: 400, height: 300)
            .border(Color.black)
    }
}

struct GraphChartView_Previews: PreviewProvider {
    static var previews: some View {
        GraphCharView()
    }
}

