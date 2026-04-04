From: Gert Doering <gert@...1296...>
Date: Sat,  4 Apr 2026 22:33:30 +0200
Message-ID: <20260404203335.30650-1-gert@...1296...>
In-Reply-To: <gerrit.1775328983000.I04a01cf536ee6d48d54ba623dda460c4a98859f9@...2715...>
References: <gerrit.1775328983000.I04a01cf536ee6d48d54ba623dda460c4a98859f9@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] mtcp: Remove noop statement in
 multi_tcp_process_outgoing_link_ready
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

From: Frank Lichtenheld <frank@...2641...>

Assigning to a parameter here has no effect. I can see no
obvious alternative statement that might have been intended.

Found by cppcheck.

Change-Id: I04a01cf536ee6d48d54ba623dda460c4a98859f9
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1609
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1609
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 2eab7b7..7651b4d 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -155,10 +155,6 @@
         ASSERT(mi == item.instance);
         mi->context.c2.to_link = item.buffer->buf;
         ret = multi_process_outgoing_link_dowork(m, mi, mpp_flags);
-        if (!ret)
-        {
-            mi = NULL;
-        }
         mbuf_free_buf(item.buffer);
     }
     return ret;

