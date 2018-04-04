From: David Sommerseth <davids@...515...>
Date: Wed,  4 Apr 2018 14:13:57 +0200
Message-Id: <20180404121357.2126-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH] man: Improve token based authentication
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

Be more explicit that --auth-gen-token is to be considered a workaround
for authentication scripts/plug-ins not supporting --auth-token.

Also be more explicit that invalidated --auth-token values will result
in the client disconnecting.

Signed-off-by: David Sommerseth <davids@...515...>
---
 doc/openvpn.8 | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 4114f408..b6de2c9c 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3671,10 +3671,25 @@ argument defines how long the generated token is valid.  The
 lifetime is defined in seconds.  If lifetime is not set
 or it is set to 0, the token will never expire.
 
-This feature is useful for environments which is configured
-to use One Time Passwords (OTP) as part of the user/password
-authentications and that authentication mechanism does not
-implement any auth\-token support.
+.B PLEASE NOTE:
+The
+.B \-\-auth\-gen\-token
+feature is to be considered a workaround for authentication
+scripts or plug\-ins not providing proper
+.B auth\-token
+support.  The
+.B auth\-token
+feature is most commonly needed when deploying two factor
+authentications, such as One Time Password (OTP) based
+authentication.  Proper authentication scripts/plug\-ins should
+implement support for generating, sending and verifying
+.B auth\-token
+values sent to successfully authenticated clients, and particularly
+when OTP authentication is required.
+
+See also
+.B \-\-auth\-token
+for more details.
 .\"*********************************************************
 .TP
 .B \-\-opt\-verify
@@ -5291,6 +5306,15 @@ OPENVPN_PLUGIN_CLIENT_CONNECT_V2 calls.  This option provides
 a possibility to replace the clients password with an authentication
 token during the lifetime of the OpenVPN client.
 
+.B BEWARE:
+Clients which has received an
+.B auth\-token
+will be using this value as the password on each renegotiation and
+reconnection to the server until it stops running.  If the server
+has invalidated the
+.B auth\-token
+since the last authentication, the client will be disconnected.
+
 Whenever the connection is renegotiated and the
 .B \-\-auth\-user\-pass\-verify
 script or
-- 
2.16.2


