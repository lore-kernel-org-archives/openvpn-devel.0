From: Maximilian Fillinger <maximilian.fillinger@...1435...>
Date: Fri, 19 Mar 2021 16:45:18 +0000
Message-ID: <AM0PR04MB53311DBD4346F75A380F7198B1689@...2601...>
Content-Language: en-US
MIME-Version: 1.0
Subject: [Openvpn-devel] [Patch] Wipe Socks5 credentials after use
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Socks5 plaintext authentication is not exactly high security, but we
might as well memzero the credentials before leaving the function.

---
 src/openvpn/socks.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 36df7470..add7a6d4 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -104,12 +104,13 @@ socks_username_password_auth(struct socks_proxy_info =
*p,
     const int timeout_sec =3D 5;
     struct user_pass creds;
     ssize_t size;
+    bool ret =3D false;
=20
     creds.defined =3D 0;
     if (!get_user_pass(&creds, p->authfile, UP_TYPE_SOCKS, GET_USER_PASS_M=
ANAGEMENT))
     {
         msg(M_NONFATAL, "SOCKS failed to get username/password.");
-        return false;
+        goto cleanup;
     }
=20
     if ( (strlen(creds.username) > 255) || (strlen(creds.password) > 255) )
@@ -117,7 +118,7 @@ socks_username_password_auth(struct socks_proxy_info *p,
         msg(M_NONFATAL,
             "SOCKS username and/or password exceeds 255 characters.  "
             "Authentication not possible.");
-        return false;
+        goto cleanup;
     }
     openvpn_snprintf(to_send, sizeof(to_send), "\x01%c%s%c%s", (int) strle=
n(creds.username),
                      creds.username, (int) strlen(creds.password), creds.p=
assword);
@@ -126,7 +127,7 @@ socks_username_password_auth(struct socks_proxy_info *p,
     if (size !=3D strlen(to_send))
     {
         msg(D_LINK_ERRORS | M_ERRNO, "socks_username_password_auth: TCP po=
rt write failed on send()");
-        return false;
+        goto cleanup;
     }
=20
     while (len < 2)
@@ -147,21 +148,21 @@ socks_username_password_auth(struct socks_proxy_info =
*p,
         get_signal(signal_received);
         if (*signal_received)
         {
-            return false;
+            goto cleanup;
         }
=20
         /* timeout? */
         if (status =3D=3D 0)
         {
             msg(D_LINK_ERRORS | M_ERRNO, "socks_username_password_auth: TC=
P port read timeout expired");
-            return false;
+            goto cleanup;
         }
=20
         /* error */
         if (status < 0)
         {
             msg(D_LINK_ERRORS | M_ERRNO, "socks_username_password_auth: TC=
P port read failed on select()");
-            return false;
+            goto cleanup;
         }
=20
         /* read single char */
@@ -171,7 +172,7 @@ socks_username_password_auth(struct socks_proxy_info *p,
         if (size !=3D 1)
         {
             msg(D_LINK_ERRORS | M_ERRNO, "socks_username_password_auth: TC=
P port read failed on recv()");
-            return false;
+            goto cleanup;
         }
=20
         /* store char in buffer */
@@ -182,10 +183,14 @@ socks_username_password_auth(struct socks_proxy_info =
*p,
     if (buf[0] !=3D 5 && buf[1] !=3D 0)
     {
         msg(D_LINK_ERRORS, "socks_username_password_auth: server refused t=
he authentication");
-        return false;
+        goto cleanup;
     }
=20
-    return true;
+    ret =3D true;
+cleanup:
+    secure_memzero(&creds, sizeof(creds));
+    secure_memzero(to_send, sizeof(to_send));
+    return ret;
 }
=20
 static bool
--=20
2.11.0

