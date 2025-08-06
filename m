From: Gert Doering <gert@...1296...>
Date: Wed,  6 Aug 2025 16:42:31 +0200
Message-ID: <20250806144238.11332-1-gert@...1296...>
In-Reply-To: <gerrit.1754490554000.I71981e39932cafe3fd68b475fdb81a8f20a3a547@...2715...>
References: <gerrit.1754490554000.I71981e39932cafe3fd68b475fdb81a8f20a3a547@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] buffer: remove unused function
 buf_write_alloc_prepend
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

Change-Id: I71981e39932cafe3fd68b475fdb81a8f20a3a547
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1134
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 8d6bb64..6f15115 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -644,12 +644,6 @@
 }
 
 static inline uint8_t *
-buf_write_alloc_prepend(struct buffer *buf, int size, bool prepend)
-{
-    return prepend ? buf_prepend(buf, size) : buf_write_alloc(buf, size);
-}
-
-static inline uint8_t *
 buf_read_alloc(struct buffer *buf, int size)
 {
     uint8_t *ret;

