# frozen_string_literal: true

RSpec.describe 'Selectize inputs', type: :system do
  let(:authors) do
    Array.new(3) do |i|
      Author.create!(email: "some_email_#{i}@example.com", name: "John #{i}", age: 30 + i * 3)
    end
  end
  let(:post) { Post.create!(title: 'Test', author: authors.last) }
  let(:tags) do
    Array.new(3) do |i|
      Tag.create!(name: "A tag #{i}")
    end
  end

  before do
    post.tags << tags.last
  end

  after do
    post.destroy
    authors.each(&:destroy)
    tags.each(&:destroy)
  end

  context 'with a single value selectize input' do
    let(:hidden_input) { '#post_author_input [data-selectize-input]' }
    let(:selectize_control) { '#post_author_input .selectize-control.single' }
    let(:selectize_input) { '#post_author_input .selectize-input' }

    it 'includes the hidden select and the selectize-input element' do
      visit "/admin/posts/#{post.id}/edit"

      expect(page).to have_select('post[author_id]', visible: :hidden, selected: authors.last.name)
      expect(page).to have_css(selectize_input)
    end

    it 'updates the entity association' do
      visit "/admin/posts/#{post.id}/edit"

      find(selectize_input).click
      find("#{selectize_control} .selectize-dropdown-content", text: 'John 1').click
      find('[type="submit"]').click
      expect(page).to have_content('was successfully updated')
      expect(post.reload.author).to eq(authors.find { |item| item.name == 'John 1' })
    end
  end

  context 'with a multiple values selectize input' do
    let(:hidden_input) { '#post_tags_input [data-selectize-input]' }
    let(:selectize_control) { '#post_tags_input .selectize-control.multi' }
    let(:selectize_input) { '#post_tags_input .selectize-input' }

    it 'includes the hidden select and the selectize-input element' do
      visit "/admin/posts/#{post.id}/edit"

      expect(page).to have_select('post[tag_ids][]', visible: :hidden, selected: tags.last.name)
      expect(page).to have_css(selectize_input)
    end

    it 'updates the entity association' do
      visit "/admin/posts/#{post.id}/edit"

      find(selectize_input).click
      find('#post_tags_input .option', text: 'A tag 1').click
      scroll_to(find('#post_submit_action'))
      find('[type="submit"]').click
      expect(page).to have_content('was successfully updated')
      expect(post.reload.tags).to include(tags.find { |item| item.name == 'A tag 1' })
    end
  end
end
