'use strict';

const messagebird = require('messagebird')(process.env.MESSAGE_BIRD_API_KEY);

module.exports.send = async event => {
    const smsPromises = [];

    for (let record of event.Records) {
      const message = JSON.parse(record.body).Message;
      
      smsPromises.push(sendMessagePromise(message))
    }

    await Promise.all(smsPromises);
    
    console.log('SMSs sent successfully');
    
    return {
      message: 'Go Serverless v1.0! Your function executed successfully!',
      event,
    };
};

const sendMessagePromise = message => {
  return new Promise((res, rej) => {
    messagebird.messages.create({
      originator: process.env.SMS_PHONE_FROM,
      recipients: [process.env.SMS_PHONE_TO],
      body: message,
    }, (err, callback) => {
      if (!err) {
        console.log(JSON.stringify(callback));
        return res({});
      }
      return (rej(err));
    });
  });
};