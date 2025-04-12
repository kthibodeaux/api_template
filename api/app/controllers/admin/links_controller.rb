# frozen_string_literal: true

module Admin
  class LinksController < AdminApplicationController
    def index
      authorize Admin::Link

      if Rails.env.development?
        render json: Admin::LinkBlueprint.render(all_environment_links + development_environment_links)
      else
        render json: Admin::LinkBlueprint.render(all_environment_links)
      end
    end

    private

    def all_environment_links
      [
        Admin::Link.new(name: 'Good Job', url: good_job_url, icon: 'thumbs-up')
      ]
    end

    def development_environment_links
      [
        Admin::Link.new(name: 'Letter Opener', url: letter_opener_web_url, icon: 'mail-open')
      ]
    end
  end
end
