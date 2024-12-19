<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="com.eazydeals.helper.ConnectionPoolImpl"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Send Email with EmailJS</title>
    <script src="https://cdn.emailjs.com/dist/email.min.js"></script>
    <script type="text/javascript">
        (function(){
            emailjs.init("uubQKL1Ge-WhfJ_wf");  // Thay YOUR_USER_ID bằng User ID của bạn từ EmailJS
        })();
        
        function sendEmail() {

            // lấy thông tin từ form
            var templateParams = {
                name: document.getElementById('name').value,
                to: document.getElementById('email').value,
                message: document.getElementById('message').value
            };

            emailjs.send('service_n6rzpjt', 'template_m8ahgh6', templateParams)
                .then(function(response) {
                   console.log('SUCCESS!', response.status, response.text);
                   alert('Email sent successfully!');
                }, function(error) {
                   console.log('FAILED...', error);
                   alert('Failed to send email. Please try again.');
                });
        }
    </script>
</head>
<body>
    <h1>Send Email</h1>
    <form onsubmit="event.preventDefault(); sendEmail();">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required>
        <br>
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>
        <br>
        <label for="message">Message:</label>
        <textarea id="message" name="message" required></textarea>
        <br>
        <button type="submit">Send Email</button>
    </form>
</body>
</html>