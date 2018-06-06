class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action { set_locale(get_browser_locale, Settings.languages[:available_languages]) }

    def set_locale(browser_locales, available_locales)
    I18n.locale = Settings.languages.default_language
    browser_locales.each do |browser_locale|
      if available_locales.include?(browser_locale)
        I18n.locale = browser_locale
        break
      end
    end
    puts "Avaiable Languages: #{Settings.languages[:available_languages]}\nDefault Language: #{Settings.languages[:default_language]}\nBrowser Preferred Languages: #{browser_locales}\nLocale set to #{I18n.locale.upcase}" unless Rails.env.test?
    I18n.locale
  end

  def get_browser_locale
  	begin
  		request.env['HTTP_ACCEPT_LANGUAGE'].scan(/[a-z]{2}(?=; || ?=,)/)
  	rescue
  		[Settings.languages[:default_language]]
  	end
  end
end
