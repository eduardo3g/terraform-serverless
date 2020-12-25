'use strict';

module.exports.send = async event => {
  console.log(JSON.stringify(event));

  return { message: 'Go Serverless v1.0! Your function executed successfully!', event };
};
