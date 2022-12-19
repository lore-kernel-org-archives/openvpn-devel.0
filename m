From: Arne Schwabe <arne@...1227...>
Date: Mon, 19 Dec 2022 18:40:27 +0100
Message-Id: <20221219174027.2567505-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Ensure that dco keepalive and mssfix
 options are also set in pure p2p mode
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/dco_freebsd.c |  3 +++
 src/openvpn/init.c        | 42 ++++++++++++++++++++++++---------------
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 7f5e69e3e..cd4083c49 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -461,6 +461,9 @@ dco_set_peer(dco_context_t *dco, unsigned int peerid,
     nvlist_t *nvl;
     int ret;
 
+    msg(D_DCO_DEBUG, "%s: peer-id %d, ping interval %d, ping timeout %d",
+        __func__, peerid, keepalive_interval, keepalive_timeout);
+
     nvl = nvlist_create(0);
     nvlist_add_number(nvl, "peerid", peerid);
     nvlist_add_number(nvl, "interval", keepalive_interval);
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 88f0747f9..71d0804fa 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2119,6 +2119,26 @@ options_hash_changed_or_zero(const struct sha256_digest *a,
            || !memcmp(a, &zero, sizeof(struct sha256_digest));
 }
 
+static bool
+p2p_set_dco_keepalive(struct context *c)
+{
+    if (dco_enabled(&c->options)
+        && (c->options.ping_send_timeout || c->c2.frame.mss_fix))
+    {
+        int ret = dco_set_peer(&c->c1.tuntap->dco,
+                               c->c2.tls_multi->dco_peer_id,
+                               c->options.ping_send_timeout,
+                               c->options.ping_rec_timeout,
+                               c->c2.frame.mss_fix);
+        if (ret < 0)
+        {
+            msg(D_DCO, "Cannot set parameters for DCO peer (id=%u): %s",
+                c->c2.tls_multi->dco_peer_id, strerror(-ret));
+            return false;
+        }
+    }
+    return true;
+}
 /**
  * This function is expected to be invoked after open_tun() was performed.
  *
@@ -2147,22 +2167,6 @@ do_deferred_options_part2(struct context *c)
         return false;
     }
 
-    if (dco_enabled(&c->options)
-        && (c->options.ping_send_timeout || c->c2.frame.mss_fix))
-    {
-        int ret = dco_set_peer(&c->c1.tuntap->dco,
-                               c->c2.tls_multi->dco_peer_id,
-                               c->options.ping_send_timeout,
-                               c->options.ping_rec_timeout,
-                               c->c2.frame.mss_fix);
-        if (ret < 0)
-        {
-            msg(D_DCO, "Cannot set parameters for DCO peer (id=%u): %s",
-                c->c2.tls_multi->dco_peer_id, strerror(-ret));
-            return false;
-        }
-    }
-
     return true;
 }
 
@@ -2265,6 +2269,12 @@ do_up(struct context *c, bool pulled_options, unsigned int option_types_found)
             }
         }
 
+        if (c->mode == MODE_POINT_TO_POINT && !p2p_set_dco_keepalive(c))
+        {
+            msg(D_TLS_ERRORS, "ERROR: Failed to apply DCO keepalive or MSS fix parameters");
+            return false;
+        }
+
         if (c->c2.did_open_tun)
         {
             c->c1.pulled_options_digest_save = c->c2.pulled_options_digest;
-- 
2.37.1 (Apple Git-137.1)


