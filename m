From: Lev Stipakov <lstipakov@...277...>
Date: Fri,  9 Sep 2022 15:18:41 +0300
Message-Id: <20220909121841.646-1-lstipakov@...277...>
In-Reply-To: <20220909091037.553-1-lstipakov@...277...>
References: <20220909091037.553-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] dco.c: check certain options only on
 startup
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

Following options are set on startup and cannot be changed later:

 - dev
 - dev-type
 - connections list
 - mode
 - topology

Same for system-wide availability of dco.

dco_check_option_conflict(), where those options
were checked, is also called in server mode when
client is connected. Move those checks to
dco_check_startup_option_conflict() which is only
called at startup.

Since we moved dco_enabled() check to startup,
dco_check_option_conflict() might now trigger exit
on Windows if system lacks chachapoly support.
Since dco checks only need to be performed for
dco, wrap those into "if (dco_enabled) {}".

Signed-off-by: Lev Stipakov <lev@...515...>
---
 
 v2: remove "_conflict" ending from dco options check
   function names, since it adds confusion

 src/openvpn/dco.c     | 149 +++++++++++++++++++++---------------------
 src/openvpn/dco.h     |   8 +--
 src/openvpn/multi.c   |   2 +-
 src/openvpn/options.c |  11 ++--
 4 files changed, 87 insertions(+), 83 deletions(-)

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 075820c3..d9e49781 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -222,9 +222,75 @@ dco_update_keys(dco_context_t *dco, struct tls_multi *multi)
     }
 }
 
+static bool
+dco_check_option_ce(const struct connection_entry *ce, int msglevel)
+{
+    if (ce->fragment)
+    {
+        msg(msglevel, "Note: --fragment disables data channel offload.");
+        return false;
+    }
+
+    if (ce->http_proxy_options)
+    {
+        msg(msglevel, "Note: --http-proxy disables data channel offload.");
+        return false;
+    }
+
+    if (ce->socks_proxy_server)
+    {
+        msg(msglevel, "Note: --socks-proxy disables data channel offload.");
+        return false;
+    }
+
+#if defined(TARGET_FREEBSD)
+    if (!proto_is_udp(ce->proto))
+    {
+        msg(msglevel, "NOTE: TCP transport disables data channel offload on FreeBSD.");
+        return false;
+    }
+#endif
+
+    return true;
+}
+
 bool
-dco_check_startup_option_conflict(int msglevel, const struct options *o)
+dco_check_startup_option(int msglevel, const struct options *o)
 {
+    /* check if DCO was already disabled by the user or if no dev name was
+     * specified at all. In the latter case, later logic will most likely stop
+     * OpenVPN, so no need to print any message here.
+     */
+    if (!dco_enabled(o) || !o->dev)
+    {
+        return false;
+    }
+
+    if (dev_type_enum(o->dev, o->dev_type) != DEV_TYPE_TUN)
+    {
+        msg(msglevel, "Note: dev-type not tun, disabling data channel offload.");
+        return false;
+    }
+
+    if (o->connection_list)
+    {
+        const struct connection_list *l = o->connection_list;
+        for (int i = 0; i < l->len; ++i)
+        {
+            if (!dco_check_option_ce(l->array[i], msglevel))
+            {
+                return false;
+            }
+        }
+    }
+    else
+    {
+        if (!dco_check_option_ce(&o->ce, msglevel))
+        {
+            return false;
+        }
+    }
+
 #if defined(_WIN32)
     if (o->mode == MODE_SERVER)
     {
@@ -281,59 +347,22 @@ dco_check_startup_option_conflict(int msglevel, const struct options *o)
         }
     }
 #endif /* if defined(HAVE_LIBCAPNG) */
-    return true;
-}
 
-static bool
-dco_check_option_conflict_ce(const struct connection_entry *ce, int msglevel)
-{
-    if (ce->fragment)
-    {
-        msg(msglevel, "Note: --fragment disables data channel offload.");
-        return false;
-    }
-
-    if (ce->http_proxy_options)
-    {
-        msg(msglevel, "Note: --http-proxy disables data channel offload.");
-        return false;
-    }
-
-    if (ce->socks_proxy_server)
-    {
-        msg(msglevel, "Note: --socks-proxy disables data channel offload.");
-        return false;
-    }
-
-#if defined(TARGET_FREEBSD)
-    if (!proto_is_udp(ce->proto))
+    if (o->mode == MODE_SERVER && o->topology != TOP_SUBNET)
     {
-        msg(msglevel, "NOTE: TCP transport disables data channel offload on FreeBSD.");
+        msg(msglevel, "Note: NOT using '--topology subnet' disables data channel offload.");
         return false;
     }
-#endif
 
-    return true;
+    /* now that all options have been confirmed to be supported, check
+     * if DCO is truly available on the system
+     */
+    return dco_available(msglevel);
 }
 
 bool
-dco_check_option_conflict(int msglevel, const struct options *o)
+dco_check_option(int msglevel, const struct options *o)
 {
-    /* check if DCO was already disabled by the user or if no dev name was
-     * specified at all. In the latter case, later logic will most likely stop
-     * OpenVPN, so no need to print any message here.
-     */
-    if (!dco_enabled(o) || !o->dev)
-    {
-        return false;
-    }
-
-    if (dev_type_enum(o->dev, o->dev_type) != DEV_TYPE_TUN)
-    {
-        msg(msglevel, "Note: dev-type not tun, disabling data channel offload.");
-        return false;
-    }
-
     /* At this point the ciphers have already been normalised */
     if (o->enable_ncp_fallback
         && !tls_item_in_cipher_list(o->ciphername, dco_get_supported_ciphers()))
@@ -343,31 +372,6 @@ dco_check_option_conflict(int msglevel, const struct options *o)
         return false;
     }
 
-    if (o->connection_list)
-    {
-        const struct connection_list *l = o->connection_list;
-        for (int i = 0; i < l->len; ++i)
-        {
-            if (!dco_check_option_conflict_ce(l->array[i], msglevel))
-            {
-                return false;
-            }
-        }
-    }
-    else
-    {
-        if (!dco_check_option_conflict_ce(&o->ce, msglevel))
-        {
-            return false;
-        }
-    }
-
-    if (o->mode == MODE_SERVER && o->topology != TOP_SUBNET)
-    {
-        msg(msglevel, "Note: NOT using '--topology subnet' disables data channel offload.");
-        return false;
-    }
-
 #if defined(USE_COMP)
     if (o->comp.alg != COMP_ALG_UNDEF
         || o->comp.flags & COMP_F_ALLOW_ASYM
@@ -400,10 +404,7 @@ dco_check_option_conflict(int msglevel, const struct options *o)
     }
     gc_free(&gc);
 
-    /* now that all options have been confirmed to be supported, check
-     * if DCO is truly available on the system
-     */
-    return dco_available(msglevel);
+    return true;
 }
 
 bool
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index e5f6b51c..e051db06 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -67,7 +67,7 @@ bool dco_available(int msglevel);
  * @param o         the options struct that hold the options
  * @return          true if no conflict was detected, false otherwise
  */
-bool dco_check_option_conflict(int msglevel, const struct options *o);
+bool dco_check_option(int msglevel, const struct options *o);
 
 /**
  * Check whether the options struct has any further option that is not supported
@@ -79,7 +79,7 @@ bool dco_check_option_conflict(int msglevel, const struct options *o);
  * @param o         the options struct that hold the options
  * @return          true if no conflict was detected, false otherwise
  */
-bool dco_check_startup_option_conflict(int msglevel, const struct options *o);
+bool dco_check_startup_option(int msglevel, const struct options *o);
 
 /**
  * Check whether any of the options pushed by the server is not supported by
@@ -243,13 +243,13 @@ dco_available(int msglevel)
 }
 
 static inline bool
-dco_check_option_conflict(int msglevel, const struct options *o)
+dco_check_option(int msglevel, const struct options *o)
 {
     return false;
 }
 
 static inline bool
-dco_check_startup_option_conflict(int msglevel, const struct options *o)
+dco_check_startup_option(int msglevel, const struct options *o)
 {
     return false;
 }
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index b58bea7b..1bbeab7d 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2719,7 +2719,7 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
 
     /* Check if we have forbidding options in the current mode */
     if (dco_enabled(&mi->context.options)
-        && !dco_check_option_conflict(D_MULTI_ERRORS, &mi->context.options))
+        && !dco_check_option(D_MULTI_ERRORS, &mi->context.options))
     {
         msg(D_MULTI_ERRORS, "MULTI: client has been rejected due to incompatible DCO options");
         cc_succeeded = false;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index a296086d..2e567571 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3685,14 +3685,17 @@ options_postprocess_mutate(struct options *o, struct env_set *es)
 
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     /* check if any option should force disabling DCO */
-    o->tuntap_options.disable_dco = !dco_check_option_conflict(D_DCO, o)
-                                    || !dco_check_startup_option_conflict(D_DCO, o);
+    o->tuntap_options.disable_dco = !dco_check_option(D_DCO, o)
+                                    || !dco_check_startup_option(D_DCO, o);
 #elif defined(_WIN32)
     /* in Windows we have no 'fallback to non-DCO' strategy, so if a conflicting
      * option is found, we simply bail out by means of M_USAGE
      */
-    dco_check_option_conflict(M_USAGE, o);
-    dco_check_startup_option_conflict(M_USAGE, o);
+    if (dco_enabled(o))
+    {
+        dco_check_option(M_USAGE, o);
+        dco_check_startup_option(M_USAGE, o);
+    }
 #endif
 
     if (dco_enabled(o) && o->dev_node)
-- 
2.23.0.windows.1


