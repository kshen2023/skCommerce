ActiveAdmin.register AboutPage do
  permit_params :title, :content

  form do |f|
    f.inputs do
      f.input :title
      f.input :content, as: :text_area
    end
    f.actions
  end
end
