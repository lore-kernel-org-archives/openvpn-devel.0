From: Fabian Knittel <fabian.knittel@...1338...>
Date: Wed, 31 Mar 2010 23:58:22 +0200
Message-Id: <b7fb4ac231ae574e5691add32e61284eaf607247.1270060247.git.fabian.knittel@...1338...>
In-Reply-To: <cover.1270060247.git.fabian.knittel@...1338...>
References: <cover.1270060247.git.fabian.knittel@...1338...>
Subject: [Openvpn-devel] [PATCH 9/9] vlan: add debug logging to broadcast
	filter
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

---
 multi.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/multi.c b/multi.c
index 661fd98..641d464 100644
--- a/multi.c
+++ b/multi.c
@@ -1806,7 +1806,21 @@ multi_bcast (struct multi_context *m,
 		}
 #endif
 	      if (vid != 0 && vid != mi->context.options.vlan_tag)
-		continue;
+		{
+		  struct gc_arena gc = gc_new ();
+		  msg (M_INFO, "VLAN: addr[%s]@%d -> client[%s]@%d packet dropped by BCAST VLAN filter",
+		      mroute_addr_print_ex (sender_addr, MAPF_SHOW_ARP, &gc),
+		      vid, mi_prefix (mi), mi->context.options.vlan_tag);
+		  gc_free (&gc);
+		  continue;
+		}
+		{
+		  struct gc_arena gc = gc_new ();
+		  msg (M_INFO, "BCAST: addr[%s]@%d -> client[%s]@%d",
+		      mroute_addr_print_ex (sender_addr, MAPF_SHOW_ARP, &gc),
+		      vid, mi_prefix (mi), mi->context.options.vlan_tag);
+		  gc_free (&gc);
+		}
 	      multi_add_mbuf (m, mi, mb);
 	    }
 	}
-- 
1.7.0


