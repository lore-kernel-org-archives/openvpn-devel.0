From: Gert Doering <gert@...1296...>
Date: Fri,  7 Nov 2025 17:50:29 +0100
Message-ID: <20251107165038.26171-1-gert@...1296...>
In-Reply-To: <gerrit.1762292654000.Ife55cb78401dad921b75f6c86d9bd0642f6a6e83@...2715...>
References: <gerrit.1762292654000.Ife55cb78401dad921b75f6c86d9bd0642f6a6e83@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] dco_freebsd.c: add D_DCO_DEBUG messages
 for counters and notifications
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

Some of these debug messages only existed on Linux, and made debugging
DCO issues on FreeBSD more difficult.  Add them, using the same style as
used for dco_linux.c

While at it, change all format strings for "peerid" to "%u" (wherever
appropriate, dco->dco_message_peer_id is an "int" today and changing
this to uint32_t is out of scope for "make better logging")

Change-Id: Ife55cb78401dad921b75f6c86d9bd0642f6a6e83
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1349
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1349
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 3521fca..f80b6df 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -147,7 +147,7 @@
 
     nvl = nvlist_create(0);
 
-    msg(D_DCO_DEBUG, "%s: peer-id %d, fd %d", __func__, peerid, sd);
+    msg(D_DCO_DEBUG, "%s: peer-id %u, fd %d", __func__, peerid, sd);
 
     if (localaddr)
     {
@@ -363,7 +363,7 @@
     nvlist_t *nvl;
     int ret;
 
-    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peerid);
+    msg(D_DCO_DEBUG, "%s: peer-id %u", __func__, peerid);
 
     nvl = nvlist_create(0);
     nvlist_add_number(nvl, "peerid", peerid);
@@ -392,7 +392,7 @@
     nvlist_t *nvl;
     int ret;
 
-    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peerid);
+    msg(D_DCO_DEBUG, "%s: peer-id %u", __func__, peerid);
 
     nvl = nvlist_create(0);
     nvlist_add_number(nvl, "peerid", peerid);
@@ -421,7 +421,7 @@
     nvlist_t *nvl;
     int ret;
 
-    msg(D_DCO_DEBUG, "%s: peer-id %d, slot %d", __func__, peerid, slot);
+    msg(D_DCO_DEBUG, "%s: peer-id %u, slot %d", __func__, peerid, slot);
 
     nvl = nvlist_create(0);
     nvlist_add_number(nvl, "slot", slot);
@@ -493,7 +493,7 @@
     nvlist_t *nvl, *encrypt_nvl, *decrypt_nvl;
     int ret;
 
-    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s, epoch %d", __func__, slot, keyid, peerid,
+    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %u, cipher %s, epoch %d", __func__, slot, keyid, peerid,
         ciphername, epoch);
 
     nvl = nvlist_create(0);
@@ -539,7 +539,7 @@
     nvlist_t *nvl;
     int ret;
 
-    msg(D_DCO_DEBUG, "%s: peer-id %d, ping interval %d, ping timeout %d", __func__, peerid,
+    msg(D_DCO_DEBUG, "%s: peer-id %u, ping interval %d, ping timeout %d", __func__, peerid,
         keepalive_interval, keepalive_timeout);
 
     nvl = nvlist_create(0);
@@ -569,7 +569,7 @@
 {
     if (peerid >= m->max_clients || !m->instances[peerid])
     {
-        msg(M_WARN, "dco_update_peer_stat: invalid peer ID %d returned by kernel", peerid);
+        msg(M_WARN, "dco_update_peer_stat: invalid peer ID %u returned by kernel", peerid);
         return;
     }
 
@@ -577,6 +577,9 @@
 
     mi->context.c2.dco_read_bytes = nvlist_get_number(nvl, "in");
     mi->context.c2.dco_write_bytes = nvlist_get_number(nvl, "out");
+
+    msg(D_DCO_DEBUG, "%s: peer-id %u, dco_read_bytes: " counter_format " dco_write_bytes: " counter_format,
+        __func__, peerid, mi->context.c2.dco_read_bytes, mi->context.c2.dco_write_bytes);
 }
 
 int
@@ -614,6 +617,7 @@
     dco->dco_message_peer_id = nvlist_get_number(nvl, "peerid");
 
     type = nvlist_get_number(nvl, "notification");
+
     switch (type)
     {
         case OVPN_NOTIF_DEL_PEER:
@@ -631,6 +635,8 @@
                     dco->dco_del_peer_reason = OVPN_DEL_PEER_REASON_USERSPACE;
                 }
             }
+            msg(D_DCO_DEBUG, "%s: received NOTIF_DEL_PEER for peer-id=%d, reason=%d", __func__,
+                dco->dco_message_peer_id, dco->dco_del_peer_reason);
 
             if (nvlist_exists_nvlist(nvl, "bytes"))
             {
@@ -651,6 +657,8 @@
             break;
 
         case OVPN_NOTIF_ROTATE_KEY:
+            msg(D_DCO_DEBUG, "%s: received NOTIF_ROTATE_KEY for peer-id=%d", __func__,
+                dco->dco_message_peer_id);
             dco->dco_message_type = OVPN_CMD_SWAP_KEYS;
             break;
 
@@ -670,12 +678,14 @@
                 msg(M_WARN, "Failed to parse float notification");
                 break;
             }
+            msg(D_DCO_DEBUG, "%s: received NOTIF_FLOAT for peer-id=%d", __func__,
+                dco->dco_message_peer_id);
             dco->dco_message_type = OVPN_CMD_FLOAT_PEER;
             break;
         }
 
         default:
-            msg(M_WARN, "Unknown kernel notification %d", type);
+            msg(M_WARN, "%s: unknown kernel notification %d", __func__, type);
             break;
     }
 
@@ -815,6 +825,8 @@
         return 0;
     }
 
+    msg(D_DCO_DEBUG, __func__);
+
     CLEAR(drv);
     snprintf(drv.ifd_name, IFNAMSIZ, "%s", dco->ifname);
     drv.ifd_cmd = OVPN_GET_PEER_STATS;
@@ -873,6 +885,7 @@
 int
 dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err)
 {
+    msg(D_DCO_DEBUG, __func__);
     /* Not implemented. */
     return 0;
 }

