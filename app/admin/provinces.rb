ActiveAdmin.register Province do
  menu false
  permit_params :region_id, :name, :code
end
