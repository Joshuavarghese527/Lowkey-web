ActiveAdmin.register User do
  permit_params :fullname, :email
end
