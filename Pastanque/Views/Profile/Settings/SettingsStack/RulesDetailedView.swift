import SwiftUI

struct RulesDetailedView: View {
    var backAction: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Button(action: backAction) {
                    Image(systemName: "chevron.left")
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.customWhite)
                }
                
                Spacer()
                
                Text("Règles")
                    .font(.custom(FontStyles.medium, size: FontStyles.normal))
                    .foregroundColor(Color.customWhite)
                
                Spacer()
                
                Image(systemName: "chevron.left")
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.clear)
                    .disabled(true)
            }
            .padding(.bottom, 16)
            ScrollView {
                    Text("On te file 50 crédits pour démarrer. Ne les gaspilles pas tous en même temps, ou tentes le coup du siècle !")
                        .font(.custom(FontStyles.light, size: FontStyles.normal))
                        .foregroundColor(Color.customWhite)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        Spacer()
                        VStack {
                            Divider()
                                .background(Color.grey200)
                        }
                        .frame(height: 2)
                        Spacer()
                    }
                    
                    
                    Text("Dès que tu places un pari, tu gagnes de l'expérience, elle est calculée en fonction de ta mise et de la cote de ton pari.")
                        .font(.custom(FontStyles.light, size: FontStyles.normal))
                        .foregroundColor(Color.customWhite)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    
                    HStack {
                        Spacer()
                        VStack {
                            Divider()
                                .background(Color.grey200)
                        }
                        .frame(height: 2)
                        Spacer()
                    }
                    
                    Text("Si tu tombes à 0, c'est l'heure de la remontada. Tu peux toujours parier avec une mise max de 5 et un pari à la fois !")
                        .font(.custom(FontStyles.light, size: FontStyles.normal))
                        .foregroundColor(Color.customWhite)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    
                    HStack {
                        Spacer()
                        VStack {
                            Divider()
                                .background(Color.grey200)
                        }
                        .frame(height: 2)
                        Spacer()
                    }
                    
                    Text("Pour certains tournois et défis, on peut te demander d'être en positif, faut quand même pas déconner.")
                        .font(.custom(FontStyles.light, size: FontStyles.normal))
                        .foregroundColor(Color.customWhite)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    
                    HStack {
                        Spacer()
                        VStack {
                            Divider()
                                .background(Color.grey200)
                        }
                        .frame(height: 2)
                        Spacer()
                    }
                    
                    Text("Si tu veux vraiment nous rouler dessus, tu peux même échanger tes gains contre des Gems !")
                        .font(.custom(FontStyles.light, size: FontStyles.normal))
                        .foregroundColor(Color.customWhite)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    
                    HStack {
                        Spacer()
                        VStack {
                            Divider()
                                .background(Color.grey200)
                        }
                        .frame(height: 2)
                        Spacer()
                    }
                    
                    Text("Une fois que tu t'es fait la main, viens affronter d'autres joueurs dans des tournois titanesques.")
                        .font(.custom(FontStyles.light, size: FontStyles.normal))
                        .foregroundColor(Color.customWhite)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    
                    HStack {
                        Spacer()
                        VStack {
                            Divider()
                                .background(Color.grey200)
                        }
                        .frame(height: 2)
                        Spacer()
                    }
                    
                    Text("Débloque des championnats et atteint des niveaux spécifiques pour participer à des événements épiques.")
                        .font(.custom(FontStyles.light, size: FontStyles.normal))
                        .foregroundColor(Color.customWhite)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    
                    HStack {
                        Spacer()
                        VStack {
                            Divider()
                                .background(Color.grey200)
                        }
                        .frame(height: 2)
                        Spacer()
                    }
                    
                    Text("Tout est virtuel ici, tes gains ne te rendront pas riche dans la vraie vie. Mais l'expérience, ça, c'est réel !")
                        .font(.custom(FontStyles.light, size: FontStyles.normal))
                        .foregroundColor(Color.customWhite)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    
                    HStack {
                        Spacer()
                        VStack {
                            Divider()
                                .background(Color.grey200)
                        }
                        .frame(height: 2)
                        Spacer()
                    }
                }
            Spacer()
        }
    }
}
