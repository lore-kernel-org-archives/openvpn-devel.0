From: Arne Schwabe <arne@...1227...>
Date: Thu, 10 Feb 2022 17:26:26 +0100
Message-Id: <20220210162632.3309974-2-arne@...1227...>
In-Reply-To: <20220210162632.3309974-1-arne@...1227...>
References: <20220210162632.3309974-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4 2/8] Change the default for mssfix to
 mssfix 1492 mtu
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

The current default is 1450, which translates to 1478 byte packets for udp4
and 1498 byte packets for udp6. This commit changes the mssfix default
to take the outer IP overhead into account as well and changes the target to
1492. 1492 was picked in our community meeting for being a very common
encapsulation upper bound.

The change also disables an mssfix default if tun-mtu is set to a value
different than 1500.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/mtu.h     |  2 +-
 src/openvpn/options.c | 60 +++++++++++++++++++++++++++++--------------
 src/openvpn/options.h |  2 +-
 3 files changed, 43 insertions(+), 21 deletions(-)

diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index 7a6cdcb4..3a8faec1 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -77,7 +77,7 @@
 /*
  * Default MSSFIX value, used for reducing TCP MTU size
  */
-#define MSSFIX_DEFAULT     1450
+#define MSSFIX_DEFAULT     1492
 
 /*
  * Alignment of payload data such as IP packet or
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 705f7e0c..491edbe5 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -803,7 +803,9 @@ init_options(struct options *o, const bool init_gc)
     o->ce.tun_mtu = TUN_MTU_DEFAULT;
     o->ce.link_mtu = LINK_MTU_DEFAULT;
     o->ce.mtu_discover_type = -1;
-    o->ce.mssfix = MSSFIX_DEFAULT;
+    o->ce.mssfix = 0;
+    o->ce.mssfix_default = true;
+    o->ce.mssfix_encap = true;
     o->route_delay_window = 30;
     o->resolve_retry_seconds = RESOLV_RETRY_INFINITE;
     o->resolve_in_advance = false;
@@ -1511,6 +1513,7 @@ show_connection_entry(const struct connection_entry *o)
     SHOW_INT(fragment);
 #endif
     SHOW_INT(mssfix);
+    SHOW_BOOL(mssfix_encap);
 
     SHOW_INT(explicit_exit_notification);
 
@@ -2887,22 +2890,6 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
         ce->flags |= CE_DISABLED;
     }
 
-    /*
-     * If --mssfix is supplied without a parameter, default
-     * it to --fragment value, if --fragment is specified.
-     */
-    if (o->ce.mssfix_default)
-    {
-#ifdef ENABLE_FRAGMENT
-        if (ce->fragment)
-        {
-            ce->mssfix = ce->fragment;
-        }
-#else
-        msg(M_USAGE, "--mssfix must specify a parameter");
-#endif
-    }
-
     /* our socks code is not fully IPv6 enabled yet (TCP works, UDP not)
      * so fall back to IPv4-only (trac #1221)
      */
@@ -2936,6 +2923,36 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
         }
     }
 
+    /*
+     * If --mssfix is supplied without a parameter or not specified at all,
+     * default it to --fragment value, if --fragment is specified and otherwise
+     * to the default if tun-mtu is 1500
+     */
+    if (o->ce.mssfix_default)
+    {
+#ifdef ENABLE_FRAGMENT
+        if (ce->fragment)
+        {
+            ce->mssfix = ce->fragment;
+        }
+        else
+#endif
+        if (ce->tun_mtu_defined && o->ce.tun_mtu == TUN_MTU_DEFAULT)
+        {
+            /* We want to only set mssfix default value if we use a default
+             * MTU Size, otherwise the different size of tun should either
+             * already solve the problem or mssfix might artifically make the
+             * payload packets smaller without mssfix 0 */
+            ce->mssfix = MSSFIX_DEFAULT;
+            ce->mssfix_encap = true;
+        }
+        else
+        {
+            msg(D_MTU_INFO, "Note: not enabling mssfix for non-default value "
+                            "of --tun-mtu");
+        }
+    }
+
     /*
      * Set per-connection block tls-auth/crypt/crypto-v2 fields if undefined.
      *
@@ -6812,12 +6829,17 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
         if (p[1])
         {
+            /* value specified, assume encapsulation is not
+             * included unles "mtu" follows later */
             options->ce.mssfix = positive_atoi(p[1]);
+            options->ce.mssfix_encap = false;
+            options->ce.mssfix_default = false;
         }
-
-        if (!p[1])
+        else
         {
+            /* Set MTU to default values */
             options->ce.mssfix_default = true;
+            options->ce.mssfix_encap = true;
         }
 
         if (p[2] && streq(p[2], "mtu"))
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 13d6b0da..3d0f7fe7 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -126,7 +126,7 @@ struct connection_entry
 
     int fragment;        /* internal fragmentation size */
     int mssfix;          /* Upper bound on TCP MSS */
-    bool mssfix_default; /* true if --mssfix was supplied without a parameter */
+    bool mssfix_default; /* true if --mssfix should use the default parameters */
     bool mssfix_encap;   /* true if --mssfix had the "mtu" parameter to include
                           * overhead from IP and TCP/UDP encapsulation */
 
-- 
2.33.0


