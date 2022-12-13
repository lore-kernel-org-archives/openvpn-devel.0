From: Arne Schwabe <arne@...1227...>
Date: Tue, 13 Dec 2022 23:54:29 +0100
Message-Id: <20221213225430.1892940-2-arne@...1227...>
In-Reply-To: <20221213225430.1892940-1-arne@...1227...>
References: <20221213225430.1892940-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/3] Trigger a USR1 if dco_update_keys fails
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

When dco_update_keys fails, we are in some weird state that we are
unlikely to recover since what userspace and kernel space think of
the keys is very likely to not in sync anymore. So abandon the
connection if this happens.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/dco.c     | 15 ++++++++-------
 src/openvpn/dco.h     |  9 ++++++---
 src/openvpn/forward.c |  7 ++++++-
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 2396bcbf0..36bfbf10a 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -130,7 +130,7 @@ dco_get_secondary_key(struct tls_multi *multi, const struct key_state *primary)
     return NULL;
 }
 
-void
+bool
 dco_update_keys(dco_context_t *dco, struct tls_multi *multi)
 {
     msg(D_DCO_DEBUG, "%s: peer_id=%d", __func__, multi->dco_peer_id);
@@ -140,7 +140,7 @@ dco_update_keys(dco_context_t *dco, struct tls_multi *multi)
      */
     if (multi->dco_keys_installed == 0)
     {
-        return;
+        return true;
     }
 
     struct key_state *primary = tls_select_encryption_key(multi);
@@ -155,18 +155,18 @@ dco_update_keys(dco_context_t *dco, struct tls_multi *multi)
         if (ret < 0)
         {
             msg(D_DCO, "Cannot delete primary key during wipe: %s (%d)", strerror(-ret), ret);
-            return;
+            return false;
         }
 
         ret = dco_del_key(dco, multi->dco_peer_id, OVPN_KEY_SLOT_SECONDARY);
         if (ret < 0)
         {
             msg(D_DCO, "Cannot delete secondary key during wipe: %s (%d)", strerror(-ret), ret);
-            return;
+            return false;
         }
 
         multi->dco_keys_installed = 0;
-        return;
+        return true;
     }
 
     /* if we have a primary key, it must have been installed already (keys
@@ -198,7 +198,7 @@ dco_update_keys(dco_context_t *dco, struct tls_multi *multi)
         if (ret < 0)
         {
             msg(D_DCO, "Cannot swap keys: %s (%d)", strerror(-ret), ret);
-            return;
+            return false;
         }
 
         primary->dco_status = DCO_INSTALLED_PRIMARY;
@@ -216,7 +216,7 @@ dco_update_keys(dco_context_t *dco, struct tls_multi *multi)
         if (ret < 0)
         {
             msg(D_DCO, "Cannot delete secondary key: %s (%d)", strerror(-ret), ret);
-            return;
+            return false;
         }
         multi->dco_keys_installed = 1;
     }
@@ -230,6 +230,7 @@ dco_update_keys(dco_context_t *dco, struct tls_multi *multi)
             ks->dco_status = DCO_NOT_INSTALLED;
         }
     }
+    return true;
 }
 
 static bool
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index e051db068..7e1febaa3 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -164,9 +164,11 @@ int init_key_dco_bi(struct tls_multi *multi, struct key_state *ks,
  *
  * @param dco           DCO device context
  * @param multi         TLS multi instance
+ *
+ * @return              returns false if an error occurred that is not
+ *                      recoverable and should reset the connection
  */
-void dco_update_keys(dco_context_t *dco, struct tls_multi *multi);
-
+bool dco_update_keys(dco_context_t *dco, struct tls_multi *multi);
 /**
  * Install a new peer in DCO - to be called by a CLIENT (or P2P) instance
  *
@@ -304,10 +306,11 @@ init_key_dco_bi(struct tls_multi *multi, struct key_state *ks,
     return 0;
 }
 
-static inline void
+static inline bool
 dco_update_keys(dco_context_t *dco, struct tls_multi *multi)
 {
     ASSERT(false);
+    return false;
 }
 
 static inline int
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 5cd7eaa6e..8c1e49a34 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -151,7 +151,12 @@ check_dco_key_status(struct context *c)
         return;
     }
 
-    dco_update_keys(&c->c1.tuntap->dco, c->c2.tls_multi);
+    if (!dco_update_keys(&c->c1.tuntap->dco, c->c2.tls_multi))
+    {
+        /* Something bad happened. Kill the connection to
+         * be able to recover. */
+        register_signal(c, SIGUSR1, "dco update keys error");
+    }
 }
 
 /*
-- 
2.37.1 (Apple Git-137.1)


