module PaginationConcern
  include ActiveSupport::Concern

  # Acá estructuro la información de las siguientes páginas que contenga,
  # lo llamo con meta: pagination en los controladores que necesite.
  def pagination (object,params)
    if !object.next_page.nil?
      string_next = "/#{params[:controller]}"
      string_next += (params[:action]!="index")? "/#{params[:action]}" : ""
      string_next += "?page=#{object.next_page}"
      string_next += (params[:action]!="index")? "&id=#{params[:id]}" : ""
    end
    if !object.prev_page.nil?
      string_prev = "/#{params[:controller]}"
      string_prev += (params[:action]!="index")? "/#{params[:action]}" : ""
      string_prev += "?page=#{object.prev_page}"
      string_prev += (params[:action]!="index")? "&id=#{params[:id]}" : ""
    end
    meta={
      next_page: string_next,
      prev_page: string_prev,
      total_in_page: object.count
    }
    return meta
  end
end