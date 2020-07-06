From: Richard Bonhomme <tincanteksup@...277...>
Date: Mon,  6 Jul 2020 23:41:46 +0100
Message-Id: <20200706224146.2432-1-tincanteksup@...277...>
Subject: [Openvpn-devel] [Patch] New man page corrections -
 server-options.rst
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Signed-off-by: Richard Bonhomme <tincanteksup@...277...>
---
 doc/man-sections/server-options.rst | 38 ++++++++++++++---------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index ada387a2..218d4f35 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -18,13 +18,13 @@ fast hardware. SSL/TLS authentication must be used in this mode.
 
   After successful user/password authentication, the OpenVPN server will
   with this option generate a temporary authentication token and push that
-  to client. On the following renegotiations, the OpenVPN client will pass
+  to the client. On the following renegotiations, the OpenVPN client will pass
   this token instead of the users password. On the server side the server
   will do the token authentication internally and it will NOT do any
   additional authentications against configured external user/password
   authentication mechanisms.
 
-  The tokens implemented by this mechanism include a initial timestamp and
+  The tokens implemented by this mechanism include an initial timestamp and
   a renew timestamp and are secured by HMAC.
 
   The ``lifetime`` argument defines how long the generated token is valid.
@@ -39,7 +39,7 @@ fast hardware. SSL/TLS authentication must be used in this mode.
   time, while at the same time permitting much longer token lifetimes for
   active clients.
 
-  This feature is useful for environments which is configured to use One
+  This feature is useful for environments which are configured to use One
   Time Passwords (OTP) as part of the user/password authentications and
   that authentication mechanism does not implement any auth-token support.
 
@@ -49,11 +49,11 @@ fast hardware. SSL/TLS authentication must be used in this mode.
   verification suceeds or fails.
 
   This option postpones this decision to the external authentication
-  methods and check the validity of the account and do other checks.
+  methods and checks the validity of the account and do other checks.
 
-  In this mode the environment will have a session\_id variable that hold
-  the session id from auth-gen-token. Also a environment variable
-  session\_state is present. This variable tells whether the auth-token
+  In this mode the environment will have a session\_id variable that holds
+  the session id from auth-gen-token. Also an environment variable
+  session\_state is present. This variable indicates whether the auth-token
   has succeeded or not. It can have the following values:
 
   :code:`Initial`
@@ -69,9 +69,9 @@ fast hardware. SSL/TLS authentication must be used in this mode.
       Token is invalid (failed HMAC or wrong length)
 
   :code:`AuthenticatedEmptyUser` / :code:`ExpiredEmptyUser`
-      The token is not valid with the username send from the client but
-      would be valid (or expired) if we assume an  empty  username was
-      used instead.  These two  cases are a workaround for behaviour in
+      The token is not valid with the username sent from the client but
+      would be valid (or expired) if we assume an empty username was
+      used instead.  These two cases are a workaround for behaviour in
       OpenVPN 3.  If this workaround is not needed these two cases should
       be handled in the same way as :code:`Invalid`.
 
@@ -86,16 +86,16 @@ fast hardware. SSL/TLS authentication must be used in this mode.
   password from a script).
 
 --auth-gen-token-secret file
-  Specifies a file that hold a secret for the HMAC used in
+  Specifies a file that holds a secret for the HMAC used in
   ``--auth-gen-token`` If ``file`` is not present OpenVPN will generate a
   random secret on startup. This file should be used if auth-token should
-  valid after restarting a server or if client should be able to roam
-  between multiple OpenVPN server with their auth-token.
+  validate after restarting a server or if client should be able to roam
+  between multiple OpenVPN servers with their auth-token.
 
 --auth-user-pass-optional
   Allow connections by clients that do not specify a username/password.
   Normally, when ``--auth-user-pass-verify`` or
-  ``--management-client-auth`` is specified (or an authentication plugin
+  ``--management-client-auth`` are specified (or an authentication plugin
   module), the OpenVPN server daemon will require connecting clients to
   specify a username and password. This option makes the submission of a
   username/password by clients optional, passing the responsibility to the
@@ -626,8 +626,8 @@ fast hardware. SSL/TLS authentication must be used in this mode.
     tls-server
 
 --stale-routes-check args
-  Remove routes haven't had activity for ``n`` seconds (i.e. the ageing
-  time).  This check is ran every ``t`` seconds (i.e. check interval).
+  Remove routes which haven't had activity for ``n`` seconds (i.e. the ageing
+  time).  This check is run every ``t`` seconds (i.e. check interval).
 
   Valid syntax:
   ::
@@ -650,7 +650,7 @@ fast hardware. SSL/TLS authentication must be used in this mode.
   Possible ``mode`` options are:
 
   :code:`none`
-      A client certificate is not required. the client need to
+      A client certificate is not required. the client needs to
       authenticate using username/password only. Be aware that using this
       directive is less secure than requiring certificates from all
       clients.
@@ -675,7 +675,7 @@ fast hardware. SSL/TLS authentication must be used in this mode.
       script could potentially compromise the security of your VPN.
 
   :code:`require`
-      This is the default option. A client is required topresent a
+      This is the default option. A client is required to present a
       certificate, otherwise VPN access is refused.
 
   If you don't use this directive (or use ``--verify-client-cert require``)
@@ -712,7 +712,7 @@ fast hardware. SSL/TLS authentication must be used in this mode.
   OpenVPN accepts any Ethernet frame and does not perform any special
   processing for VLAN-tagged packets.
 
-  The option can only be activated in ``--dev tap mode``.
+  This option can only be activated in ``--dev tap mode``.
 
 --vlan-accept args
   Configure the VLAN tagging policy for the server TAP device.
-- 
2.17.1


