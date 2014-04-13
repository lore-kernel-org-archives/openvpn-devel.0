From: Gert Doering <gert@...1296...>
Date: Sun, 13 Apr 2014 13:43:55 +0200
Message-Id: <1397389435-20170-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Fix SOCKSv5 method selection
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

From: Yawning Angel <yawning@...1897...>

So, RFC 1928 doesn't say anything about the METHODS field in the Method
Selection message being ordered in terms of preference or anything, and
the server is free to pick any of the METHODS offered by the client.

Always sending a Method Selection message with NO AUTHENTICATION REQUIRED
and USERNAME/PASSWORD set is broken on two fronts:

 * If the OpenVPN client can't handle the server picking USERNAME/PASSWORD
   due to the credentials being missing, it shouldn't offer it to the server.

 * If the OpenVPN client has credentials, then it should always attempt to
   authenticate.  This is a security product.  "You can misconfigure it and
   it will work" is not acceptable.  Setting a username/password when the
   SOCKS server doesn't require/support that as an option is the user not
   configuring it correctly, and should be treated as such.

Also verify that the SOCKS server returned the auth that was requested.
---
 src/openvpn/socks.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 1551da8..5cd27ac 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -190,9 +190,12 @@ socks_handshake (struct socks_proxy_info *p,
   int len = 0;
   const int timeout_sec = 5;
 
-  /* VER = 5, NMETHODS = 2, METHODS = [0 (no auth), 2 (plain login)] */
-  const ssize_t size = send (sd, "\x05\x02\x00\x02", 4, MSG_NOSIGNAL);
-  if (size != 4)
+  /* VER = 5, NMETHODS = 1, METHODS = [0 (no auth)] */
+  char method_sel[3] = { 0x05, 0x01, 0x00 };
+  if (p->authfile[0])
+      method_sel[2] = 0x02; /* METHODS = [2 (plain login)] */
+  const ssize_t size = send (sd, method_sel, sizeof (method_sel), MSG_NOSIGNAL);
+  if (size != sizeof (method_sel))
     {
       msg (D_LINK_ERRORS | M_ERRNO, "socks_handshake: TCP port write failed on send()");
       return false;
@@ -252,6 +255,13 @@ socks_handshake (struct socks_proxy_info *p,
       return false;
     }
 
+  /* validate that the auth method returned is the one sent */
+  if (buf[1] != method_sel[2])
+    {
+      msg (D_LINK_ERRORS, "socks_handshake: Socks proxy returned unexpected auth");
+      return false;
+    }
+
   /* select the appropriate authentication method */
   switch (buf[1])
     {
-- 
1.8.3.2


