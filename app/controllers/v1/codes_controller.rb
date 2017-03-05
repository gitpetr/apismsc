class V1::CodesController < ApplicationController
  def create
    service = ::CodeService.new
    begin
      result = service.create(params)
      return success_response(result.do_hash) unless result.nil?
    rescue Exception => e
      return error_response(e.message)
    end

    error_response('Something went wrong')
  end

  def search
    service = ::CodeService.new
    begin
      result = if params['url'].present?
                 service.search_by_url(params['url'])
               else
                 service.search_by_params(params)
               end
      unless result.nil?
        if result[:count] == 1
          return success_response(result)
        else
          return success_response(result, text_status: (result[:count] == 0 ? 'not_found' : 'several_items_found'))
        end
      end
    rescue Exception => e
      return error_response(e.message)
    end

    error_response('Something went wrong')
  end
end
