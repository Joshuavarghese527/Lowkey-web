ActiveAdmin.register Location do
permit_params :location_type, :accomodate, :lisiting_name, :summary, :address, :price, :is_internet, :active, :image, :instant

show do |t|
  attributes_table do
    row :location_type
    row :accomodate 
    row :lisiting_name
    row :summary
    row :address
    row :price
    row :is_internet
    row :active
    row :instant
    row :image do
      location.image? ? image_tag(location.image.url, height: '100') : content_tag(:span, "No Photo Yet")
      end
    end
  end

  form :html => {:enctype => "multipart/form-data" } do |f|
    f.inputs do 
      f.select :location_type, [["Bar", "Bar"], ["Restaurant", "Restaurant"], ["CoWorking", "CoWorking"]]
      f.input :accomodate
      f.input :lisiting_name
      f.input :summary
      f.input :address
      f.input :price
      f.input :is_internet
      f.input :active
      f.select :instant, Location.instants.map {|key,value| [key.humanize, key]}, prompt: "Select...",  selected: 'Instant', class: "form-control"
      f.input :image, multiple: true, hint: f.location.image? ? image_tag(location.image.url, height: '100') : content_tag(:span, "Upload JPG/PNG/GIF image")
    end
    f.actions
  end
end
