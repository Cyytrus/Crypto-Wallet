namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD...") { %x(rails db:drop) }
      show_spinner("Criando BD...") { %x(rails db:create) }
      show_spinner("Migrando BD...") { %x(rails db:migrate) }
      %x(rails dev:add_coins)
      %x(rails dev:add_mining_types)
    else
      puts "Você não está no ambiente de desenvolvimento"
    end
  end
  
  desc "Cadastra as moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando moedas...") do
        coins = [
                  {
                    description: "Bitcoin",
                    acronym: "BTC",
                    url_image: "https://imagensemoldes.com.br/wp-content/uploads/2020/09/Imagem-Dinheiro-Bitcoin-PNG.png"
                  },


                  {
                    description: "Ethereum",
                    acronym: "ETH",
                    url_image: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/ETHEREUM-YOUTUBE-PROFILE-PIC.png/600px-ETHEREUM-YOUTUBE-PROFILE-PIC.png"
                  },


                  {
                    description: "Dash",
                    acronym: "DASH",
                    url_image: "https://waytomine.com/wp-content/uploads/2018/11/Dashcoin-Logo.png"
                  },

                  {
                    description: "Iota",
                    acronym: "MIOTA",
                    url_image: "https://img1.gratispng.com/20180901/obr/kisspng-iota-cryptocurrency-blockchain-directed-acyclic-gr-bitcoinaverge-cryptocurrency-marketcap-amp-excha-5b8a2f02021038.2767078915357826580085.jpg"
                  },

                  {
                    description: "ZCash",
                    acronym: "ZEC",
                    url_image: "https://img2.gratispng.com/20180524/rbc/kisspng-zcash-logo-cryptocurrency-cash-coupons-5b06a838ea8466.5309779315271629369606.jpg"
                  },

                  {
                    description: "Cardano",
                    acronym: "ADA",
                    url_image: "https://logospng.org/download/cardano/logo-cardano-512.png"
                  }
                ]  
      coins.each do |coin|
        Coin.find_or_create_by!(coin)
      end
    end
  end

  desc "Cadastro dos tipos de mineração"
  task add_mining_types: :environment do
    show_spinner("Cadastrando tipos de mineração") do
      mining_types = [
                      {description: "Proof of Work", acronym: "PoW"},
                      {description: "Proof of Stake", acronym: "PoS"},
                      {description: "Proof of Capacity", acronym: "PoC"}
                    ]
      mining_types.each do |ming_type|
        MiningType.find_or_create_by!(ming_type)
      end
    end
  end

  private
  
  def show_spinner(msg_start, msg_end = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end

