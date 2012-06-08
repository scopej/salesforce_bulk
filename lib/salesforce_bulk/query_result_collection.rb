module SalesforceBulk
  class QueryResultCollection < Array
    
    attr_reader :client
    attr_reader :batch_id
    attr_reader :job_id
    attr_reader :total_size
    attr_reader :result_id
    attr_reader :result_ids
    
    def initialize(client, job_id, batch_id, total_size=0, result_id=nil, result_ids=[])
      @client = client
      @job_id = job_id
      @batch_id = batch_id
      @total_size = total_size
      @result_id = result_id
      @result_ids = result_ids
      @current_index = result_ids.index(result_id)
    end
    
    def next?
      @result_ids.present? && @current_index < @result_ids.length - 1
    end
    
    def next
      # if calls method on client to fetch data and returns new collection instance
      SalesforceBulk::QueryResultCollection.new(self.client, self.job_id, self.batch_id)
    end
    
    def previous?
      @result_ids.present? && @current_index > 0
    end
    
    def previous
      # if has previous, calls method on client to fetch data and returns new collection instance
      SalesforceBulk::QueryResultCollection.new(self.client, self.job_id, self.batch_id)
    end
    
  end
end