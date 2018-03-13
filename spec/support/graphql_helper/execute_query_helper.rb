def execute_query(query_string, context, variables)
  res = SuratDuniaSchema.execute(
    query_string,
    context: context,
    variables: variables
  )
  # Print any errors
  if res["errors"]
    pp res
  end
  res.to_h.deep_symbolize_keys!
end
