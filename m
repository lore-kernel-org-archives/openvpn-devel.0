From: Steffan Karger <steffan.karger@...1435...>
Date: Sat, 1 Jul 2017 14:54:01 +0200
Message-ID: <1498913642-32459-4-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1498913642-32459-1-git-send-email-steffan.karger@...1435...>
References: <1498913642-32459-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/5] buffer_list_aggregate_separator():
 prevent 0-byte malloc
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

As pointed out in finding OVPN-05 of the cryptograpy engineering audit
(funded by Private Internet Access), buffer_list_aggregate_separator()
could perform a 0-byte malloc when called with a list of 0-length buffers
and a "" separator.  If other could would later try to access that buffer
memory, this would result in undefined behaviour.  To prevent this, always
malloc() 1 byte.

To simplify as we go, use alloc_buf() to allocate the buffer.  This has
the additional benefit that the actual buffer data (not the contents) is
zero-terminated, because alloc_buf() calls calloc() and we have 1 extra
byte of data.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/buffer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 2700ad1..ecbdc1b 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -1261,8 +1261,7 @@ buffer_list_aggregate_separator(struct buffer_list *bl, const size_t max_len,
             struct buffer_entry *e = bl->head, *f;
 
             ALLOC_OBJ_CLEAR(f, struct buffer_entry);
-            f->buf.data = malloc(size);
-            check_malloc_return(f->buf.data);
+            f->buf = alloc_buf(size+1); /* prevent 0-byte malloc */
             f->buf.capacity = size;
             for (i = 0; e && i < count; ++i)
             {
-- 
2.7.4


