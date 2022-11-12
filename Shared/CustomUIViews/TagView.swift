//
//  TagView.swift
//  SwiftUIUIChallenges (iOS)
//
//  Created by Wouter Straver on 12/11/2022.
//

import SwiftUI

struct TagView: View {
    @State var tags: [Tag] = rawTags.compactMap { tag in
        Tag(name: tag)
    }
    var body: some View {
        VStack{
            TagLayout(alignment: .center, spacing: 10) {
                ForEach($tags) { $tag in
                    Toggle(tag.name, isOn: $tag.isSelected)
                        .toggleStyle(.button)
                        .buttonStyle(.bordered)
                        .tint(.red)
                }
                ForEach($tags) { $tag in
                    Toggle(tag.name, isOn: $tag.isSelected)
                        .toggleStyle(.button)
                        .buttonStyle(.bordered)
                        .tint(.red)
                }
                ForEach($tags) { $tag in
                    Toggle(tag.name, isOn: $tag.isSelected)
                        .toggleStyle(.button)
                        .buttonStyle(.bordered)
                        .tint(.red)
                }
                ForEach($tags) { $tag in
                    Toggle(tag.name, isOn: $tag.isSelected)
                        .toggleStyle(.button)
                        .buttonStyle(.bordered)
                        .tint(.red)
                }
                ForEach($tags) { $tag in
                    Toggle(tag.name, isOn: $tag.isSelected)
                        .toggleStyle(.button)
                        .buttonStyle(.bordered)
                        .tint(.red)
                }
                ForEach($tags) { $tag in
                    Toggle(tag.name, isOn: $tag.isSelected)
                        .toggleStyle(.button)
                        .buttonStyle(.bordered)
                        .tint(.red)
                }
                ForEach($tags) { $tag in
                    Toggle(tag.name, isOn: $tag.isSelected)
                        .toggleStyle(.button)
                        .buttonStyle(.bordered)
                        .tint(.red)
                }
                ForEach($tags) { $tag in
                    Toggle(tag.name, isOn: $tag.isSelected)
                        .toggleStyle(.button)
                        .buttonStyle(.bordered)
                        .tint(.red)
                }
                ForEach($tags) { $tag in
                    Toggle(tag.name, isOn: $tag.isSelected)
                        .toggleStyle(.button)
                        .buttonStyle(.bordered)
                        .tint(.red)
                }
            }
            .padding()
        }
        .navigationTitle("TagView")
    }
}


struct TagLayout: Layout {
    var alignment: Alignment = .center
    var spacing: CGFloat = 10
    
    init(alignment: Alignment, spacing: CGFloat) {
        self.alignment = alignment
        self.spacing = spacing
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        return .init(width: proposal.width ?? 0, height: proposal.height ?? 0)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        
        var origin = bounds.origin
        let maxWidth = bounds.width
        
        //MARK: Type 2
        var row: ([LayoutSubviews.Element], Double) = ([], 0.0)
        var rows: [([LayoutSubviews.Element], Double)] = []
        
        for view in subviews {
            let viewSize = view.sizeThatFits(proposal)
            if (origin.x + viewSize.width + spacing) > maxWidth {
                //This gives the remaing space in a row.
                row.1 = (maxWidth - origin.x + bounds.minX + spacing)
                rows.append(row)
                row.0.removeAll()
                //Resetting horizontal Axis
                origin.x = bounds.origin.x
                // Next View
                row.0.append(view)
                origin.x += (viewSize.width + spacing)
            } else {
                row.0.append(view)
                origin.x += (viewSize.width + spacing)
            }
        }
        
        //MARK: Exhaust ones
        if !row.0.isEmpty {
            row.1 = (maxWidth - origin.x  + bounds.minX + spacing)
            rows.append(row)
        }
        
        //MARK: Resetting origin
        origin = bounds.origin
        
        for row in rows {
            //Resetting x for new rows.
            origin.x = (alignment == .leading ? bounds.minX : (alignment == .trailing ? row.1 : row.1 / 2))
            for view in row.0 {
                let viewSize = view.sizeThatFits(proposal)
                view.place(at: origin, proposal: proposal)
                origin.x += viewSize.width + spacing
            }
            
            let maxHeight = row.0.compactMap { view -> CGFloat? in
                return view.sizeThatFits(proposal).height
            }.max() ?? 0
            origin.y += (maxHeight + spacing)
        }
        
        //MARK: Type 1
//        subviews.forEach { view in
//            let viewSize = view.sizeThatFits(proposal)
//            // Checking if View is going over MaxWidh
//            if (origin.x + viewSize.width + spacing) > maxWidth {
//                //  Updating origin for next element in vertical order.
//                origin.y += (viewSize.height + spacing)
//                origin.x = bounds.origin.x
//                // Next View
//                view.place(at: origin, proposal: proposal)
//                //Updating origin for next view placement. And add spacing
//                origin.x += (viewSize.width + spacing)
//            } else {
//                view.place(at: origin, proposal: proposal)
//                //Updating origin for next view placement. And add spacing
//                origin.x += (viewSize.width + spacing)
//            }
//        }
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            TagView()
        }
    }
}


var rawTags = ["Swift", "UI", "Test", "Tags", "Something else", "Testing", "With more", "And something else. "]

struct Tag: Identifiable {
    var id = UUID().uuidString
    var name: String
    var isSelected: Bool = false
}
