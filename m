From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 28 Mar 2023 17:12:33 +0200
Message-Id: <20230328151233.217296-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] buffer: use memcpy in buf_catrunc
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

Since we use strlen() to determine the length
and then check it ourselves, there is really
no point in using strncpy.

But the compiler might complain that we use
the output of strlen() for the length of
strncpy which is usually a sign for bugs:

error: ‘strncpy’ specified bound depends
 on the length of the source argument
 [-Werror=stringop-overflow=]

Warning was at least triggered for
mingw-gcc version 10-win32 20220113.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 src/openvpn/buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index d099795b..de40d690 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -317,9 +317,9 @@ buf_catrunc(struct buffer *buf, const char *str)
     if (buf_forward_capacity(buf) <= 1)
     {
         int len = (int) strlen(str) + 1;
-        if (len < buf_forward_capacity_total(buf))
+        if ((len > 0) && (len < buf_forward_capacity_total(buf)))
         {
-            strncpynt((char *)(buf->data + buf->capacity - len), str, len);
+            memcpy((void *)(buf->data + buf->capacity - len), (void *)str, (size_t)len);
         }
     }
 }
-- 
2.34.1


