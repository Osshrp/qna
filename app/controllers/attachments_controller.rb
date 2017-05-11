class AttachmentsController < ApplicationController
  def destroy
    @attachment = Attachment.find(params[:id])
    if current_user.author_of?(@attachment.attachmentable)
      @attachment.destroy
    else
      redirect_to questions_path,
        alert: 'You do not have permission to delete this attachment'
    end
  end
end
