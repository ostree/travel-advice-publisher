require "travel_advice_edition"
require "gds_api/asset_manager"

class TravelAdviceEdition
  attr_accessor :image

  after_initialize { @image_has_changed = false }
  before_save :upload_image, :if => :image_has_changed?

  def image=(image)
    @image_has_changed = true
    @image = image
  end

  def image_has_changed?
    @image_has_changed
  end

  private
    def upload_image
      @asset_api ||= GdsApi::AssetManager.new(Plek.current.find('asset-manager'))
      response = @asset_api.create_asset(@image)

      self.image_id = response.id.match(/\/([^\/]+)\z/) {|m| m[1] }
    end
end
