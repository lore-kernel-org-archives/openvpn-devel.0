From: Heiko Hund <heiko.hund@...1489...>
Date: Mon, 30 Jul 2012 11:05:22 +0200
Message-ID: <1343639122-8658-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] fix regression with --http-proxy[-*] options
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

Commit af1bf85a introducing the --management-query-proxy option
broke the initialization of HTTP proxy options by not assigning
the allocated object to the options element in the function
init_http_proxy_options_once().

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 src/openvpn/init.c    |    3 +--
 src/openvpn/options.c |    8 ++++----
 src/openvpn/proxy.c   |   12 ++++++------
 src/openvpn/proxy.h   |    2 +-
 4 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 2f84375..270ee6a 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -144,12 +144,11 @@ management_callback_proxy_cmd (void *arg, const char **p)
               msg (M_WARN, "HTTP proxy support only works for TCP based connections");
               return false;
             }
-          ho = init_http_proxy_options_once (ce->http_proxy_options, gc);
+          ho = init_http_proxy_options_once (&ce->http_proxy_options, gc);
           ho->server = string_alloc (p[2], gc);
           ho->port = port;
           ho->retry = true;
           ho->auth_retry = (p[4] && streq (p[4], "nct") ? PAR_NCT : PAR_ALL);
-          ce->http_proxy_options = ho;
           ret = true;
 #endif
         }
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index cd1cb1c..9f4ddbb 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4879,7 +4879,7 @@ add_option (struct options *options,
 	    goto err;
 	  }
 	
-	ho = init_http_proxy_options_once (options->ce.http_proxy_options, &options->gc);
+	ho = init_http_proxy_options_once (&options->ce.http_proxy_options, &options->gc);
 	
 	ho->server = p[1];
 	ho->port = port;
@@ -4914,7 +4914,7 @@ add_option (struct options *options,
     {
       struct http_proxy_options *ho;
       VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
-      ho = init_http_proxy_options_once (options->ce.http_proxy_options, &options->gc);
+      ho = init_http_proxy_options_once (&options->ce.http_proxy_options, &options->gc);
       ho->retry = true;
     }
   else if (streq (p[0], "http-proxy-timeout") && p[1])
@@ -4922,7 +4922,7 @@ add_option (struct options *options,
       struct http_proxy_options *ho;
 
       VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
-      ho = init_http_proxy_options_once (options->ce.http_proxy_options, &options->gc);
+      ho = init_http_proxy_options_once (&options->ce.http_proxy_options, &options->gc);
       ho->timeout = positive_atoi (p[1]);
     }
   else if (streq (p[0], "http-proxy-option") && p[1])
@@ -4930,7 +4930,7 @@ add_option (struct options *options,
       struct http_proxy_options *ho;
 
       VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
-      ho = init_http_proxy_options_once (options->ce.http_proxy_options, &options->gc);
+      ho = init_http_proxy_options_once (&options->ce.http_proxy_options, &options->gc);
 
       if (streq (p[1], "VERSION") && p[2])
 	{
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 28ce019..363d8a7 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -47,17 +47,17 @@
 #define UP_TYPE_PROXY        "HTTP Proxy"
 
 struct http_proxy_options *
-init_http_proxy_options_once (struct http_proxy_options *hpo,
+init_http_proxy_options_once (struct http_proxy_options **hpo,
                               struct gc_arena *gc)
 {
-  if (!hpo)
+  if (!*hpo)
     {
-      ALLOC_OBJ_CLEAR_GC (hpo, struct http_proxy_options, gc);
+      ALLOC_OBJ_CLEAR_GC (*hpo, struct http_proxy_options, gc);
       /* http proxy defaults */
-      hpo->timeout = 5;
-      hpo->http_version = "1.0";
+      (*hpo)->timeout = 5;
+      (*hpo)->http_version = "1.0";
     }
-  return hpo;
+  return *hpo;
 }
 
 
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index dc62261..5e476f1 100644
--- a/src/openvpn/proxy.h
+++ b/src/openvpn/proxy.h
@@ -70,7 +70,7 @@ struct http_proxy_info {
   bool queried_creds;
 };
 
-struct http_proxy_options *init_http_proxy_options_once (struct http_proxy_options *hpo,
+struct http_proxy_options *init_http_proxy_options_once (struct http_proxy_options **hpo,
                                                          struct gc_arena *gc);
 
 struct http_proxy_info *http_proxy_new (const struct http_proxy_options *o);
-- 
1.7.9.5


