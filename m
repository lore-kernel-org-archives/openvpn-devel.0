From: Tim Small <tim@...2042...>
Date: Wed,  8 Jul 2015 22:37:35 +0100
Message-Id: <1436391455-4671-5-git-send-email-tim@...2042...>
In-Reply-To: <1436391455-4671-1-git-send-email-tim@...2042...>
References: <1436391455-4671-1-git-send-email-tim@...2042...>
Subject: [Openvpn-devel] [PATCH 4/4] Improve docs and also detail new
	functionality.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hopefully clarify usage, and fix spelling errors.

Document new functionality WRT PAM_USER and implicit password
responses when a non-matching non-echoing PROMPT is made by a PAM
module.

Signed-off-by: Tim Small <tim@...2042...>
---
 src/plugins/auth-pam/README.auth-pam | 152 ++++++++++++++++++++++++++++++-----
 1 file changed, 133 insertions(+), 19 deletions(-)

diff --git a/src/plugins/auth-pam/README.auth-pam b/src/plugins/auth-pam/README.auth-pam
index e123690..5f55857 100644
--- a/src/plugins/auth-pam/README.auth-pam
+++ b/src/plugins/auth-pam/README.auth-pam
@@ -7,7 +7,7 @@ authentication via PAM, and essentially allows any authentication
 method supported by PAM (such as LDAP, RADIUS, or Linux Shadow
 passwords) to be used with OpenVPN.  While PAM supports
 username/password authentication, this can be combined with X509
-certificates to provide two indepedent levels of authentication.
+certificates to provide two independent levels of authentication.
 
 This module uses a split privilege execution model which will
 function even if you drop openvpn daemon privileges using the user,
@@ -31,32 +31,133 @@ The required service-type parameter corresponds to
 the PAM service definition file usually found
 in /etc/pam.d.
 
+The plugin first uses PAM to authenticate the user, if this succeeds it
+then verifies that the users' account is valid via PAM as well.  Only
+if both of these steps succeeds does the plugin approve the OpenVPN
+authentication attempt.
+
+In PAM terminology, the openvpn-plugin-auth-pam.so acts as a PAM
+"application" - that is to say it is an OpenVPN plugin and it makes use
+of the PAM API to authenticate users.  openvpn-plugin-auth-pam.so is
+NOT a PAM module itself.
+
+Similarly it is also NOT possible to merely use the OpenVPN plugin
+syntax to directly specify the use of a particular PAM module in
+isolation...  It IS however possible to arrange for such use of a
+particular PAM module (if desired without changing the behaviour of
+other applications which make use of PAM) by the usual means i.e.
+creating a custom PAM service definition.
+
+
+DEFAULT BEHAVIOUR
+
+By default the plugin will supply the username to the PAM modules
+(by setting the 'user' field of the pam_start() function).  It
+will also attempt to answer 'questions' which individual PAM modules
+ask using the PAM 'conversation' mechanism.
+
+The content of the conversation "message" - see pam_conv(3) - is
+ignored, but each conversation call which has its style set to
+'PAM_PROMPT_ECHO_ON' (i.e. those where the user's response isn't
+intended to be hidden on the devices display etc.) are answered
+with the username.  Calls with the style set to 'PAM_PROMPT_ECHO_OFF'
+are (i.e. the user's response should be hidden) are answered with
+the password.
+
+
+CUSTOM BEHAVIOUR
+
 This plugin also supports the usage of a list of name/value
-pairs to answer PAM module queries.
+pairs to answer PAM module queries using the following syntax:
+
+  plugin openvpn-auth-pam.so "PAMSERVICE [PROMPT ANSWER]..."
+
+These PAM queries take the form of text prompts which individual
+PAM modules supply.
+
+OpenVPN currently lacks a mechanism to supply these prompts (or related
+error messages etc.) to the user, but instead the plugin can be
+configured to respond to them on the users' behalf.
+
+If a PAM module prompts for a reply and supplies a message which matches
+the text PROMPT, then the plugin will reply with ANSWER.
+
+The match is case insensitive and the match will succeed if the PAM
+module's message includes trailing characters e.g. The PROMPT 'Log' will
+match the PAM message 'login:'.
+
+As a special case, if a PROMPT value of 'PAM_USER' is given, then the
+corresponding ANSWER value will be supplied to the PAM service via
+the second argument of the pam_start() function.  When this is supplied
+to a PAM module, they do not need to request the user name of the user
+via the pam_conv(3) mechanism.  This is the recommended way of
+supplying the user name to a PAM service.
+
+If no match is found for a prompt message, but the message style is
+set to 'PAM_PROMPT_ECHO_OFF', then the plugin will supply the password
+given by the OpenVPN client.
+
+
+Example 1:
 
-For example:
+  plugin openvpn-auth-pam.so "login PAM_USER COMMONNAME"
 
-  plugin openvpn-auth-pam.so "login login USERNAME password PASSWORD"
+tells the plugin to (a) use the "login" PAM service and (b) supply
+the commonname (as supplied to the plugin by OpenVPN) to the PAM
+service as the user name.  Most PAM services will request a secret in
+order to authorise the user, and as there are no further explicit
+PROMPT values specified by the example plugin definition, then any
+such password style (non-echoing input) requests made by the PAM
+modules which make up the PAM service definition will be automatically
+answered using the password given which was supplied by the OpenVPN
+client.
 
-tells auth-pam to (a) use the "login" PAM module, (b) answer a
-"login" query with the username given by the OpenVPN client, and
-(c) answer a "password" query with the password given by the
-OpenVPN client.  This provides flexibility in dealing with the different
-types of query strings which different PAM modules might generate.
-For example, suppose you were using a PAM module called
-"test" which queried for "name" rather than "login":
+n.b. Typically this would be used to enforce a 1:1 mapping between
+users' common names as defined by their TLS client certificate, and
+their system login account.  The username supplied by the end-user will
+not be passed to PAM in this example, and will effectively be ignored
+in favour of this client certificate common name.
+
+
+Example 2:
+
+  plugin openvpn-auth-pam.so "openvpn login USERNAME password PASSWORD"
+
+tells the plugin to (a) use the "openvpn" PAM service, (b) answer any
+PAM "conversation" call which has a message which begins 'login' with
+the username given by the OpenVPN client, and (c) answer a PAM prompt
+which begins with the text 'password' with the password given by the
+OpenVPN client.  This provides some flexibility in dealing with the
+different types of query strings which different PAM modules might
+generate.
+
+n.b. An "openvpn" PAM service definition must exist on the system in
+order to use the above declaration successfully.
+
+
+Example 3:
+
+Suppose you were using a PAM service called "test".  One of the
+modules defined in this service prompts with the message "Name Please:"
+rather than "Login :" - you could use:
 
   plugin openvpn-auth-pam.so "test name USERNAME password PASSWORD"
 
-While "USERNAME" "COMMONNAME" and "PASSWORD" are special strings which substitute
-to client-supplied values, it is also possible to name literal values
-to use as PAM module query responses.  For example, suppose that the
-login module queried for a third parameter, "domain" which
-is to be answered with the constant value "mydomain.com":
 
-  plugin openvpn-auth-pam.so "login login USERNAME password PASSWORD domain mydomain.com"
+Example 4:
+
+While "USERNAME" "COMMONNAME" and "PASSWORD" are special strings which
+substitute to client-supplied values, it is also possible to name
+literal values to use as PAM module query responses.  For example,
+suppose that the login module prompted for a "domain" which should be
+answered with the constant value "mydomain.com":
 
-The following OpenVPN directives can also influence
+  plugin openvpn-auth-pam.so "test login USERNAME password PASSWORD domain mydomain.com"
+
+
+ENVIRONMENT
+
+The following OpenVPN configuration directives can also influence
 the operation of this plugin:
 
   client-cert-not-required
@@ -64,11 +165,24 @@ the operation of this plugin:
 
 Run OpenVPN with --verb 7 or higher to get debugging output from
 this plugin, including the list of queries presented by the
-underlying PAM module.  This is a useful debugging tool to figure
+underlying PAM modules.  This is a useful debugging tool to figure
 out which queries a given PAM module is making, so that you can
 craft the appropriate plugin directive to answer it.
 
+
 CAVEATS
 
 This module will only work on *nix systems which support PAM,
 not Windows.
+
+
+DEBUGGING
+
+Debugging information from PAM services may be logged using different
+syslog facilities than OpenVPN, and so may end up in different
+locations (e.g. /var/log/auth.log etc. depending on system
+configuration).
+
+The administrator is advised to consult the many PAM tutorials and
+'howto' documents in order to learn about the debugging on PAM, and
+the creation and testing of custom PAM service definitions etc.
-- 
2.1.4


