module Spree
  module MailHelper
    include BaseHelper

    def variant_image_url(variant)
      image = default_image_for_product_or_variant(variant)
      image ? main_app.url_for(image.url(:small)) : 'noimage/small.png'
    end

    def name_for(order)
      order.name || Spree.t('customer')
    end

    def store_logo
      @store_logo ||= current_store&.mailer_logo || current_store&.logo
    end

    def default_logo
      ActiveSupport::Deprecation.warn(<<-DEPRECATION, caller)
        `MailHelper#default_logo` is deprecated and will be removed in Spree 5.0.
        Please upload a Store logo instead
      DEPRECATION

      'logo/spree_50.png'
    end

    def logo_path
      return default_logo unless store_logo.attached?
      return main_app.url_for(store_logo.variant(resize: '244x104>')) if store_logo.variable?

      return main_app.url_for(store_logo) if store_logo.image?
    end
  end
end
