class Api::V1::PostSerializer
  include JSONAPI::Serializer
  attributes :title, :body, :published_at, :updated_at, :created_at
end
