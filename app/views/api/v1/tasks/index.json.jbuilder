json.tasks @tasks do |task|
  json.(task, :id, :description, :date, :hour, :total_hour, :created_at)
end

json.notice flash[:notice]
