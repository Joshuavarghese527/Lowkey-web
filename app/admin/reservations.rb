ActiveAdmin.register Reservation do
permit_params :user, :location, :start_time, :end_time, :price, :total, :status
end
