From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 29 Mar 2023 11:04:46 +0200
Message-Id: <20230329090447.246561-1-frank@...2641...>
In-Reply-To: <20230328151233.217296-1-frank@...2641...>
References: <20230328151233.217296-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2 v2] buffer: use memcpy in buf_catrunc
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

v2:
 - make len size_t and change code to avoid any theoretical overflows
 - remove useless casts

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index d099795b..886eb2c3 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -316,10 +316,10 @@ buf_catrunc(struct buffer *buf, const char *str)
 {
     if (buf_forward_capacity(buf) <= 1)
     {
-        int len = (int) strlen(str) + 1;
+        size_t len = strlen(str);
         if (len < buf_forward_capacity_total(buf))
         {
-            strncpynt((char *)(buf->data + buf->capacity - len), str, len);
+            memcpy(buf->data + buf->capacity - len - 1, str, len + 1);
         }
     }
 }
-- 
2.34.1


