ActiveAdmin.register User do
  permit_params :name,
                :email,
                :password,
                :password_confirmation

  remove_filter :password_salt, :password_hash
                
  form do |f|
    f.semantic_errors
    inputs do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :name
    column :email
    actions
  end

  show do
    attributes_table do
      row :name
      row :email
    end
  end
end
