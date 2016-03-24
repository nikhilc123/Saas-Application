module ApplicationHelper
  def bootstrap_class_for flash_type
    case flash_type
      when "success"
        "alert-success" #Green
      when "notice"
        "alert-info"    #Blue
      when "alert"
        "alert-warning" #Yellow
      when "error"
        "alert-danger" #Red
      else flash_type.to_s
    end
  end
end
