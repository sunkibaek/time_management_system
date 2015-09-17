json.tasks @tasks do |task|
  json.id task.id
  json.description task.description
  json.date task.date
  json.hour task.hour
  json.totalHour task.total_hour
  json.userName task.user_name
  json.userPreferredWorkingHour task.user_preferred_working_hour
  json.createdAt task.created_at
end
