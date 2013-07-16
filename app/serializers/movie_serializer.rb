class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :genres, :year
end
