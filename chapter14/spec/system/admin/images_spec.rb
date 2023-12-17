require 'rails_helper'

RSpec.describe 'Images' do
  let(:user) { create(:user) }
  let(:img) { Image.last }

  before do
    login_as(user)
  end

  describe 'index' do
    before do
      create(:image)
    end

    it 'renders images' do     
      visit admin_images_path

      within 'table.index_table' do
        within 'td.col-name' do
          expect(page).to have_text(img.name)
        end

        within 'td.col-image' do
          expect(page).to have_xpath(thumbnail_xpath(img))
        end

        within 'td.col-image_tag' do
          expect(page).to have_text(image_tag_string(img))
        end
      end
    end

    it 'deletes an image' do
      visit admin_images_path

      accept_confirm do
        click_link 'Delete'
      end

      within '.flashes' do
        expect(page).to have_css('.flash_notice',
          text: 'Image was successfully destroyed.')
      end
    end
  end

  describe 'new' do
    it 'uploads an image' do
      visit new_admin_image_path

      fill_in 'Name', with: 'Name'
      attach_file 'Image', file_path
      click_button 'Create Image'

      within '.flashes' do
        expect(page).to have_css('.flash_notice',
          text: 'Image was successfully created.')
      end

      validate_show_page(img)
    end
  end

  describe 'edit' do
    let(:name) { 'New Name' }

    before do
      create(:image)
    end

    it 'updates an image' do     
      visit edit_admin_image_path(img)

      within 'form.image' do
        within '.inline-hints' do
          expect(page).to have_xpath(thumbnail_xpath(img))
        end
      end

      fill_in 'Name', with: name
      attach_file 'Image', file_path
      click_button 'Update Image'

      within '.flashes' do
        expect(page).to have_css('.flash_notice',
          text: 'Image was successfully updated.')
      end

      img.reload

      validate_show_page(img)
    end
  end

  private

  def file_path
    Rails.root.join('spec/factories/images/image.jpeg')
  end

  def validate_show_page(img)
    within '.image table' do
      within 'tr.row-name td' do
        expect(page).to have_text(img.name)
      end

      within 'tr.row-image td' do
        expect(page).to have_xpath(thumbnail_xpath(img))
      end

      within 'tr.row-image_tag td' do
        expect(page).to have_text(image_tag_string(img))
      end
    end
  end

  def thumbnail_xpath(img)
    <<~IMG.squish
      //img[@height='80' and
        @alt='#{img.name}' and
        @title='#{img.name}' and
        @src='/images/#{img.id}']
    IMG
  end

  def image_tag_string(img)
    <<~IMG.squish
      <img alt="#{img.name}"
         title="#{img.name}"
         src="/images/#{img.id}" />
    IMG
  end
end
