'use strict';

module.exports.create = async event => {
  return {
    statusCode: 200,
    body: JSON.stringify(event),
  }
};