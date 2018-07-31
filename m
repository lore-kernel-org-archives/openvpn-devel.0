Date: Tue, 31 Jul 2018 09:04:18 -0400
From: "Jonathan K. Bullard" <jkbullard@...2282...>
Reply-To: "Jonathan K. Bullard" <jkbullard@...2282...>
Message-ID: <fjYAooPkYrgmB8fJ2mP-rtaCjsb7EX1oVv_jiph22aEwZQA8Y7QI2ZUsYmpwXnxF0HRogHWWmBt_JM30y1d7pW--UIqczqXre9h7hbIhHUo=@protonmail.com>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Clarify and expand management interface
 documentation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Clarify and expand the documentation for the management interface:

* Add examples of static and dynamic challenge/response sequences in
the "COMMAND -- password and username" section.

* Expand the "Challenge/Response" section with more detail.

* Use "management interface client" throughout (instead of "management
client", which was used in several places previously).

* Clarify when both a username and password is needed, not just a
username or a password.

* Clarify that an exit with a fatal error for a dynamic C/R will occur
only if "--auth-retry none" (the default) is in effect.

* Update the list of UIs that support challenge/response.

* Fix a typo. ("posesses" =3D> "possesses").

Signed-off-by: Jonathan K. Bullard <jkbullard@...277...>
---
 doc/management-notes.txt | 213 ++++++++++++++++++++++++++++++++-----------=
----
 1 file changed, 147 insertions(+), 66 deletions(-)

diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 96470d0..174b3bf 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -12,7 +12,8 @@ as a client or server.

 The management interface is implemented using a client/server TCP
 connection or unix domain socket where OpenVPN will listen on a
-provided IP address and port for incoming management client connections.
+provided IP address and port for incoming management interface client
+connections.

 The management protocol is currently cleartext without an explicit
 security layer.  For this reason, it is recommended that the
@@ -104,7 +105,7 @@ be in the list, and it will cause the management interf=
ace
 to save the "forget-passwords" string in its list of echo
 parameters.

-The management client can use "echo all" to output the full
+The management interface client can use "echo all" to output the full
 list of echoed parameters, "echo on" to turn on real-time
 notification of echoed parameters via the ">ECHO:" prefix,
 or "echo off" to turn off real-time notification.
@@ -118,10 +119,10 @@ like this:

 Essentially the echo command allowed us to pass parameters from
 the OpenVPN server to the OpenVPN client, and then to the
-management client (such as a GUI).  The large integer is the
+management interface client (such as a GUI).  The large integer is the
 unix date/time when the echo parameter was received.

-If the management client had issued the command "echo on",
+If the management interface client had issued the command "echo on",
 it would have enabled real-time notifications of echo
 parameters.  In this case, our "forget-passwords" message
 would be output like this:
@@ -141,8 +142,8 @@ COMMAND -- exit, quit

 Close the managment session, and resume listening on the
 management port for connections from other clients. Currently,
-the OpenVPN daemon can at most support a single management client
-any one time.
+the OpenVPN daemon can at most support a single management interface
+client any one time.

 COMMAND -- help
 ---------------
@@ -167,7 +168,7 @@ The hold flag setting is persistent and will not
 be reset by restarts.

 OpenVPN will indicate that it is in a hold state by
-sending a real-time notification to the management
+sending a real-time notification to the management interface
 client, the parameter indicates how long OpenVPN would
 wait without UI (as influenced by connect-retry exponential
 backoff). The UI needs to wait for releasing the hold if it
@@ -275,7 +276,7 @@ COMMAND -- password and username
   OpenVPN is indicating that it needs a password of type
   "Private Key".

-  The management client should respond to this query as follows:
+  The management interface client should respond as follows:

     password "Private Key" foo

@@ -283,8 +284,8 @@ COMMAND -- password and username

     >PASSWORD:Need 'Auth' username/password

-  OpenVPN needs a --auth-user-pass password.  The management
-  client should respond:
+  OpenVPN needs a --auth-user-pass username and password.  The
+  management interface client should respond:

     username "Auth" foo
     password "Auth" bar
@@ -307,7 +308,8 @@ COMMAND -- password and username
     >PASSWORD:Verification Failed: 'Private Key'

   Example 4: The --auth-user-pass username/password failed,
-  and OpenVPN is exiting:
+  and OpenVPN will exit with a fatal error if '--auth-retry none'
+  (which is the default) is in effect:

     >PASSWORD:Verification Failed: 'Auth'

@@ -322,6 +324,34 @@ COMMAND -- password and username

     >PASSWORD:Auth-Token:foobar

+  Example 7: Static challenge/response:
+
+    >PASSWORD:Need 'Auth' username/password SC:1,Please enter token PIN
+
+  OpenVPN needs an --auth-user-pass username and password and the
+  response to a challenge. The user's response to "Please enter
+  token PIN" should be obtained and included in the management
+  interface client's response along with the username and password.
+
+  Example 8: Dynamic challenge/response:
+
+    >PASSWORD:Verification Failed: "['CRV1:R,E:Om01u7Fh4LrGBS7uh0SWmzwabUi=
GiW6l:Y3Ix:Please enter token PIN']"
+
+  The previous --auth-user-pass username/password failed or is not
+  fully complete, and the server provided a custom
+  client-reason-text string indicating that a dynamic
+  challenge/response should occur the next time that a "Need 'Auth'
+  username/password" message is seen.
+
+  When the next "Need 'Auth' username/password" without a static
+  challenge is seen, the user's response to "Please enter token PIN"
+  should be obtained and included in the management interface client's
+  response along with the username and password.
+
+See the "Challenge/Response Protocol" section below for more details
+about examples 7 and 8, including how the management interface client
+should respond.
+
 COMMAND -- forget-passwords
 ---------------------------

@@ -464,10 +494,10 @@ Example:

     >NEED-OK:Need 'token-insertion-request' confirmation MSG:Please insert=
 your cryptographic token

-  The management client, if it is a GUI, can flash a dialog
+  The management interface client, if it is a GUI, can flash a dialog
   box containing the text after the "MSG:" marker to the user.
   When the user acknowledges the dialog box,
-  the management client can issue this command:
+  the management interface client can issue this command:

      needok token-insertion-request ok
   or
@@ -486,10 +516,10 @@ Example:

     >NEED-STR:Need 'name' input MSG:Please specify your name

-  The management client, if it is a GUI, can flash a dialog
+  The management interface client, if it is a GUI, can flash a dialog
   box containing the text after the "MSG:" marker to the user.
   When the user acknowledges the dialog box,
-  the management client can issue this command:
+  the management interface client can issue this command:

      needstr name "John"

@@ -890,7 +920,7 @@ NEED-STR -- OpenVPN needs information from end, such as
             a certificate to use.  The "needstr" command can
             be used to tell OpenVPN to continue.

-PASSWORD -- Used to tell the management client that OpenVPN
+PASSWORD -- Used to tell the management interface client that OpenVPN
             needs a password, also to indicate password
             verification failure.

@@ -988,70 +1018,119 @@ generate challenge questions that are shown to the =
user, and to see
 the user's responses to those challenges.  Based on the responses, the
 server can allow or deny access.

-In this way, the OpenVPN Challenge/Response Protocol can be used
-to implement multi-factor authentication.  Two different
-variations on the challenge/response protocol are supported: the
-"Dynamic" and "Static" protocols.
+The protocol can be used to implement multi-factor authentication
+because the user must enter an additional piece of information,
+in addition to a username and password, to successfully authenticate.
+In multi-factor authentication, this information is used to prove
+that the user possesses a certain key-like device such as
+cryptographic token or a particular mobile phone.
+
+Two variations on the challenge/response protocol are supported:
+the "static" and "dynamic" protocols:
+
+ * The static protocol uses OpenVPN's "--static-challenge" option.

-The basic idea of Challenge/Response is that the user must enter an
-additional piece of information, in addition to the username and
-password, to successfully authenticate.  Normally, this information
-is used to prove that the user posesses a certain key-like device
-such as cryptographic token or a particular mobile phone.
+ * The dynamic protocol does not involve special OpenVPN options
+   or actions. It is an agreement between the authentication
+   script on the server and the management interface client to use custom
+   server-generated strings in "Verification Failed" messages
+   that begin with "['CRV".
+
+As of July 2018, the Access Server client, standalone OpenVPN client,
+OpenVPN GUI (for Windows), Tunnelblick (for macOS), OpenVPN
+Connect (for iOS), and OpenVPN for Android all support
+the challenge/response protocol.  Other OpenVPN client UIs that drive
+OpenVPN via the management interface are urged to add support for the
+protocol.

 Dynamic protocol:

 The OpenVPN dynamic challenge/response protocol works by returning
 a specially formatted error message after initial successful
-authentication.  This error message contains the challenge question,
-and is formatted as such:
+authentication.  The error message has two purposes:
+
+ 1. It causes OpenVPN to restart the connection attempt.
+
+ 2. It contains information about the challenge, which should be used
+    to modify the response to the next authentication request (which will
+    occur after the restart).

-  CRV1:<flags>:<state_id>:<username_base64>:<challenge_text>
+Notes:
+
+ * '--auth-retry interact' must be in effect so that the
+   connection is restarted and credentials are requested again.
+
+ * '--auth-retry none' (which is the default) will cause
+  OpenVPN to exit with a fatal error without retrying and the dynamic
+  challenge/response will never happen because "Need 'Auth'
+  username/password" will not be sent.
+
+The error message is formatted as follows:
+
+   >PASSWORD:Verification Failed: 'Auth' ['CRV1:<flags>:<state_id>:<userna=
me_base64>:<challenge_text>']

 flags: a series of optional, comma-separated flags:
- E : echo the response when the user types it
- R : a response is required
+ E : echo the response when the user types it.
+ R : a response is required.

 state_id: an opaque string that should be returned to the server
- along with the response.
+          along with the response.
+
+username_base64: the username encoded as base64.

-username_base64 : the username formatted as base64
+challenge_text: the challenge text to be shown to the user.

-challenge_text : the challenge text to be shown to the user
+flags, state_id, and username_base64 may not contain colon
+characters (":"), but challenge_text may.

 Example challenge:

   CRV1:R,E:Om01u7Fh4LrGBS7uh0SWmzwabUiGiW6l:Y3Ix:Please enter token PIN

-After showing the challenge_text and getting a response from the user
-(if R flag is specified), the client should submit the following
-auth creds back to the OpenVPN server:
+The next time the username and password are requested with
+
+   >PASSWORD:Need 'Auth' username/password

-Username: [username decoded from username_base64]
-Password: CRV1::<state_id>::<response_text>
+the management interface client should display the challenge_text and,
+if the R flag is specified, get a response from the user. The management
+interface client should respond:

-Where state_id is taken from the challenge request and response_text
-is what the user entered in response to the challenge_text.
-If the R flag is not present, response_text may be the empty
-string.
+   username "Auth" <username>
+   password "Auth" CRV1::<state_id>::<response_text>
+
+Where username is the username decoded from username_base64,
+state_id is taken from the challenge request, and response_text
+is what the user entered in response to the challenge_text, which can
+be an empty string.  If the R flag is not present, response_text should
+be an empty string.
+
+(As in all username/password responses described in the "COMMAND --
+password and username" section above, the username/password itself
+can be in quotes, and special characters such as double quotes or
+backslashes must be escaped. See the "Command Parsing" section above
+for more info.)

 Example response (suppose the user enters "8675309" for the token PIN):

-  Username: cr1 ("Y3Ix" base64 decoded)
-  Password: CRV1::Om01u7Fh4LrGBS7uh0SWmzwabUiGiW6l::8675309
+   username "Auth" cr1
+   password "Auth" CRV1::Om01u7Fh4LrGBS7uh0SWmzwabUiGiW6l::8675309
+
+("Y3Ix" is the base64 encoding of "cr1".)

 Static protocol:

 The static protocol differs from the dynamic protocol in that the
-challenge question and response field is given to the user in the
-initial username/password dialog, and the username, password, and
-response are delivered back to the server in a single transaction.
+challenge question is sent to the management interface client in a
+a username/password request, and the username, password, and
+response are delivered back to the server in response to that
+request.

-The "static-challenge" directive is used to give the challenge text
-to OpenVPN and indicate whether or not the response should be echoed.
+OpenVPN's --static-challenge option is used to provide the
+challenge text to OpenVPN and indicate whether or not the response
+should be echoed.

-When the "static-challenge" directive is used, the management
-interface will respond as such when credentials are needed:
+When credentials are needed and the --static-challenge option is
+used, the management interface will send:

   >PASSWORD:Need 'Auth' username/password SC:<ECHO>,<TEXT>

@@ -1064,28 +1143,30 @@ For example:
   >PASSWORD:Need 'Auth' username/password SC:1,Please enter token PIN

 The above notification indicates that OpenVPN needs a --auth-user-pass
-password plus a response to a static challenge ("Please enter token PIN").
-The "1" after the "SC:" indicates that the response should be echoed.
+username and password plus a response to a static challenge ("Please
+enter token PIN"). The "1" after the "SC:" indicates that the response
+should be echoed.

 The management interface client in this case should add the static
 challenge text to the auth dialog followed by a field for the user to
-enter a response.  Then the client should pack the password and response
-together into an encoded password:
+enter a response.  Then the management interface client should pack the
+password and response together into an encoded password and send:

-  username "Auth" foo
-  password "Auth" "SCRV1:<BASE64_PASSWORD>:<BASE64_RESPONSE>"
+  username "Auth" <username>
+  password "Auth" "SCRV1:<password_base64>:<response_base64>"
+
+(As in all username/password responses described in the "COMMAND --
+password and username" section above, the username/password itself
+can be in quotes, and special characters such as double quotes or
+backslashes must be escaped. See the "Command Parsing" section above
+for more info.)

-For example, if the user entered "bar" as the password and 8675309
+For example, if user "foo" entered "bar" as the password and 8675309
 as the PIN, the following management interface commands should be
 issued:

   username "Auth" foo
-  password "Auth" "SCRV1:Zm9v:ODY3NTMwOQ=3D=3D"
-
-Client-side support for challenge/response protocol:
+  password "Auth" "SCRV1:YmFy:ODY3NTMwOQ=3D=3D"

-Currently, the Access Server client and standalone OpenVPN
-client support both static and dynamic challenge/response
-protocols.  However, any OpenVPN client UI that drives OpenVPN
-via the management interface needs to add explicit support
-for the challenge/response protocol.
+  ("YmFy" is the base 64 encoding of "bar" and "ODY3NTMwOQ=3D=3D" is the
+   base 64 encoding of "8675309".)


