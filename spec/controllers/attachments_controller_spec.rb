require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  describe 'DELETE #destroy' do
    sign_in_user
    let(:users_question) { create(:question, user: @user) }
    let(:another_question) { create(:question) }
    before do
      file = File.open("#{Rails.root}/spec/spec_helper.rb")
      users_question.attachments.create(file: file)
      another_question.attachments.create(file: file)
    end

    context 'author tries to delete file from question' do
      it 'deletes attachment' do
        expect { delete :destroy, params: { id: users_question.attachments.last } }
          .to change(Attachment, :count).by(-1)
      end
    end

    context 'user tries to delete file from question that does not belongs to him' do
      it 'does not deletes attachment' do
        expect { delete :destroy, params: { id: another_question.attachments.last } }
          .to_not change(Attachment, :count)
      end

      it 'redirects to questions index view' do
        delete :destroy, params: { id: another_question.attachments.last }
        expect(response).to redirect_to questions_path
      end
    end
  end
end
