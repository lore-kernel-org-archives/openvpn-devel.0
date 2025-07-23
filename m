From: Kristof Provost <kprovost@...2661...>
Date: Wed, 23 Jul 2025 10:36:49 +0200
Message-ID: <20250723083816.71604-2-kprovost@...2661...>
In-Reply-To: <20250723083816.71604-1-kprovost@...2661...>
References: <20250723083816.71604-1-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] dco: support float notifications on FreeBSD
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

Signed-off-by: Kristof Provost <kprovost@...2661...>
---
 configure.ac                   |  9 +++++
 src/openvpn/dco_freebsd.c      | 68 ++++++++++++++++++++++++++++++++++
 src/openvpn/dco_freebsd.h      |  2 +
 src/openvpn/multi.c            |  2 +-
 src/openvpn/ovpn_dco_freebsd.h |  1 +
 5 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 66cb79b1..50697b8e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -848,6 +848,15 @@ if test "$enable_dco" != "no"; then
 				else
 					AC_MSG_ERROR([DCO support can't be enabled])
 				fi
+			else
+				AC_CHECK_DECLS(
+					[OVPN_NOTIF_FLOAT],
+					[AC_DEFINE([ENABLE_DCO_FLOAT_FREEBSD], [1], [We have DCO float notifications on FreeBSD])],
+					,
+					[[
+						#include <net/if_ovpn.h>
+					]]
+				)
 			fi
 			;;
 		*-mingw*)
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index b8816c63..b0cab389 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -72,6 +72,55 @@ sockaddr_to_nvlist(const struct sockaddr *sa)
     return (nvl);
 }
 
+#ifdef ENABLE_DCO_FLOAT_FREEBSD
+static bool
+nvlist_to_sockaddr(const nvlist_t *nvl, struct sockaddr_storage *ss)
+{
+    if (! nvlist_exists_number(nvl, "af"))
+        return (false);
+    if (! nvlist_exists_binary(nvl, "address"))
+        return (false);
+    if (! nvlist_exists_number(nvl, "port"))
+        return (false);
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
+        default:
+            return (false);
+    }
+
+    return (true);
+}
+#endif
+
 int
 dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
              struct sockaddr *localaddr, struct sockaddr *remoteaddr,
@@ -571,6 +620,25 @@ dco_do_read(dco_context_t *dco)
             dco->dco_message_type = OVPN_CMD_SWAP_KEYS;
             break;
 
+#ifdef ENABLE_DCO_FLOAT_FREEBSD
+        case OVPN_NOTIF_FLOAT: {
+            const nvlist_t *address;
+
+            if (! nvlist_exists_nvlist(nvl, "address")) {
+                msg(M_WARN, "Float notification without address");
+                break;
+            }
+
+            address = nvlist_get_nvlist(nvl, "address");
+            if (! nvlist_to_sockaddr(address, &dco->dco_float_peer_ss)) {
+                msg(M_WARN, "Failed to parse float notification");
+                break;
+            }
+            dco->dco_message_type = OVPN_CMD_FLOAT_PEER;
+            break;
+        }
+#endif
+
         default:
             msg(M_WARN, "Unknown kernel notification %d", type);
             break;
diff --git a/src/openvpn/dco_freebsd.h b/src/openvpn/dco_freebsd.h
index e1a054e0..ab5891e8 100644
--- a/src/openvpn/dco_freebsd.h
+++ b/src/openvpn/dco_freebsd.h
@@ -36,6 +36,7 @@ enum ovpn_message_type_t {
     OVPN_CMD_DEL_PEER,
     OVPN_CMD_PACKET,
     OVPN_CMD_SWAP_KEYS,
+    OVPN_CMD_FLOAT_PEER,
 };
 
 enum ovpn_del_reason_t {
@@ -55,6 +56,7 @@ typedef struct dco_context {
     int dco_message_type;
     int dco_message_peer_id;
     int dco_del_peer_reason;
+    struct sockaddr_storage dco_float_peer_ss;
     uint64_t dco_read_bytes;
     uint64_t dco_write_bytes;
 } dco_context_t;
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 46966863..8e712e44 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3400,7 +3400,7 @@ multi_process_incoming_dco(struct multi_context *m)
         {
             process_incoming_del_peer(m, mi, dco);
         }
-#if defined(TARGET_LINUX) || defined(TARGET_WIN32)
+#if defined(TARGET_LINUX) || defined(TARGET_WIN32) || defined(TARGET_FREEBSD)
         else if (dco->dco_message_type == OVPN_CMD_FLOAT_PEER)
         {
             ASSERT(mi->context.c2.link_sockets[0]);
diff --git a/src/openvpn/ovpn_dco_freebsd.h b/src/openvpn/ovpn_dco_freebsd.h
index 53f94dfd..7eb643b4 100644
--- a/src/openvpn/ovpn_dco_freebsd.h
+++ b/src/openvpn/ovpn_dco_freebsd.h
@@ -37,6 +37,7 @@
 enum ovpn_notif_type {
     OVPN_NOTIF_DEL_PEER,
     OVPN_NOTIF_ROTATE_KEY,
+    OVPN_NOTIF_FLOAT,
 };
 
 enum ovpn_del_reason {
-- 
2.50.1


