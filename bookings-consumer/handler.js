'use strict';

module.exports.listen = async event => {
  console.log(JSON.stringify(event));
  return {  message: 'Go Serverless v1.0! Your function executed successfully!' };
};
