From: Gert Doering <gert@...1296...>
Date: Sun, 23 Jun 2024 22:05:51 +0200
Message-ID: <20240623200551.20092-1-gert@...1296...>
In-Reply-To: <gerrit.1707991289000.Ia3e06c0832c4ca0ab868c845279fb71c01a1a78a@...2715...>
References: <gerrit.1707991289000.Ia3e06c0832c4ca0ab868c845279fb71c01a1a78a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v10] Http-proxy: fix bug preventing proxy
 credentials caching
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

From: Gianmarco De Gregori <gianmarco@...2726...>

Caching proxy credentials was not working due to the
lack of handling already defined creds in get_user_pass(),
which prevented the caching from working properly.

Fix this issue by getting the value of c->first_time,
that indicates if we're at the first iteration
of the main loop and use it as second argument of the
get_user_pass_http(). Otherwise, on SIGUSR1 or SIGHUP
upon instance context restart credentials would be erased
every time.

The nocache member has been added to the struct
http_proxy_options and also a getter method to retrieve
that option from ssl has been added, by doing this
we're able to erase previous queried user credentials
to ensure correct operation.

Fixes: Trac #1187
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Change-Id: Ia3e06c0832c4ca0ab868c845279fb71c01a1a78a
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/523
This mail reflects revision 10 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
index eb9cf28..ba9376b 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -19,9 +19,6 @@
   When using ``--auth-nocache`` in combination with a user/password file
   and ``--chroot`` or ``--daemon``, make sure to use an absolute path.
 
-  This directive does not affect the ``--http-proxy`` username/password.
-  It is always cached.
-
 --cd dir
   Change directory to ``dir`` prior to reading any files such as
   configuration files, key files, scripts, etc. ``dir`` should be an
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index b081b2f..a49e563 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -691,6 +691,8 @@
 
     if (c->options.ce.http_proxy_options)
     {
+        c->options.ce.http_proxy_options->first_time = c->first_time;
+
         /* Possible HTTP proxy user/pass input */
         c->c1.http_proxy = http_proxy_new(c->options.ce.http_proxy_options);
         if (c->c1.http_proxy)
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index f2c7536..dbe1425 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1650,6 +1650,7 @@
     SHOW_STR(auth_file);
     SHOW_STR(auth_file_up);
     SHOW_BOOL(inline_creds);
+    SHOW_BOOL(nocache);
     SHOW_STR(http_version);
     SHOW_STR(user_agent);
     for  (i = 0; i < MAX_CUSTOM_HTTP_HEADER && o->custom_headers[i].name; i++)
@@ -3151,6 +3152,11 @@
         ce->flags |= CE_DISABLED;
     }
 
+    if (ce->http_proxy_options)
+    {
+        ce->http_proxy_options->nocache = ssl_get_auth_nocache();
+    }
+
     /* our socks code is not fully IPv6 enabled yet (TCP works, UDP not)
      * so fall back to IPv4-only (trac #1221)
      */
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index ba3d87c..5de0da4 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -276,7 +276,7 @@
         {
             auth_file = p->options.auth_file_up;
         }
-        if (p->queried_creds)
+        if (p->queried_creds && !static_proxy_user_pass.nocache)
         {
             flags |= GET_USER_PASS_PREVIOUS_CREDS_FAILED;
         }
@@ -288,9 +288,14 @@
                       auth_file,
                       UP_TYPE_PROXY,
                       flags);
-        p->queried_creds = true;
-        p->up = static_proxy_user_pass;
+        static_proxy_user_pass.nocache = p->options.nocache;
     }
+
+    /*
+     * Using cached credentials
+     */
+    p->queried_creds = true;
+    p->up = static_proxy_user_pass;
 }
 
 #if 0
@@ -542,7 +547,7 @@
      * we know whether we need any. */
     if (p->auth_method == HTTP_AUTH_BASIC || p->auth_method == HTTP_AUTH_NTLM2)
     {
-        get_user_pass_http(p, true);
+        get_user_pass_http(p, p->options.first_time);
     }
 
 #if !NTLM
@@ -656,6 +661,11 @@
         || p->auth_method == HTTP_AUTH_NTLM2)
     {
         get_user_pass_http(p, false);
+
+        if (p->up.nocache)
+        {
+            clear_user_pass_http();
+        }
     }
 
     /* are we being called again after getting the digest server nonce in the previous transaction? */
@@ -1036,13 +1046,6 @@
             }
             goto error;
         }
-
-        /* clear state */
-        if (p->options.auth_retry)
-        {
-            clear_user_pass_http();
-        }
-        store_proxy_authenticate(p, NULL);
     }
 
     /* check return code, success = 200 */
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index a502c9d..d9e598c 100644
--- a/src/openvpn/proxy.h
+++ b/src/openvpn/proxy.h
@@ -57,6 +57,8 @@
     const char *user_agent;
     struct http_custom_header custom_headers[MAX_CUSTOM_HTTP_HEADER];
     bool inline_creds; /* auth_file_up is inline credentials */
+    bool first_time; /* indicates if we need to wipe user creds at the first iteration of the main loop */
+    bool nocache;
 };
 
 struct http_proxy_options_simple {
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 2054eb4..7dd687b 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -335,6 +335,15 @@
 }
 
 /*
+ * Get the password caching
+ */
+bool
+ssl_get_auth_nocache(void)
+{
+    return passbuf.nocache;
+}
+
+/*
  * Set an authentication token
  */
 void
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 98e59e8..11ca20d 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -397,6 +397,11 @@
 void ssl_set_auth_nocache(void);
 
 /*
+ * Getter method for retrieving the auth-nocache option.
+ */
+bool ssl_get_auth_nocache(void);
+
+/*
  * Purge any stored authentication information, both for key files and tunnel
  * authentication. If PCKS #11 is enabled, purge authentication for that too.
  * Note that auth_token is not cleared.

