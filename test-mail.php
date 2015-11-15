#!/usr/bin/env php
<?php
ini_set("mail.log", "/tmp/mail.log");
ini_set("mail.add_x_header", TRUE);

$headers = array("From: joao.parana@icloud.com",
    "Reply-To: joao.parana@icloud.com",
    "X-Mailer: PHP/" . PHP_VERSION
);
$headers = implode("\r\n", $headers);

// The message
$message = 'Line 1\nLine 2\nLine 3';

// In case any of our lines are larger than 70 characters, we should use wordwrap()
$message = wordwrap($message, 70);

// Send
if (mail('joao.parana@gmail.com', 'My Subject from Drupal 8', $message, $headers)) { 
  echo 'Your message has been sent !'; 
  echo '';
} else { 
  echo 'Something went wrong !'; 
  echo '';
}
