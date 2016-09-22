From: David Sommerseth <davids@...515...>
Date: Thu, 22 Sep 2016 21:40:58 +0200
Message-Id: <1474573258-25420-2-git-send-email-davids@...515...>
In-Reply-To: <1474573258-25420-1-git-send-email-davids@...515...>
References: <1474573258-25420-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH] Remove static global allocation of HTTP
	proxy user/passwords
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

This avoids allocating static memory which is not used unless the
a HTTP proxy with authentication is configured.

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/ntlm.c  | 16 ++++++++--------
 src/openvpn/proxy.c | 41 +++++++++++++++++++++++++++++------------
 src/openvpn/proxy.h |  2 +-
 3 files changed, 38 insertions(+), 21 deletions(-)

diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 3390bdd..ee8be6e 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -192,7 +192,7 @@ ntlm_phase_3 (const struct http_proxy_info *p, const char *phase_2, struct gc_ar
 	 *
 	 */
 	
-  char pwbuf[sizeof (p->up.password) * 2]; /* for unicode password */
+  char pwbuf[USER_PASS_LEN * 2]; /* for unicode password */
   char buf2[128]; /* decoded reply from proxy */
   unsigned char phase3[464];
 
@@ -218,27 +218,27 @@ ntlm_phase_3 (const struct http_proxy_info *p, const char *phase_2, struct gc_ar
 
   CLEAR (buf2);
 
-  ASSERT (strlen (p->up.username) > 0);
-  ASSERT (strlen (p->up.password) > 0);
+  ASSERT (strlen (p->up->username) > 0);
+  ASSERT (strlen (p->up->password) > 0);
 	
 	/* username parsing */
-	separator = strchr(p->up.username, '\\');
+	separator = strchr(p->up->username, '\\');
 	if (separator == NULL) {
-		strncpy(username, p->up.username, sizeof(username)-1);
+		strncpy(username, p->up->username, sizeof(username)-1);
 		username[sizeof(username)-1]=0;
 		domain[0]=0;
 	} else {
 		strncpy(username, separator+1, sizeof(username)-1);
 		username[sizeof(username)-1]=0;
-		len = separator - p->up.username;
+		len = separator - p->up->username;
 		if (len > sizeof(domain) - 1) len = sizeof(domain) - 1;
-		strncpy(domain, p->up.username,  len);
+		strncpy(domain, p->up->username,  len);
 		domain[len]=0;
 	}
 
 
   /* fill 1st 16 bytes with md4 hash, disregard terminating null */
-  gen_md4_hash (pwbuf, unicodize (pwbuf, p->up.password) - 2, md4_hash);
+  gen_md4_hash (pwbuf, unicodize (pwbuf, p->up->password) - 2, md4_hash);
 
   /* pad to 21 bytes */
   memset(md4_hash + MD4_DIGEST_LENGTH, 0, 5);
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 0f78020..79fe73f 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -60,7 +60,7 @@ init_http_proxy_options_once (struct http_proxy_options **hpo,
 
 
 /* cached proxy username/password */
-static struct user_pass static_proxy_user_pass;
+static struct user_pass *proxy_user_pass_cache = NULL;
 
 static bool
 recv_line (socket_descriptor_t sd,
@@ -227,34 +227,51 @@ static const char *
 username_password_as_base64 (const struct http_proxy_info *p,
 			     struct gc_arena *gc)
 {
-  struct buffer out = alloc_buf_gc (strlen (p->up.username) + strlen (p->up.password) + 2, gc);
-  ASSERT (strlen (p->up.username) > 0);
-  buf_printf (&out, "%s:%s", p->up.username, p->up.password);
+  struct buffer out = alloc_buf_gc (strlen (p->up->username) + strlen (p->up->password) + 2, gc);
+  ASSERT (strlen (p->up->username) > 0);
+  buf_printf (&out, "%s:%s", p->up->username, p->up->password);
   return (const char *)make_base64_string ((const uint8_t*)BSTR (&out), gc);
 }
 
 static void
 get_user_pass_http (struct http_proxy_info *p, const bool force)
 {
-  if (!static_proxy_user_pass.defined || force)
+  if (!proxy_user_pass_cache || !proxy_user_pass_cache->defined|| force)
     {
       unsigned int flags = GET_USER_PASS_MANAGEMENT;
+
+      if (!proxy_user_pass_cache)
+        {
+          ALLOC_OBJ_CLEAR (proxy_user_pass_cache, struct user_pass);
+        }
+      else
+        {
+          CLEAR (*proxy_user_pass_cache);
+        }
+
       if (p->queried_creds)
 	flags |= GET_USER_PASS_PREVIOUS_CREDS_FAILED;
       if (p->options.inline_creds)
 	flags |= GET_USER_PASS_INLINE_CREDS;
-      get_user_pass (&static_proxy_user_pass,
+      get_user_pass (proxy_user_pass_cache,
 		     p->options.auth_file,
 		     UP_TYPE_PROXY,
 		     flags);
       p->queried_creds = true;
-      p->up = static_proxy_user_pass;
     }
+  p->up = proxy_user_pass_cache;
 }
+
 static void
-clear_user_pass_http (void)
+clear_user_pass_http (struct http_proxy_info *p)
 {
-  purge_user_pass (&static_proxy_user_pass, true);
+  if (proxy_user_pass_cache)
+    {
+      purge_user_pass (proxy_user_pass_cache, true);
+      free (proxy_user_pass_cache);
+      proxy_user_pass_cache = NULL;
+    }
+  p->up = NULL;
 }
 
 #if 0
@@ -761,8 +778,8 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
 	      const char *http_method = "CONNECT";
 	      const char *nonce_count = "00000001";
 	      const char *qop = "auth";
-	      const char *username = p->up.username;
-	      const char *password = p->up.password;
+	      const char *username = p->up->username;
+	      const char *password = p->up->password;
 	      char *opaque_kv = "";
 	      char uri[128];
 	      uint8_t cnonce_raw[8];
@@ -902,7 +919,7 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
 
       /* clear state */
       if (p->options.auth_retry)
-	clear_user_pass_http();
+	clear_user_pass_http(p);
       store_proxy_authenticate(p, NULL);
     }
 
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index 7d2581c..600e2fe 100644
--- a/src/openvpn/proxy.h
+++ b/src/openvpn/proxy.h
@@ -69,7 +69,7 @@ struct http_proxy_info {
   bool defined;
   int auth_method;
   struct http_proxy_options options;
-  struct user_pass up;
+  struct user_pass *up;
   char *proxy_authenticate;
   bool queried_creds;
 };
-- 
1.8.3.1


