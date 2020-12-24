const jwt = require('jsonwebtoken');

exports.authorizer = function(event, context, callback) {
  const authHeader = event.authorizationToken; 

  try {
    const [, token] = authHeader.split(' ');

    const user = jwt.verify(token, process.env.JWT_SECRET);
    callback(null, generatePolicy('user', 'Allow', event.methodArn, user));
  } catch (exception) {
    console.log(exception);
    callback(null, generatePolicy('user', 'Deny', event.methodArn));
  }
};

const generatePolicy = function(principalId, effect, resource, user) {
  let authResponse = {};
  
  authResponse.principalId = principalId;
  if (effect && resource) {
      let policyDocument = {};
      policyDocument.Version = '2012-10-17'; 
      policyDocument.Statement = [];
      let statementOne = {};
      statementOne.Action = 'execute-api:Invoke'; 
      statementOne.Effect = effect;
      statementOne.Resource = resource;
      policyDocument.Statement[0] = statementOne;
      authResponse.policyDocument = policyDocument;
  }
  
  if (user) {
    authResponse.context = user;
  }
  return authResponse;
}