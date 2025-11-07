From: Gert Doering <gert@...1296...>
Date: Fri,  7 Nov 2025 18:48:05 +0100
Message-ID: <20251107174810.31851-1-gert@...1296...>
In-Reply-To: <gerrit.1762536182000.Ief19ba87b0832baa6530ea8bf039d85115434e3e@...2715...>
References: <gerrit.1762536182000.Ief19ba87b0832baa6530ea8bf039d85115434e3e@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] dco_freebsd.c: fix integer warnings
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

Fix all nvlist_get_number() related warnings by explicitly casting - these
are all messages coming from DCO, which we trust in this (nothing will
crash if a number is truncated, just "things will not work correctly").

Remove #pragmas.

Change-Id: Ief19ba87b0832baa6530ea8bf039d85115434e3e
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1361
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1361
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 21f0ac0..f2a89ac 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -72,11 +72,6 @@
     return (nvl);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static bool
 nvlist_to_sockaddr(const nvlist_t *nvl, struct sockaddr_storage *ss)
 {
@@ -93,7 +88,7 @@
         return (false);
     }
 
-    ss->ss_family = nvlist_get_number(nvl, "af");
+    ss->ss_family = (unsigned char)nvlist_get_number(nvl, "af");
 
     switch (ss->ss_family)
     {
@@ -107,7 +102,7 @@
             data = nvlist_get_binary(nvl, "address", &len);
             ASSERT(len == sizeof(in->sin_addr));
             memcpy(&in->sin_addr, data, sizeof(in->sin_addr));
-            in->sin_port = nvlist_get_number(nvl, "port");
+            in->sin_port = (in_port_t)nvlist_get_number(nvl, "port");
             break;
         }
 
@@ -121,11 +116,11 @@
             data = nvlist_get_binary(nvl, "address", &len);
             ASSERT(len == sizeof(in6->sin6_addr));
             memcpy(&in6->sin6_addr, data, sizeof(in6->sin6_addr));
-            in6->sin6_port = nvlist_get_number(nvl, "port");
+            in6->sin6_port = (in_port_t)nvlist_get_number(nvl, "port");
 
             if (nvlist_exists_number(nvl, "scopeid"))
             {
-                in6->sin6_scope_id = nvlist_get_number(nvl, "scopeid");
+                in6->sin6_scope_id = (uint32_t)nvlist_get_number(nvl, "scopeid");
             }
             break;
         }
@@ -614,9 +609,12 @@
         return -EINVAL;
     }
 
-    dco->dco_message_peer_id = nvlist_get_number(nvl, "peerid");
+    /* dco_message_peer_id is signed int, because other parts of the
+     * code treat "-1" as "this is a message not specific to one peer"
+     */
+    dco->dco_message_peer_id = (int)nvlist_get_number(nvl, "peerid");
 
-    type = nvlist_get_number(nvl, "notification");
+    type = (enum ovpn_notif_type)nvlist_get_number(nvl, "notification");
 
     switch (type)
     {
@@ -625,7 +623,7 @@
 
             if (nvlist_exists_number(nvl, "del_reason"))
             {
-                uint32_t reason = nvlist_get_number(nvl, "del_reason");
+                uint32_t reason = (uint32_t)nvlist_get_number(nvl, "del_reason");
                 if (reason == OVPN_DEL_REASON_TIMEOUT)
                 {
                     dco->dco_del_peer_reason = OVPN_DEL_PEER_REASON_EXPIRED;
@@ -869,7 +867,7 @@
     for (size_t i = 0; i < npeers; i++)
     {
         const nvlist_t *peer = nvpeers[i];
-        uint32_t peerid = nvlist_get_number(peer, "peerid");
+        uint32_t peerid = (uint32_t)nvlist_get_number(peer, "peerid");
         const nvlist_t *bytes = nvlist_get_nvlist(peer, "bytes");
 
         /* we can end here in p2mp mode, or in p2p mode via
@@ -890,10 +888,6 @@
     return 0;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /* get stats for a single peer
  * we can get here for "the peer stats" in p2p client mode, or by
  * being queried for a particular peer in p2mp mode, for --inactive

