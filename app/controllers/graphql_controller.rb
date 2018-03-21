class GraphqlController < ApiController
  def execute
    result = SuratDuniaSchema.execute(
      params[:query],
      variables: ensure_hash(params[:variables]),
      context: { current_user: current_user },
      operation_name: params[:operationName]
    )
    render json: result
  end

  private

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    return {} if ambiguous_param.blank? # this include nil, empty string, empty array, empty hash
    return ambiguous_param if [Hash, ActionController::Parameters].include?(ambiguous_param.class)
    ensure_hash(JSON.parse(ambiguous_param)) if ambiguous_param.is_a?(String)
    raise ArgumentError.new("Unexpected parameter: #{ambiguous_param}")
  end
end
