class ProfilesSerializer < ActiveModel::Serializer
  attributes :id, :email, :created_at, :updated_at
end
