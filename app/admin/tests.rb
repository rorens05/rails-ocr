ActiveAdmin.register_page "Tests" do
  menu false

  content title: "Tests" do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      
      panel "OCR" do
        
        form do
          input type: "file", id: "file-input", name:"image", accept: "image/*"
          button "SUBMIT", id: "ocr-btn", class: "btn primary", type: "submit"
        end
        columns do
          column class: 'border p-3'  do
            para "optiic.dev"
            textarea "", class: 'output-area', id: "optiic-area", rows: 10, readonly: true
          end
          column class: 'border p-3' do
            para "ocr.space" 
            textarea "", class: 'output-area', id: "ocr-area", rows: 10, readonly: true
          end
          column class: 'border p-3' do
            para "rtesseract" 
            textarea "", class: 'output-area', id: "rtesseract-area", rows: 10, readonly: true
          end
        end
      end

    end

    
  end 
end
