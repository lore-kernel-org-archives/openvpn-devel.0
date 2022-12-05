From: Kristof Provost <kprovost@...2661...>
Date: Mon,  5 Dec 2022 17:41:01 +0100
Message-Id: <20221205164103.9190-3-kprovost@...2661...>
In-Reply-To: <20221205164103.9190-1-kprovost@...2661...>
References: <20221205164103.9190-1-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/4] dco: Update counters when a client
 disconnects
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

From: Kristof Provost <kp@...1376...>

When the kernel module (Linux or FreeBSD) notifies us that a peer has
disconnected we'd like to get a final count of the in/out bytes for that
peer.
We can't request that information any more, because the kernel has
already removed the peer at that point.

Have the kernel send that information as part of the "delete peer"
notification, and update the counters a final time.

This implements the FreeBSD-specific DCO code, but not the
Linux-specific code. It will simply add 0 to the count on Linux.

Signed-off-by: Kristof Provost <kprovost@...2661...>
---
 src/openvpn/dco_freebsd.c | 9 +++++++++
 src/openvpn/dco_freebsd.h | 2 ++
 src/openvpn/dco_linux.h   | 2 ++
 src/openvpn/multi.c       | 4 ++++
 4 files changed, 17 insertions(+)

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 5b352859..2ae46589 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -528,6 +528,15 @@ dco_do_read(dco_context_t *dco)
     else
     {
         dco->dco_del_peer_reason = OVPN_DEL_PEER_REASON_EXPIRED;
+
+        if (nvlist_exists_nvlist(nvl, "bytes"))
+        {
+            const nvlist_t *bytes = nvlist_get_nvlist(nvl, "bytes");
+
+            dco->dco_read_bytes = nvlist_get_number(bytes, "in");
+            dco->dco_write_bytes = nvlist_get_number(bytes, "out");
+        }
+
         dco->dco_message_type = OVPN_CMD_DEL_PEER;
     }
 
diff --git a/src/openvpn/dco_freebsd.h b/src/openvpn/dco_freebsd.h
index 7de11697..0d059dda 100644
--- a/src/openvpn/dco_freebsd.h
+++ b/src/openvpn/dco_freebsd.h
@@ -55,6 +55,8 @@ typedef struct dco_context {
     int dco_message_type;
     int dco_message_peer_id;
     int dco_del_peer_reason;
+    uint64_t dco_read_bytes;
+    uint64_t dco_write_bytes;
 } dco_context_t;
 
 #endif /* defined(ENABLE_DCO) && defined(TARGET_FREEBSD) */
diff --git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h
index 416ea30a..7d56308b 100644
--- a/src/openvpn/dco_linux.h
+++ b/src/openvpn/dco_linux.h
@@ -53,6 +53,8 @@ typedef struct
     int dco_message_type;
     int dco_message_peer_id;
     int dco_del_peer_reason;
+    uint64_t dco_read_bytes;
+    uint64_t dco_write_bytes;
 } dco_context_t;
 
 #endif /* defined(ENABLE_DCO) && defined(TARGET_LINUX) */
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 38da87b8..74671303 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3245,6 +3245,8 @@ process_incoming_del_peer(struct multi_context *m, struct multi_instance *mi,
      * installed, and we do not need to clean up the state in the kernel */
     mi->context.c2.tls_multi->dco_peer_id = -1;
     mi->context.sig->signal_text = reason;
+    mi->context.c2.dco_read_bytes = dco->dco_read_bytes;
+    mi->context.c2.dco_write_bytes = dco->dco_write_bytes;
     multi_signal_instance(m, mi, SIGTERM);
 }
 
@@ -3278,6 +3280,8 @@ multi_process_incoming_dco(struct multi_context *m)
 
     dco->dco_message_type = 0;
     dco->dco_message_peer_id = -1;
+    dco->dco_read_bytes = 0;
+    dco->dco_write_bytes = 0;
     return ret > 0;
 }
 #endif /* if defined(ENABLE_DCO) && defined(TARGET_LINUX) */
-- 
2.38.1


