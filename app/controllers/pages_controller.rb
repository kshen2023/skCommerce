class PagesController < ApplicationController
  def contact
    @contact_page = ContactPage.first  # Adjust how you retrieve the page content as per your design
  end

  def about
    @about_page = AboutPage.first  # Adjust how you retrieve the page content as per your design
  end
end
