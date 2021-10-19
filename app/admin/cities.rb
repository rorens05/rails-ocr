ActiveAdmin.register City do
  menu false
  permit_params :code, :name, :province_id
end
