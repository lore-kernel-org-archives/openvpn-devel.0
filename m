From: Holger Kummert <Holger.Kummert@...1516...>
Date: Wed, 16 Apr 2014 12:48:37 +0200
Message-ID: <1397645317-20116-3-git-send-email-Holger.Kummert@...1516...>
In-Reply-To: <1397645317-20116-1-git-send-email-Holger.Kummert@...1516...>
References: <1397645317-20116-1-git-send-email-Holger.Kummert@...1516...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] http-proxy: Separate settings for user
	interaction and authentication auto-behavior
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

User interaction is set with 'stdin' (one try) and 'interact' (repeated tries)

Authentication 'auto' and 'auto-nct' examine auth request from server.
If NTLM is requested, NTLMv2 is tried first. Only on failure NTLMv1 is tried
with no additional user interaction.
The other modes remain at one round of interaction.

Signed-off-by: Holger Kummert <Holger.Kummert@...1516...>
---
 doc/openvpn.8         | 22 +++++++------
 src/openvpn/init.c    |  3 +-
 src/openvpn/options.c | 88 +++++++++++++++++++++++++++++++++++++--------------
 src/openvpn/proxy.c   | 56 +++++++++++++++++++++++---------
 src/openvpn/proxy.h   | 22 +++++++------
 5 files changed, 132 insertions(+), 59 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 3a58317..de9852e 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -496,7 +496,7 @@ Show sensed HTTP or SOCKS proxy settings. Currently, only Windows clients
 support this option.
 .\"*********************************************************
 .TP
-.B \-\-http-proxy server port [authfile|'auto'|'auto-nct'] [auth-method]
+.B \-\-http-proxy server port [authfile | 'interact'] [ auth-method ]
 Connect to remote host through an HTTP proxy at address
 .B server
 and port
@@ -504,17 +504,12 @@ and port
 If HTTP Proxy-Authenticate is required,
 .B authfile
 is a file containing a username and password on 2 lines, or
-"stdin" to prompt from console.
+"stdin"/"interact" to prompt from console where "interact"
+prompts again after an auth failure.
 
 .B auth-method
-should be one of "none", "basic", or "ntlm".
-
-HTTP Digest authentication is supported as well, but only via
-the
-.B auto
-or
-.B auto-nct
-flags (below).
+should be one of "none", "auto", "auto-nct", "basic", "digest",
+"ntlm" or "ntlm2".
 
 The
 .B auto
@@ -529,6 +524,13 @@ The
 flag (no clear-text auth) instructs OpenVPN to automatically
 determine the authentication method, but to reject weak
 authentication protocols such as HTTP Basic Authentication.
+
+For both
+.B auto
+and
+.B auto-nct
+the server requirement for NTLM authentication leads to try
+NTLMv2 first before NTLMv1.
 .\"*********************************************************
 .TP
 .B \-\-http-proxy-retry
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index c2907cd..23fa926 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -140,7 +140,8 @@ management_callback_proxy_cmd (void *arg, const char **p)
           ho->server = string_alloc (p[2], gc);
           ho->port = string_alloc (p[3], gc);
           ho->retry = true;
-          ho->auth_retry = (p[4] && streq (p[4], "nct") ? PAR_NCT : PAR_ALL);
+          ho->auth_retry = AUTH_INTERACT;
+          ho->auth_method_string = string_alloc (p[4] && streq (p[4], "nct") ? "auto-nct" : "auto", gc);
           ret = true;
 #endif
         }
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 18cb354..12afe6d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -140,15 +140,17 @@ static const char usage_message[] =
   "--connect-timeout n : For --proto tcp-client, connection timeout (in seconds).\n"
   "--connect-retry-max n : Maximum connection attempt retries, default infinite.\n"
 #ifdef ENABLE_HTTP_PROXY
-  "--http-proxy s p [up] [auth] : Connect to remote host\n"
+  "--http-proxy s p [up | 'interact'] [auth] : Connect to remote host\n"
   "                  through an HTTP proxy at address s and port p.\n"
   "                  If proxy authentication is required,\n"
   "                  up is a file containing username/password on 2 lines, or\n"
-  "                  'stdin' to prompt from console.  Add auth='ntlm' if\n"
-  "                  the proxy requires NTLM authentication.\n"
-  "--http-proxy s p 'auto[-nct]' : Like the above directive, but automatically\n"
-  "                  determine auth method and query for username/password\n"
-  "                  if needed.  auto-nct disables weak proxy auth methods.\n"
+  "                  'stdin' to prompt from console.  'interact' prompts again\n"
+  "                  after failure.\n"
+  "                  auth may be one of 'ntlm' or 'ntlm2', if the proxy requires\n"
+  "                  NTLM authentication, or 'basic', 'digest', 'auto' or\n"
+  "                  'auto-nct'. The latter two automatically determine auth\n"
+  "                  method and query for username/password if needed.\n"
+  "                  auto-nct disables weak proxy auth methods.\n"
   "--http-proxy-retry     : Retry indefinitely on HTTP proxy errors.\n"
   "--http-proxy-timeout n : Proxy timeout in seconds, default=5.\n"
   "--http-proxy-option type [parm] : Set extended HTTP proxy options.\n"
@@ -1713,9 +1715,10 @@ parse_http_proxy_override (const char *server,
       ho->retry = true;
       ho->timeout = 5;
       if (flags && !strcmp(flags, "nct"))
-	ho->auth_retry = PAR_NCT;
+        ho->auth_method_string = string_alloc ("auto-nct", gc);
       else
-	ho->auth_retry = PAR_ALL;
+        ho->auth_method_string = string_alloc ("auto", gc);
+      ho->auth_retry = AUTH_INTERACT;
       ho->http_version = "1.0";
       ho->user_agent = "OpenVPN-Autoproxy/1.0";
       return ho;
@@ -5019,23 +5022,60 @@ add_option (struct options *options,
 
       if (p[3])
 	{
-	  /* auto -- try to figure out proxy addr, port, and type automatically */
-	  /* semiauto -- given proxy addr:port, try to figure out type automatically */
-	  /* (auto|semiauto)-nct -- disable proxy auth cleartext protocols (i.e. basic auth) */
-	  if (streq (p[3], "auto"))
-	    ho->auth_retry = PAR_ALL;
-	  else if (streq (p[3], "auto-nct"))
-	    ho->auth_retry = PAR_NCT;
-	  else
-	    {
-	      ho->auth_method_string = "basic";
-	      ho->auth_file = p[3];
+          /*
+            http-proxy server port [authfile | 'interact'] [ auth-method ]
 
-	      if (p[4])
-		{
-		  ho->auth_method_string = p[4];
-		}
-	    }
+                  auth-method := auto | auto-nct | basic | digest | ntlm | ntlm2
+           */
+          /* auth-methods:                                               */
+          /* auto     -- try to figure out proxy auth type automatically */
+          /* auto-nct -- disable proxy auth cleartext protocols (i.e. basic auth) */
+          /* basic    -- Basic HTTP authentication (cleartext password) */
+          /* digest   -- HTTP Digest authentication */
+          /* ntlm     -- Microsoft's NTLMv1 authentication */
+          /* ntlm2    -- Microsoft's NTLMv2 authentication */
+
+          ho->auth_retry = AUTH_NO_RETRY;      /* Behaviour: Ask once, stop on failure. */
+	  if (streq (p[3], "interact"))
+	    ho->auth_retry = AUTH_INTERACT;
+          if (p[4])
+            {
+              ho->auth_method_string = p[4];
+
+              if (ho->auth_retry == AUTH_NO_RETRY)
+                {
+                  /* backward compatible with former behaviour */
+                  if (streq(p[3], "auto") || streq(p[3], "auto-nct"))
+                    {
+                      ho->auth_method_string = p[3];
+                    }
+                  else
+                    {
+                      ho->auth_file = p[3];
+                    }
+                }
+            }
+          else
+            {
+              if (streq (p[3], "none")     ||
+                  streq (p[3], "auto")     ||
+                  streq (p[3], "auto-nct") ||
+                  streq (p[3], "basic")    ||
+                  streq (p[3], "digest")   ||
+                  streq (p[3], "ntlm")     ||
+                  streq (p[3], "ntlm2"))
+                {
+                  ho->auth_method_string = p[3];
+                }
+              else
+                {
+                  if (ho->auth_retry == AUTH_NO_RETRY)
+                    {
+                      ho->auth_file = p[3];
+                    }
+                  ho->auth_method_string = "basic";
+                }
+            }
 	}
       else
 	{
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index f7f0648..cdfc47d 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -314,7 +314,7 @@ get_proxy_authenticate (socket_descriptor_t sd,
 #if NTLM
 	  else if (!strncmp(buf+20, "NTLM", 4))
 	    {
-	      msg (D_PROXY, "PROXY AUTH HTLM: '%s'", buf);
+	      msg (D_PROXY, "PROXY AUTH NTLM: '%s'", buf);
 	      *data = NULL;
 	      ret = HTTP_AUTH_NTLM;
 	    }
@@ -456,6 +456,12 @@ http_proxy_new (const struct http_proxy_options *o)
 	p->auth_method = HTTP_AUTH_NONE;
       else if (!strcmp (o->auth_method_string, "basic"))
 	p->auth_method = HTTP_AUTH_BASIC;
+      else if (!strcmp (o->auth_method_string, "digest"))
+	p->auth_method = HTTP_AUTH_DIGEST;
+      else if (!strcmp (o->auth_method_string, "auto"))
+	p->auth_method = HTTP_AUTH_AUTO;
+      else if (!strcmp (o->auth_method_string, "auto-nct"))
+	p->auth_method = HTTP_AUTH_AUTO_NCT;
 #if NTLM
       else if (!strcmp (o->auth_method_string, "ntlm"))
 	p->auth_method = HTTP_AUTH_NTLM;
@@ -467,6 +473,11 @@ http_proxy_new (const struct http_proxy_options *o)
 	     o->auth_method_string);
     }
 
+  if (p->auth_method == HTTP_AUTH_AUTO || p->auth_method == HTTP_AUTH_AUTO_NCT)
+    {
+       p->auth_auto = p->auth_method;
+    }
+
   /* only basic and NTLM/NTLMv2 authentication supported so far */
   if (p->auth_method == HTTP_AUTH_BASIC || p->auth_method == HTTP_AUTH_NTLM || p->auth_method == HTTP_AUTH_NTLM2)
     {
@@ -559,7 +570,7 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
 {
   struct gc_arena gc = gc_new ();
   char buf[512];
-  char buf2[129];
+  char buf2[513];
   char get[80];
   int status;
   int nparms;
@@ -569,7 +580,8 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
   /* get user/pass if not previously given */
   if (p->auth_method == HTTP_AUTH_BASIC
       || p->auth_method == HTTP_AUTH_DIGEST
-      || p->auth_method == HTTP_AUTH_NTLM)
+      || p->auth_method == HTTP_AUTH_NTLM
+      || p->auth_method == HTTP_AUTH_NTLM2)
     get_user_pass_http (p, false);
 
   /* are we being called again after getting the digest server nonce in the previous transaction? */
@@ -598,6 +610,8 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
       /* auth specified? */
       switch (p->auth_method)
 	{
+	case HTTP_AUTH_AUTO:
+	case HTTP_AUTH_AUTO_NCT:
 	case HTTP_AUTH_NONE:
 	  break;
 
@@ -672,7 +686,7 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
 
               openvpn_snprintf (get, sizeof get, "%%*s NTLM %%%ds", (int) sizeof (buf2) - 1);
               nparms = sscanf (buf, get, buf2);
-              buf2[128] = 0; /* we only need the beginning - ensure it's null terminated. */
+              buf2[512] = 0; /* we only need the beginning - ensure it's null terminated. */
 
               /* check for "Proxy-Authenticate: NTLM TlRM..." */
               if (nparms == 1)
@@ -859,20 +873,25 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
 	    }
 	}
 #endif
-      else if (p->options.auth_retry)
+      else if (p->options.auth_retry || p->auth_method == HTTP_AUTH_AUTO || p->auth_method == HTTP_AUTH_AUTO_NCT)
 	{
 	  /* figure out what kind of authentication the proxy needs */
 	  char *pa = NULL;
-	  const int method = get_proxy_authenticate(sd,
-						    p->options.timeout,
-						    &pa,
-						    NULL,
-						    signal_received);
+	  int method = get_proxy_authenticate(sd,
+					      p->options.timeout,
+					      &pa,
+					      NULL,
+					      signal_received);
+
+          if (p->auth_auto && method == HTTP_AUTH_NTLM && (!processed  || !static_proxy_user_pass.defined))
+            {
+              method = HTTP_AUTH_NTLM2;         /* Try higher security first */
+            }
 	  if (method != HTTP_AUTH_NONE)
 	    {
 	      if (pa)
 		msg (D_PROXY, "HTTP proxy authenticate '%s'", pa);
-	      if (p->options.auth_retry == PAR_NCT && method == HTTP_AUTH_BASIC)
+	      if (p->auth_method == HTTP_AUTH_AUTO_NCT && method == HTTP_AUTH_BASIC)
 		{
 		  msg (D_PROXY, "HTTP proxy: support for basic auth and other cleartext proxy auth methods is disabled");
 		  goto error;
@@ -896,10 +915,17 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
 	  goto error;
 	}
 
-      /* clear state */
-      if (p->options.auth_retry)
-	clear_user_pass_http();
-      store_proxy_authenticate(p, NULL);
+      if (status != 200 && processed && p->auth_auto && p->auth_method == HTTP_AUTH_NTLM2)
+        {
+          p->auth_method = p->auth_auto;
+        }
+      else
+        {
+          /* clear state */
+          if (p->options.auth_retry)
+            clear_user_pass_http();
+          store_proxy_authenticate(p, NULL);
+        }
     }
 
   /* check return code, success = 200 */
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index 0e7a6df..6903eb3 100644
--- a/src/openvpn/proxy.h
+++ b/src/openvpn/proxy.h
@@ -31,12 +31,16 @@
 #ifdef ENABLE_HTTP_PROXY
 
 /* HTTP CONNECT authentication methods */
-#define HTTP_AUTH_NONE   0
-#define HTTP_AUTH_BASIC  1
-#define HTTP_AUTH_DIGEST 2
-#define HTTP_AUTH_NTLM   3
-#define HTTP_AUTH_NTLM2  4
-#define HTTP_AUTH_N      5 /* number of HTTP_AUTH methods */
+enum {
+  HTTP_AUTH_NONE = 0,
+  HTTP_AUTH_AUTO,
+  HTTP_AUTH_AUTO_NCT,
+  HTTP_AUTH_BASIC,
+  HTTP_AUTH_DIGEST,
+  HTTP_AUTH_NTLM,
+  HTTP_AUTH_NTLM2,
+  HTTP_AUTH_N       /* number of HTTP_AUTH methods */
+};
 
 struct http_custom_header {
   const char *name;
@@ -50,9 +54,8 @@ struct http_proxy_options {
   bool retry;
   int timeout;
 
-# define PAR_NO  0  /* don't support any auth retries */
-# define PAR_ALL 1  /* allow all proxy auth protocols */
-# define PAR_NCT 2  /* disable cleartext proxy auth protocols */
+# define AUTH_NO_RETRY        0
+# define AUTH_INTERACT        1         /* allow auth retries */
   int auth_retry;
 
   const char *auth_method_string;
@@ -70,6 +73,7 @@ struct http_proxy_options_simple {
 
 struct http_proxy_info {
   bool defined;
+  int auth_auto;
   int auth_method;
   struct http_proxy_options options;
   struct user_pass up;
-- 
1.8.4.5


