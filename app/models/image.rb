class Image < ApplicationRecord
  mount_uploader :file, PictureUploader
end
