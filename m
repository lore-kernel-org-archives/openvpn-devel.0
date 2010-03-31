From: Fabian Knittel <fabian.knittel@...1338...>
Date: Wed, 31 Mar 2010 23:58:19 +0200
Message-Id: <8e711dc8c01d8a2d70039cd5b2d2122d86afa01d.1270060247.git.fabian.knittel@...1338...>
In-Reply-To: <cover.1270060247.git.fabian.knittel@...1338...>
References: <cover.1270060247.git.fabian.knittel@...1338...>
Subject: [Openvpn-devel] [PATCH 6/9] vlan: Restrict broadcasts to the
	sender's VLAN.
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

This patch enhances openvpn's internal packet routing to restrict broadcast
packets to destinations with a matching VID.

I.e. broadcasts from client to client or from tap interface to clients are now
filtered based on whether the client belongs to the correct VLAN id.
---
 multi.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/multi.c b/multi.c
index 96644e5..822ae29 100644
--- a/multi.c
+++ b/multi.c
@@ -1759,7 +1759,8 @@ static void
 multi_bcast (struct multi_context *m,
 	     const struct buffer *buf,
 	     const struct multi_instance *sender_instance,
-	     const struct mroute_addr *sender_addr)
+	     const struct mroute_addr *sender_addr,
+	     int16_t vid)
 {
   struct hash_iterator hi;
   struct hash_element *he;
@@ -1804,6 +1805,8 @@ multi_bcast (struct multi_context *m,
 		    }
 		}
 #endif
+	      if (vid != 0 && vid != mi->context.options.vlan_tag)
+		continue;
 	      multi_add_mbuf (m, mi, mb);
 	    }
 	}
@@ -1997,7 +2000,7 @@ multi_process_incoming_link (struct multi_context *m, struct multi_instance *ins
 		  if (mroute_flags & MROUTE_EXTRACT_MCAST)
 		    {
 		      /* for now, treat multicast as broadcast */
-		      multi_bcast (m, &c->c2.to_tun, m->pending, NULL);
+		      multi_bcast (m, &c->c2.to_tun, m->pending, NULL, 0);
 		    }
 		  else /* possible client to client routing */
 		    {
@@ -2063,7 +2066,7 @@ multi_process_incoming_link (struct multi_context *m, struct multi_instance *ins
 			{
 			  if (mroute_flags & (MROUTE_EXTRACT_BCAST|MROUTE_EXTRACT_MCAST))
 			    {
-			      multi_bcast (m, &c->c2.to_tun, m->pending, NULL);
+			      multi_bcast (m, &c->c2.to_tun, m->pending, NULL, vid);
 			    }
 			  else /* try client-to-client routing */
 			    {
@@ -2258,9 +2261,9 @@ multi_process_incoming_tun (struct multi_context *m, const unsigned int mpp_flag
 	    {
 	      /* for now, treat multicast as broadcast */
 #ifdef ENABLE_PF
-	      multi_bcast (m, &m->top.c2.buf, NULL, e2);
+	      multi_bcast (m, &m->top.c2.buf, NULL, e2, vid);
 #else
-	      multi_bcast (m, &m->top.c2.buf, NULL, NULL);
+	      multi_bcast (m, &m->top.c2.buf, NULL, NULL, vid);
 #endif
 	    }
 	  else
@@ -2429,7 +2432,7 @@ gremlin_flood_clients (struct multi_context *m)
 	ASSERT (buf_write_u8 (&buf, get_random () & 0xFF));
 
       for (i = 0; i < parm.n_packets; ++i)
-	multi_bcast (m, &buf, NULL, NULL);
+	multi_bcast (m, &buf, NULL, NULL, 0);
 
       gc_free (&gc);
     }
-- 
1.7.0


