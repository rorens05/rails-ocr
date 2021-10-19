class Api::V2::OcrController < Api::V2::ApiController

  before_action :process_image, only: :index

  def index
    image = RTesseract.new(@file_path.to_s)
    render json: {result: image.to_s}
  end

  private

  def process_image
    if params[:base_64_image].blank?
      return render json: {message: "base_64_image is required"}, status: :unprocessable_entity
    end
    regexp = /\Adata:([-\w]+\/[-\w\+\.]+)?;base64,(.*)/m
    dir = Rails.root.join('public', 'ocr')
    Dir.mkdir(dir) unless Dir.exist?(dir)
    data_uri_parts = params[:base_64_image].match(regexp) || []
    extension = Mime::Type.lookup(data_uri_parts[1]).symbol.to_s
    filename = "#{DateTime.now.to_i}#{rand(0-10000)}.#{extension}"
    @file_path = dir.join(filename)
    File.open(@file_path, 'wb') do |f|
      f.write(Base64.decode64(data_uri_parts[2]))  
    end
  end
end
