From: Gert Doering <gert@...1296...>
Date: Mon,  8 Sep 2025 10:33:49 +0200
Message-ID: <20250908083354.19811-1-gert@...1296...>
In-Reply-To: <gerrit.1757094927000.I53e6d1b31c4f673cb646716dce774ef3210f36bd@...2715...>
References: <gerrit.1757094927000.I53e6d1b31c4f673cb646716dce774ef3210f36bd@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] dco: support float notifications on
 FreeBSD
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

From: Kristof Provost <kp@...1376...>

this is a backport of commit b66b80b2ab and 796ad2c559
(squashed, as the second commit undoes quite a bit of #ifdef from the first)

Change-Id: I53e6d1b31c4f673cb646716dce774ef3210f36bd
Signed-off-by: Kristof Provost <kprovost@...2661...>
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Ralf Lici <ralf@...2726...>
(cherry picked from commit b66b80b2ab73bb422826911b675798e6b789ef03)
(cherry picked from commit 796ad2c55951635382e48ea5b71d13bbb83ebfb1)
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1170
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Ralf Lici <ralf@...2726...>

        
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index ed7ea92..25532d4 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -72,6 +72,61 @@
     return (nvl);
 }
 
+static bool
+nvlist_to_sockaddr(const nvlist_t *nvl, struct sockaddr_storage *ss)
+{
+    if (!nvlist_exists_number(nvl, "af"))
+    {
+        return (false);
+    }
+    if (!nvlist_exists_binary(nvl, "address"))
+    {
+        return (false);
+    }
+    if (!nvlist_exists_number(nvl, "port"))
+    {
+        return (false);
+    }
+
+    ss->ss_family = nvlist_get_number(nvl, "af");
+
+    switch (ss->ss_family)
+    {
+        case AF_INET:
+        {
+            struct sockaddr_in *in = (struct sockaddr_in *)ss;
+            const void *data;
+            size_t len;
+
+            in->sin_len = sizeof(*in);
+            data = nvlist_get_binary(nvl, "address", &len);
+            assert(len == sizeof(in->sin_addr));
+            memcpy(&in->sin_addr, data, sizeof(in->sin_addr));
+            in->sin_port = nvlist_get_number(nvl, "port");
+            break;
+        }
+
+        case AF_INET6:
+        {
+            struct sockaddr_in6 *in6 = (struct sockaddr_in6 *)ss;
+            const void *data;
+            size_t len;
+
+            in6->sin6_len = sizeof(*in6);
+            data = nvlist_get_binary(nvl, "address", &len);
+            assert(len == sizeof(in6->sin6_addr));
+            memcpy(&in6->sin6_addr, data, sizeof(in6->sin6_addr));
+            in6->sin6_port = nvlist_get_number(nvl, "port");
+            break;
+        }
+
+        default:
+            return (false);
+    }
+
+    return (true);
+}
+
 int
 dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
              struct sockaddr *localaddr, struct sockaddr *remoteaddr,
@@ -571,6 +626,25 @@
             dco->dco_message_type = OVPN_CMD_SWAP_KEYS;
             break;
 
+        case OVPN_NOTIF_FLOAT: {
+            const nvlist_t *address;
+
+            if (!nvlist_exists_nvlist(nvl, "address"))
+            {
+                msg(M_WARN, "Float notification without address");
+                break;
+            }
+
+            address = nvlist_get_nvlist(nvl, "address");
+            if (!nvlist_to_sockaddr(address, &dco->dco_float_peer_ss))
+            {
+                msg(M_WARN, "Failed to parse float notification");
+                break;
+            }
+            dco->dco_message_type = OVPN_CMD_FLOAT_PEER;
+            break;
+        }
+
         default:
             msg(M_WARN, "Unknown kernel notification %d", type);
             break;
diff --git a/src/openvpn/dco_freebsd.h b/src/openvpn/dco_freebsd.h
index e1a054e..ab5891e 100644
--- a/src/openvpn/dco_freebsd.h
+++ b/src/openvpn/dco_freebsd.h
@@ -36,6 +36,7 @@
     OVPN_CMD_DEL_PEER,
     OVPN_CMD_PACKET,
     OVPN_CMD_SWAP_KEYS,
+    OVPN_CMD_FLOAT_PEER,
 };
 
 enum ovpn_del_reason_t {
@@ -55,6 +56,7 @@
     int dco_message_type;
     int dco_message_peer_id;
     int dco_del_peer_reason;
+    struct sockaddr_storage dco_float_peer_ss;
     uint64_t dco_read_bytes;
     uint64_t dco_write_bytes;
 } dco_context_t;
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index eb5f932..310211c 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3313,7 +3313,7 @@
         {
             process_incoming_del_peer(m, mi, dco);
         }
-#if 0
+#if defined(TARGET_FREEBSD)
         else if (dco->dco_message_type == OVPN_CMD_FLOAT_PEER)
         {
             ASSERT(mi->context.c2.link_socket);
diff --git a/src/openvpn/ovpn_dco_freebsd.h b/src/openvpn/ovpn_dco_freebsd.h
index 53f94df..7eb643b 100644
--- a/src/openvpn/ovpn_dco_freebsd.h
+++ b/src/openvpn/ovpn_dco_freebsd.h
@@ -37,6 +37,7 @@
 enum ovpn_notif_type {
     OVPN_NOTIF_DEL_PEER,
     OVPN_NOTIF_ROTATE_KEY,
+    OVPN_NOTIF_FLOAT,
 };
 
 enum ovpn_del_reason {

