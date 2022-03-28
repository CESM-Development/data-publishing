while read id
do
  echo curl --header \"authorization: api-token <insert_your_api_token_here>\" -X POST https://www.earthsystemgrid.org/api/v1/publishing/delete.json?id=${id} '| python -m json.tool'
done < $1

# note, you can retract datasets by replacing 'delete.json' with 'retract.json'