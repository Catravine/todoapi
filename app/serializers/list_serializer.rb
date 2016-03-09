class ListSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :title, :user_id

  def created_at
    object.created_at.strftime('%B %d, %Y')
  end
end
