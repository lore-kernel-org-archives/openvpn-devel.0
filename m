From: James Yonan <james@...515...>
Date: Thu,  3 Mar 2016 01:19:05 -0700
Message-Id: <1456993146-63968-9-git-send-email-james@...515...>
In-Reply-To: <1456993146-63968-1-git-send-email-james@...515...>
References: <1456993146-63968-1-git-send-email-james@...515...>
Subject: [Openvpn-devel] [PATCH 09/10] Added directive to specify HTTP proxy
	credentials in config.
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
Cc: James Yonan <james@...515...>

The inline directive http-proxy-user-pass can be used to
specify proxy credentials in config, e.g.:

http-proxy proxy.tld 3128 auto-nct
<http-proxy-user-pass>
foo
bar
</http-proxy-user-pass>

This usage is already supported by OpenVPN 3.

Signed-off-by: James Yonan <james@...515...>
---
 src/openvpn/misc.c    |  8 ++++++++
 src/openvpn/misc.h    |  2 ++
 src/openvpn/options.c | 13 +++++++++++++
 src/openvpn/proxy.c   |  2 ++
 src/openvpn/proxy.h   |  1 +
 5 files changed, 26 insertions(+)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 05ed073..4766a17 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1090,6 +1090,14 @@ get_user_pass_cr (struct user_pass *up,
 	  if (!strlen (up->password))
 	    strcpy (up->password, "ok");
 	}
+      else if (flags & GET_USER_PASS_INLINE_CREDS)
+	{
+	  struct buffer buf;
+	  buf_set_read (&buf, (uint8_t*) auth_file, strlen (auth_file) + 1);
+	  if (!(flags & GET_USER_PASS_PASSWORD_ONLY))
+	    buf_parse (&buf, '\n', up->username, USER_PASS_LEN);
+	  buf_parse (&buf, '\n', up->password, USER_PASS_LEN);
+	}
       else if (from_authfile)
         {
           /*
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 65a6e55..b694096 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -256,6 +256,8 @@ struct static_challenge_info {};
 #define GET_USER_PASS_STATIC_CHALLENGE       (1<<8) /* SCRV1 protocol -- static challenge */
 #define GET_USER_PASS_STATIC_CHALLENGE_ECHO  (1<<9) /* SCRV1 protocol -- echo response */
 
+#define GET_USER_PASS_INLINE_CREDS (1<<10)  /* indicates that auth_file is actually inline creds */
+
 bool get_user_pass_cr (struct user_pass *up,
 		       const char *auth_file,
 		       const char *prefix,
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index b53f7ac..8f560a7 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5121,6 +5121,19 @@ add_option (struct options *options,
 	  ho->auth_method_string = "none";
 	}
     }
+  else if (streq (p[0], "http-proxy-user-pass") && p[1])
+    {
+      struct http_proxy_options *ho;
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      ho = init_http_proxy_options_once (&options->ce.http_proxy_options, &options->gc);
+      if (streq (p[1], INLINE_FILE_TAG) && p[2])
+	{
+	  ho->auth_file = p[2];
+	  ho->inline_creds = true;
+	}
+      else
+	ho->auth_file = p[1];
+    }
   else if (streq (p[0], "http-proxy-retry") && !p[1])
     {
       struct http_proxy_options *ho;
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 2568e19..865a026 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -241,6 +241,8 @@ get_user_pass_http (struct http_proxy_info *p, const bool force)
       unsigned int flags = GET_USER_PASS_MANAGEMENT;
       if (p->queried_creds)
 	flags |= GET_USER_PASS_PREVIOUS_CREDS_FAILED;
+      if (p->options.inline_creds)
+	flags |= GET_USER_PASS_INLINE_CREDS;
       get_user_pass (&static_proxy_user_pass,
 		     p->options.auth_file,
 		     UP_TYPE_PROXY,
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index 4715940..864d3b9 100644
--- a/src/openvpn/proxy.h
+++ b/src/openvpn/proxy.h
@@ -58,6 +58,7 @@ struct http_proxy_options {
   const char *http_version;
   const char *user_agent;
   struct http_custom_header custom_headers[MAX_CUSTOM_HTTP_HEADER];
+  bool inline_creds;
 };
 
 struct http_proxy_options_simple {
-- 
1.9.1


