import SwiftUI

struct CustomTabBar: View {
    @ObservedObject var viewModel: TabBarViewModel
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<viewModel.tabItems.count, id: \.self) { index in
                let tab = viewModel.tabItems[index]
                TabBarItem(
                    title: tab.title,
                    iconNameOn: tab.iconNameOn,
                    iconNameOff: tab.iconNameOff,
                    isSelected: viewModel.selectedTab == index,
                    action: { viewModel.selectedTab = index }
                )
                .frame(width: UIScreen.main.bounds.width / CGFloat(viewModel.tabItems.count))
            }
        }
        .padding(.horizontal, 8)
        .padding(.top, 4)
        .background(Color.grey600)
    }
}
