module ApplicationHelper
    def locale(locale)
        I18n.locale == :en ? "Inglês" : "Português do Brasil"
    end
    
    def data_br(data_us)
        data_us.strftime("%d/%m/%Y")
    end

    def ambiente_rails
        if Rails.env.development?
            "desenvolvimento"
        elsif Rails.env.production?
            "Produção"
        else
            "Testes"
        end
    end
end
