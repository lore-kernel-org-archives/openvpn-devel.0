From: Lev Stipakov <lstipakov@...277...>
Date: Fri,  6 Feb 2015 14:38:00 +0200
Message-Id: <1423226280-9580-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Fix NULL dereferencing
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

In certain cases buf.len can be -1, which causes BPTR to return NULL and
NULL pointer dereferencing on the next line.

As a fix, process only packets with non-zero length.
---
 src/openvpn/mudp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 3e3f750..57118f8 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -52,20 +52,19 @@ multi_get_create_instance_udp (struct multi_context *m, bool *floated)
   struct multi_instance *mi = NULL;
   struct hash *hash = m->hash;
 
-  if (mroute_extract_openvpn_sockaddr (&real, &m->top.c2.from.dest, true))
+  if (mroute_extract_openvpn_sockaddr (&real, &m->top.c2.from.dest, true) &&
+      m->top.c2.buf.len > 0)
     {
       struct hash_element *he;
       const uint32_t hv = hash_value (hash, &real);
       struct hash_bucket *bucket = hash_bucket (hash, hv);
       uint8_t* ptr = BPTR(&m->top.c2.buf);
       uint8_t op = ptr[0] >> P_OPCODE_SHIFT;
-      uint32_t peer_id;
-      int i;
 
       /* make sure buffer has enough length to read opcode (1 byte) and peer-id (3 bytes) */
       if (op == P_DATA_V2 && m->top.c2.buf.len >= (1 + 3))
 	{
-	  peer_id = ntohl(*(uint32_t*)ptr) & 0xFFFFFF;
+	  uint32_t peer_id = ntohl(*(uint32_t*)ptr) & 0xFFFFFF;
 	  if ((peer_id < m->max_clients) && (m->instances[peer_id]))
 	    {
 	      mi = m->instances[peer_id];
@@ -99,6 +98,8 @@ multi_get_create_instance_udp (struct multi_context *m, bool *floated)
 		  mi = multi_create_instance (m, &real);
 		  if (mi)
 		    {
+		      int i;
+
 		      hash_add_fast (hash, bucket, &mi->real, hv, mi);
 		      mi->did_real_hash = true;
 
-- 
1.9.1


