exports.handler = async function(event, context) {
  console.log('## ENVIRONMENT VARIABLES: ' + serialize(process.env))
  console.log('## CONTEXT: ' + serialize(context))
  console.log('## EVENT: ' + serialize(event))
  console.log('## BODY: ' + event.body)
  
  return {
    statusCode: 200,
    body: JSON.stringify({
      message: "hello world!",
    }),
  };
}

var serialize = function(object) {
  return JSON.stringify(object, null, 2)
}