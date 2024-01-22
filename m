From: Gert Doering <gert@...1296...>
Date: Mon, 22 Jan 2024 10:21:22 +0100
Message-ID: <20240122092122.8591-1-gert@...1296...>
In-Reply-To: <gerrit.1705068839000.I6f402db2fb73f1206fbc1139c47d2bf4378376fa@...2715...>
References: <gerrit.1705068839000.I6f402db2fb73f1206fbc1139c47d2bf4378376fa@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] --http-proxy-user-pass: allow to specify
 in either order with --http-proxy
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

From: Frank Lichtenheld <frank@...2641...>

Previously, when using a third argument to --http-proxy other
than auto/auto-nct, order did matter between --http-proxy and
--http-proxy-user-pass. Always prefer --http-proxy-user-pass
when given.

Change-Id: I6f402db2fb73f1206fbc1139c47d2bf4378376fa
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/499
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index f54f276..e393511 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1649,6 +1649,8 @@
     SHOW_STR(port);
     SHOW_STR(auth_method_string);
     SHOW_STR(auth_file);
+    SHOW_STR(auth_file_up);
+    SHOW_BOOL(inline_creds);
     SHOW_STR(http_version);
     SHOW_STR(user_agent);
     for  (i = 0; i < MAX_CUSTOM_HTTP_HEADER && o->custom_headers[i].name; i++)
@@ -6824,7 +6826,7 @@
         struct http_proxy_options *ho;
         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
         ho = init_http_proxy_options_once(&options->ce.http_proxy_options, &options->gc);
-        ho->auth_file = p[1];
+        ho->auth_file_up = p[1];
         ho->inline_creds = is_inline;
     }
     else if (streq(p[0], "http-proxy-retry") || streq(p[0], "socks-proxy-retry"))
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index e081532..e2324f4 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -271,6 +271,11 @@
     if (!static_proxy_user_pass.defined)
     {
         unsigned int flags = GET_USER_PASS_MANAGEMENT;
+        const char *auth_file = p->options.auth_file;
+        if (p->options.auth_file_up)
+        {
+            auth_file = p->options.auth_file_up;
+        }
         if (p->queried_creds)
         {
             flags |= GET_USER_PASS_PREVIOUS_CREDS_FAILED;
@@ -280,7 +285,7 @@
             flags |= GET_USER_PASS_INLINE_CREDS;
         }
         get_user_pass(&static_proxy_user_pass,
-                      p->options.auth_file,
+                      auth_file,
                       UP_TYPE_PROXY,
                       flags);
         p->queried_creds = true;
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index 7900244..4e78772 100644
--- a/src/openvpn/proxy.h
+++ b/src/openvpn/proxy.h
@@ -52,10 +52,11 @@
 
     const char *auth_method_string;
     const char *auth_file;
+    const char *auth_file_up; /* specified with --http-proxy-user-pass */
     const char *http_version;
     const char *user_agent;
     struct http_custom_header custom_headers[MAX_CUSTOM_HTTP_HEADER];
-    bool inline_creds;
+    bool inline_creds; /* auth_file_up is inline credentials */
 };
 
 struct http_proxy_options_simple {

