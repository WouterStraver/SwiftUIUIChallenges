//
//  CustomLayout.swift
//  SwiftUIUIChallenges (iOS)
//
//  Created by Wouter Straver on 12/11/2022.
//

import SwiftUI

struct CustomLayoutView: View {
    var body: some View {
        ScrollView {
            CustomLayout {
                Rectangle()
                    .frame(height: 150)
                    .foregroundColor(.red)
                Rectangle()
                    .frame(height: 75)
                    .foregroundColor(.blue)
                ForEach(0..<9, id:\.self) { _ in
                    Rectangle()
                        .frame(height: 190)
                        .foregroundColor(.yellow.opacity(1))
                }
            }
            .padding()
            
            
        }.background(Color.green)
    }
}

struct CustomLayout: Layout {
    var spacing: CGFloat = 10
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let subViewCount: CGFloat = CGFloat(subviews.count)
        let totalSpacing = subViewCount * spacing
        let heightOfSubViews = (subviews.compactMap { view in
            view.sizeThatFits(proposal).height
        }.max() ?? 0) * (subViewCount / 2) //Max size times half of the elements (not really that accurate)
                    
        return .init(width: proposal.width ?? 0, height: heightOfSubViews + totalSpacing)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var origin = bounds.origin
        let maxWidth = bounds.width
               
        let regularWidth = (maxWidth / 2) - (spacing / 2)
       
        let size: ProposedViewSize = .init(width: regularWidth, height: proposal.height ?? 150)
        
        var row: ([LayoutSubviews.Element], Double) = ([], 0.0)
        var rows: [([LayoutSubviews.Element], Double)] = []
        
        for view in subviews {
            let viewSize = view.sizeThatFits(size)
            if (origin.x + viewSize.width - bounds.minX) > maxWidth {
                //This gives the remaing space in a row.
                row.1 = (maxWidth - origin.x + bounds.minX + spacing)
                rows.append(row)
                row.0.removeAll()
                //Resetting horizontal Axis
                origin.x = bounds.origin.x
                // Next View
                row.0.append(view)
                origin.x += (viewSize.width)
            } else {
                row.0.append(view)
                origin.x += (viewSize.width + spacing)
            }
        }
        
        //MARK: Last ones
        if !row.0.isEmpty {
            row.1 = (maxWidth - origin.x  + bounds.minX + spacing)
            rows.append(row)
        }
        
        //MARK: Resetting origin
        origin = bounds.origin
        
        for row in rows {
            //Resetting x for new rows.
            origin.x = bounds.minX
            
            for view in row.0 {
                let viewSize = view.sizeThatFits(size)
                origin.y = bounds.minY + heightOfCurrentColumn(rows: rows, currentRow: row, view: view, proposal: proposal)
                view.place(at: origin, proposal: size)
                origin.x += viewSize.width + spacing
            }
        }
    }
    
    func heightOfCurrentColumn(rows: [([LayoutSubviews.Element], Double)], currentRow: ([LayoutSubviews.Element], Double), view: LayoutSubviews.Element, proposal: ProposedViewSize) -> CGFloat {
        guard let rowIndex = rows.firstIndex(where: {$0.0 == currentRow.0}),
              let columnIndex = currentRow.0.firstIndex(where: {$0 == view})
        else {return 0}
        
        let rowsBefore = rows[..<rowIndex]
        let totalHeight = rowsBefore.compactMap { row -> CGFloat? in
            if row.0.count  - 1 >= columnIndex {
             return row.0[columnIndex].sizeThatFits(proposal).height + spacing
            } else {
                return nil
            }
        }.reduce(0, +)
        return totalHeight
    }
}

struct CustomLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        CustomLayoutView()
    }
}
