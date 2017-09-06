<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Email Sent</title>
	<link href="css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
<%@ page import="java.io.*,java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.sun.mail.smtp.*,com.sun.mail.util.*" %>
<%
   String result;
   // Recipient's email ID needs to be mentioned.
   String to = request.getParameter("to");//"lvhkrishna@hotmail.com";

   // Sender's email ID needs to be mentioned
   String from = "prasantajillella@gmail.com";
   
   String subject = request.getParameter("sub");
   String msg = request.getParameter("message");
   String path[] = request.getParameterValues("file");
   // Assuming you are sending email from localhost
   String host = "smtp.gmail.com";
   String username = "prasatajillella";
   String password = "santoshanda123$";

   // Get system properties object
   Properties properties = new Properties();

   // Setup mail server
   //properties.setProperty("mail.smtp.host", host);
   //properties.setProperty("mail.smtp.ssl.enable", "true");
   //properties.setProperty("mail.smtp.auth", "true");
   properties.put("mail.smtp.auth", "true");
   properties.put("mail.smtp.starttls.enable", "true");
   properties.put("mail.smtp.host", host);
   properties.put("mail.smtp.port", "587");

   // Get the default Session object.
   Session mailSession = Session.getInstance(properties);

   try
   {
      // Create a default MimeMessage object.
      MimeMessage message = new MimeMessage(mailSession);
      
      // Set From: header field of the header.
      message.setFrom(new InternetAddress(from));
      
      // Set To: header field of the header.
      message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
      
      // Set Subject: header field
      message.setSubject(subject);
      
      //Create the message part
      BodyPart messageBodyPart = new MimeBodyPart();
      
      // Now set the actual message
      //message.setText("This is actual message");
      messageBodyPart.setText(msg);
      
      //Create a multipart message
      Multipart multipart = new MimeMultipart();
      
      //Set text message part
      multipart.addBodyPart(messageBodyPart);
      
      //Setting attachment
      if(path[0] != "")
      for(int i=0;i<path.length;i++)
      {
      messageBodyPart = new MimeBodyPart();
      String filename = path[i];//"C:\\Users\\lvhkrishna\\Desktop\\tachi2016.pdf";
      DataSource source = new FileDataSource(filename);
      messageBodyPart.setDataHandler(new DataHandler(source));
      messageBodyPart.setFileName(filename);
      multipart.addBodyPart(messageBodyPart);
      }
      
      //Set the complete message part
      message.setContent(multipart);
      
      // Send message
      Transport.send(message, username, password);
      result = "Sent message successfully....";
   }
   catch(MailConnectException e){
	   result = "No Internet Connection. Could not send message....";
   }
   catch (MessagingException mex) {
	      mex.printStackTrace();
	      result = "Error: Unable to send message....";
   }
%>

	<h1 style="text-align:center">
<%
   		out.println(result + " to " + "<br/>" + to + "<br/>");
%>
	</h1>
	<a class="col-md-8 col-md-offset-4" href="index.html">Go Back</a>
	
	<script src="js/jquery-1.11.3.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>