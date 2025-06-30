From: Gert Doering <gert@...1296...>
Date: Mon, 30 Jun 2025 18:42:01 +0200
Message-ID: <20250630164207.10477-1-gert@...1296...>
In-Reply-To: <gerrit.1751292607000.I3bed9c7aafee8e62ddae14c0d3e21cf4c146a37c@...2715...>
References: <gerrit.1751292607000.I3bed9c7aafee8e62ddae14c0d3e21cf4c146a37c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] packet_id: Fix build with --disable-debug
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

Broken since commit
bc62a9a02cb7365a678bcd3f2faf537a420cc5a0
"Add methods to read/write packet ids for epoch data"

Change-Id: I3bed9c7aafee8e62ddae14c0d3e21cf4c146a37c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1071
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index c8dae32..76a81c6 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -673,6 +673,8 @@
     gc_free(&gc);
 }
 
+#endif /* ifdef ENABLE_DEBUG */
+
 uint16_t
 packet_id_read_epoch(struct packet_id_net *pin, struct buffer *buf)
 {
@@ -711,6 +713,3 @@
 
     return buf_write(buf, &net_id, sizeof(net_id));
 }
-
-
-#endif /* ifdef ENABLE_DEBUG */

