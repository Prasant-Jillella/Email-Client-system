<%@ page import="java.io.*,java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
   String to= request.getParameter("to");// Recipient's email ID needs to be mentioned.
   String subject = request.getParameter("sub");
   String mess=request.getParameter("message");
   String result;

   // Sender's email ID needs to be mentioned
   String from = "prasantajillella@gmail.com";
   String name = "prasantajillella";
   String pwd = "santoshanda123$";

   // Assuming you are sending email from localhost
   String host = "smtp.gmail.com";

   // Get system properties object
   Properties properties = new Properties();

   // Setup mail server
   properties.setProperty("mail.smtp.host", host);
   properties.put("mail.smtp.starttls.enable","true");
   properties.put("mail.smtp.port", "587");
   properties.put("mail.smtp.auth", "true");
  // properties.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

   // Get the default Session object.
   Session mailSession = Session.getInstance(properties);

   try{
	   MimeMessage message = new MimeMessage(mailSession);

	      // Set From: header field of the header.
	      message.setFrom(new InternetAddress(from));

	      // Set To: header field of the header.
	      message.addRecipient(Message.RecipientType.TO,new InternetAddress(to));

	      // Set Subject: header field
	      message.setSubject(subject);

	      // Create the message part 
	      BodyPart messageBodyPart = new MimeBodyPart();

	      // Fill the message
	      messageBodyPart.setText(mess);
	      
	      // Create a multipar message
	      Multipart multipart = new MimeMultipart();

	      // Set text message part
	      multipart.addBodyPart(messageBodyPart);

	      // Part two is attachment
	      /*messageBodyPart = new MimeBodyPart();
	      String filename = request.getParameter("file");
	      DataSource source = new FileDataSource(filename);
	      messageBodyPart.setDataHandler(new DataHandler(source));
	      messageBodyPart.setFileName(filename);
	      multipart.addBodyPart(messageBodyPart);*/

	      // Send the complete message parts
	      message.setContent(multipart );

	      // Send message
	      Transport.send(message, name, pwd);
	      String title = "Send Email";
	      result = "Sent message successfully....";
	   }catch (MessagingException mex) {
	      mex.printStackTrace();
	      result = "Error: unable to send message....";
	   }
%>
<html>
<head>
<title>Send Email using JSP</title>
<link rel="stylesheet" type="text/css" href="Mystyle.css">
</head>
<body background="images/brown.png">
<label class="legend1">
<% 
   out.println(result);
%>
</label>
</body>
</html>