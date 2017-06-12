class AttachmentsController < ApplicationController
  respond_to :js

  def destroy
    @attachment = Attachment.find(params[:id])
    authorize! :destroy, @attachment
    respond_with(@attachment.destroy)
  end
end
