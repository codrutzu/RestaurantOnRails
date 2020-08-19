module ProductsHelper
  def blob_for(name)
    ActiveStorage::Blob.create_after_upload!(
      io: File.open(Rails.root.join(file_fixture(name))),
      filename: name,
      content_type: 'image/jpeg'
    )
  end
end