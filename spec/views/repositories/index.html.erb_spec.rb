# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'arclight/repositories/index' do
  let(:test_data) { Arclight::Repository.all }

  before do
    ENV['REPOSITORY_FILE'] = 'spec/fixtures/config/repositories.yml'
    assign(:repositories, test_data)
    allow(view).to receive_messages(
      search_action_path: '/',
      on_repositories_index?: true,
      search_catalog_path: '/catalog',
      params: {}
    )
  end

  context 'renders the repository index page' do
    before { render }

    it 'has the hero section' do
      expect(rendered).to have_css('.al-repositories-hero', count: 1)
    end

    it 'has the repositories title' do
      expect(rendered).to have_css('.al-repositories-title', text: 'Repositories')
    end

    it 'has the search container' do
      expect(rendered).to have_css('.al-repositories-search-container', count: 1)
    end

    it 'has the section title' do
      expect(rendered).to have_css('.al-repositories-section-title', text: /SEARCH COLLECTIONS IN/)
    end

    it 'has the repositories grid' do
      expect(rendered).to have_css('.al-repositories-grid', count: 1)
    end

    it 'has repository icon items' do
      expect(rendered).to have_css('.al-repository-icon-item', count: 5)
    end

    it 'has repository links' do
      expect(rendered).to have_css('.al-repository-icon-link', count: 5)
    end

    it 'has repository icons' do
      expect(rendered).to have_css('.al-repository-icon-wrapper', count: 5)
    end

    it 'displays repository names' do
      expect(rendered).to have_css('.al-repository-icon-name', count: 5)
      expect(rendered).to have_css('.al-repository-icon-name', text: /My Repository/)
    end

    it 'links to repository detail pages' do
      expect(rendered).to have_css('a[href="/repositories/sample"]')
    end
  end
end
