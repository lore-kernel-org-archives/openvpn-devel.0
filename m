From: Lev Stipakov <lstipakov@...277...>
Date: Fri,  9 Sep 2022 12:10:37 +0300
Message-Id: <20220909091037.553-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] dco.c: check certain options only on startup
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
 src/openvpn/dco.c     | 145 +++++++++++++++++++++---------------------
 src/openvpn/options.c |   7 +-
 2 files changed, 78 insertions(+), 74 deletions(-)

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 075820c3..a90b6bc7 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -222,9 +222,75 @@ dco_update_keys(dco_context_t *dco, struct tls_multi *multi)
     }
 }
 
+static bool
+dco_check_option_conflict_ce(const struct connection_entry *ce, int msglevel)
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
 dco_check_startup_option_conflict(int msglevel, const struct options *o)
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
+            if (!dco_check_option_conflict_ce(l->array[i], msglevel))
+            {
+                return false;
+            }
+        }
+    }
+    else
+    {
+        if (!dco_check_option_conflict_ce(&o->ce, msglevel))
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
 dco_check_option_conflict(int msglevel, const struct options *o)
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
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index a296086d..66cfd191 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3691,8 +3691,11 @@ options_postprocess_mutate(struct options *o, struct env_set *es)
     /* in Windows we have no 'fallback to non-DCO' strategy, so if a conflicting
      * option is found, we simply bail out by means of M_USAGE
      */
-    dco_check_option_conflict(M_USAGE, o);
-    dco_check_startup_option_conflict(M_USAGE, o);
+    if (dco_enabled(o))
+    {
+        dco_check_option_conflict(M_USAGE, o);
+        dco_check_startup_option_conflict(M_USAGE, o);
+    }
 #endif
 
     if (dco_enabled(o) && o->dev_node)
-- 
2.23.0.windows.1


