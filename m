From: Lev Stipakov <lstipakov@...277...>
Date: Fri,  9 Oct 2015 15:29:17 +0300
Message-Id: <1444393757-21376-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Support for disabled peer-id
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

When peer-id value is 0xFFFFFF, server should ignore it and treat packet
in a same way as P_DATA_V1.

Make sure that issued peer-id does not exceed 0xFFFFFF.
---
 src/openvpn/mudp.c  | 15 ++++++++++++---
 src/openvpn/multi.c |  3 ++-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 57118f8..43b4f06 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -60,12 +60,16 @@ multi_get_create_instance_udp (struct multi_context *m, bool *floated)
       struct hash_bucket *bucket = hash_bucket (hash, hv);
       uint8_t* ptr = BPTR(&m->top.c2.buf);
       uint8_t op = ptr[0] >> P_OPCODE_SHIFT;
+      bool v2 = (op == P_DATA_V2) && (m->top.c2.buf.len >= (1 + 3));
+      bool peer_id_disabled = false;
 
       /* make sure buffer has enough length to read opcode (1 byte) and peer-id (3 bytes) */
-      if (op == P_DATA_V2 && m->top.c2.buf.len >= (1 + 3))
+      if (v2)
 	{
 	  uint32_t peer_id = ntohl(*(uint32_t*)ptr) & 0xFFFFFF;
-	  if ((peer_id < m->max_clients) && (m->instances[peer_id]))
+	  peer_id_disabled = peer_id == 0xFFFFFF;
+
+	  if (!peer_id_disabled && (peer_id < m->max_clients) && (m->instances[peer_id]))
 	    {
 	      mi = m->instances[peer_id];
 
@@ -80,7 +84,7 @@ multi_get_create_instance_udp (struct multi_context *m, bool *floated)
 	      }
 	    }
 	}
-      else
+      if (!v2 || peer_id_disabled)
 	{
 	  he = hash_lookup_fast (hash, bucket, &real, hv);
 	  if (he)
@@ -103,11 +107,16 @@ multi_get_create_instance_udp (struct multi_context *m, bool *floated)
 		      hash_add_fast (hash, bucket, &mi->real, hv, mi);
 		      mi->did_real_hash = true;
 
+		      /* TODO: support for disabled peer-id */
 		      for (i = 0; i < m->max_clients; ++i)
 			{
 			  if (!m->instances[i])
 			    {
+			      /* issued peer-id should fit into 3 bytes to avoid wrap and cannot have reserved value 0xFFFFFF */
+			      ASSERT(i < 0xFFFFFF);
+
 			      mi->context.c2.tls_multi->peer_id = i;
+
 			      m->instances[i] = mi;
 			      break;
 			    }
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 902c4dc..76f5a44 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -562,7 +562,8 @@ multi_close_instance (struct multi_context *m,
 	}
 #endif
 
-      m->instances[mi->context.c2.tls_multi->peer_id] = NULL;
+      if (mi->context.c2.tls_multi->peer_id != 0xFFFFFF)
+        m->instances[mi->context.c2.tls_multi->peer_id] = NULL;
 
       schedule_remove_entry (m->schedule, (struct schedule_entry *) mi);
 
-- 
1.9.1


