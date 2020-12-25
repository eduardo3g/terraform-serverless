'use strict';

const nodemailer = require('nodemailer');

const transporter = nodemailer.createTransport({
  host: process.env.SMTP_SERVER,
  port: 465,
  secure: true,
  auth: {
    user: process.env.EMAIL_FROM,
    pass: process.env.EMAIL_FROM_PASSWORD,
  },
});

module.exports.send = async event => {
  let emailPromises = [];

  for (let record of event.Records) {
    const message = JSON.parse(record.body).Message;

    emailPromises.push(transporter.sendMail({
      from: `"Reservations 👻" <${process.env.EMAIL_FROM}>`,
      to: process.env.EMAIL_TO,
      subject: "Reservation confirmed ✔",
      text: message,
      html: message,
    }));
  }

  await Promise.all(emailPromises);
  
  console.log('All the email were sent successfully');  

  return { message: 'Go Serverless v1.0! Your function executed successfully!', event };
};
