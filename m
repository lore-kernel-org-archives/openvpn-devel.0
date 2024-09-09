From: selva.nair@...277...
Date: Mon,  9 Sep 2024 16:48:29 -0400
Message-Id: <20240909204829.10379-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix more of uninitialized struct user_pass
 local vars
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

From: Selva Nair <selva.nair@...277...>

Not all of these touch uninitialzed members of the struct, but that
could change in future.

Change-Id: I71bc847b48da54b70f60ccd7c4521ec699daf9cb
Signed-off-by: Selva Nair <selva.nair@...277...>
---
There is an unused & uninitialized struct user_pass in tun.c for ANDROID.
Could be removed?

 src/openvpn/auth_token.c | 1 +
 src/openvpn/pkcs11.c     | 1 +
 src/openvpn/socks.c      | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index 5de65cb6..c4b59b99 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -452,6 +452,7 @@ check_send_auth_token(struct context *c)
     }
 
     struct user_pass up;
+    CLEAR(up);
     strncpynt(up.username, multi->locked_username, sizeof(up.username));
 
     generate_auth_token(&up, multi);
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index 418f6bb0..37cc1678 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -238,6 +238,7 @@ _pkcs11_openvpn_pin_prompt(
 {
     struct user_pass token_pass;
     char prompt[1024];
+    CLEAR(token_pass);
 
     (void)global_data;
     (void)user_data;
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index d95f3013..e280453d 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -96,7 +96,7 @@ socks_username_password_auth(struct socks_proxy_info *p,
     ssize_t size;
     bool ret = false;
 
-    creds.defined = 0;
+    CLEAR(creds);
     if (!get_user_pass(&creds, p->authfile, UP_TYPE_SOCKS, GET_USER_PASS_MANAGEMENT))
     {
         msg(M_NONFATAL, "SOCKS failed to get username/password.");
-- 
2.40.1


