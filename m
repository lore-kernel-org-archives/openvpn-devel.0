From: Antonio Quartulli <a@...2181...>
Date: Fri, 24 Jun 2022 10:37:54 +0200
Message-Id: <20220624083809.23487-11-a@...2181...>
In-Reply-To: <20220624083809.23487-1-a@...2181...>
References: <20220624083809.23487-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 10/25] dco: periodically check and possibly
 rotate/delete keys
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
Cc: Antonio Quartulli <a@...2181...>

Data channel keys are periodically regenarated and installed in
ovpn-dco.
However, there is a certain moment when keys are rotated in order
to elect the new primary one.

Check the key status in userspace so that kernelspace can be informed as
well when rotations happen.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/dco.c     | 97 +++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/dco.h     | 14 +++++++
 src/openvpn/forward.c | 19 +++++++++
 3 files changed, 130 insertions(+)

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index e38614fa..473eb564 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -92,6 +92,103 @@ init_key_dco_bi(struct tls_multi *multi, struct key_state *ks,
                            ciphername);
 }
 
+/**
+ * Find a usable key that is not the primary (i.e. the secondary key)
+ *
+ * @param multi     The TLS struct to retrieve keys from
+ * @param primary   The primary key that should be skipped during the scan
+ *
+ * @return          The secondary key or NULL if none could be found
+ */
+static struct key_state *
+dco_get_secondary_key(struct tls_multi *multi, const struct key_state *primary)
+{
+    for (int i = 0; i < KEY_SCAN_SIZE; ++i)
+    {
+        struct key_state *ks = get_key_scan(multi, i);
+        struct key_ctx_bi *key = &ks->crypto_options.key_ctx_bi;
+
+        if (ks == primary)
+        {
+            continue;
+        }
+
+        if (ks->state >= S_GENERATED_KEYS && ks->authenticated == KS_AUTH_TRUE)
+        {
+            ASSERT(key->initialized);
+            return ks;
+        }
+    }
+
+    return NULL;
+}
+
+void
+dco_update_keys(dco_context_t *dco, struct tls_multi *multi)
+{
+    msg(D_DCO_DEBUG, "%s: peer_id=%d", __func__, multi->peer_id);
+
+    /* this function checks if keys have to be swapped or erased, therefore it
+     * can't do much if we don't have any key installed
+     */
+    if (multi->dco_keys_installed == 0)
+    {
+        return;
+    }
+
+    struct key_state *primary = tls_select_encryption_key(multi);
+    ASSERT(!primary || primary->dco_status != DCO_NOT_INSTALLED);
+
+    /* no primary key available -> no usable key exists, therefore we should
+     * tell DCO to simply wipe all keys
+     */
+    if (!primary)
+    {
+        msg(D_DCO, "No encryption key found. Purging data channel keys");
+
+        dco_del_key(dco, multi->peer_id, OVPN_KEY_SLOT_PRIMARY);
+        dco_del_key(dco, multi->peer_id, OVPN_KEY_SLOT_SECONDARY);
+        multi->dco_keys_installed = 0;
+        return;
+    }
+
+    struct key_state *secondary = dco_get_secondary_key(multi, primary);
+    ASSERT(!secondary || secondary->dco_status != DCO_NOT_INSTALLED);
+
+    /* the current primary key was installed as secondary in DCO, this means
+     * that userspace has promoted it and we should tell DCO to swap keys
+     */
+    if (primary->dco_status == DCO_INSTALLED_SECONDARY)
+    {
+        msg(D_DCO_DEBUG, "Swapping primary and secondary keys, now: id1=%d id2=%d",
+            primary->key_id, secondary ? secondary->key_id : -1);
+
+        dco_swap_keys(dco, multi->peer_id);
+        primary->dco_status = DCO_INSTALLED_PRIMARY;
+        if (secondary)
+        {
+            secondary->dco_status = DCO_INSTALLED_SECONDARY;
+        }
+    }
+
+    /* if we have no secondary key anymore, inform DCO about it */
+    if (!secondary && multi->dco_keys_installed == 2)
+    {
+        dco_del_key(dco, multi->peer_id, OVPN_KEY_SLOT_SECONDARY);
+        multi->dco_keys_installed = 1;
+    }
+
+    /* all keys that are not installed are set to NOT installed */
+    for (int i = 0; i < KEY_SCAN_SIZE; ++i)
+    {
+        struct key_state *ks = get_key_scan(multi, i);
+        if (ks != primary && ks != secondary)
+        {
+            ks->dco_status = DCO_NOT_INSTALLED;
+        }
+    }
+}
+
 static bool
 dco_check_option_conflict_ce(const struct connection_entry *ce, int msglevel)
 {
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index b081c6fa..cb7f7e4f 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -130,6 +130,14 @@ int init_key_dco_bi(struct tls_multi *multi, struct key_state *ks,
                     const struct key2 *key2, int key_direction,
                     const char *ciphername, bool server);
 
+/**
+ * Possibly swap or wipe keys from DCO
+ *
+ * @param dco           DCO device context
+ * @param multi         TLS multi instance
+ */
+void dco_update_keys(dco_context_t *dco, struct tls_multi *multi);
+
 #else /* if defined(ENABLE_DCO) */
 
 typedef void *dco_context_t;
@@ -190,5 +198,11 @@ init_key_dco_bi(struct tls_multi *multi, struct key_state *ks,
     return 0;
 }
 
+static inline void
+dco_update_keys(dco_context_t *dco, struct tls_multi *multi)
+{
+    ASSERT(false);
+}
+
 #endif /* defined(ENABLE_DCO) */
 #endif /* ifndef DCO_H */
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 6afe152b..99898e01 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -41,6 +41,7 @@
 #include "dhcp.h"
 #include "common.h"
 #include "ssl_verify.h"
+#include "dco.h"
 
 #include "memdbg.h"
 
@@ -140,6 +141,18 @@ context_reschedule_sec(struct context *c, int sec)
     }
 }
 
+void
+check_dco_key_status(struct context *c)
+{
+    /* DCO context is not yet initialised or enabled */
+    if (!dco_enabled(&c->options))
+    {
+        return;
+    }
+
+    dco_update_keys(&c->c1.tuntap->dco, c->c2.tls_multi);
+}
+
 /*
  * In TLS mode, let TLS level respond to any control-channel
  * packets which were received, or prepare any packets for
@@ -182,6 +195,12 @@ check_tls(struct context *c)
 
     interval_schedule_wakeup(&c->c2.tmp_int, &wakeup);
 
+    /* Our current code has no good hooks in the TLS machinery to update
+     * DCO keys. So we check the key status after the whole TLS machinery
+     * has been completed and potentially update them
+     */
+    check_dco_key_status(c);
+
     if (wakeup)
     {
         context_reschedule_sec(c, wakeup);
-- 
2.35.1


