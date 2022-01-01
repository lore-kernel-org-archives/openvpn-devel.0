From: Arne Schwabe <arne@...1227...>
Date: Sat,  1 Jan 2022 17:06:32 +0100
Message-Id: <20220101160632.2250072-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Remove BUFFER_LIST_AGGREGATE_TEST test code
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

This code has been dead for years and also does not seem that
useful anymore since we already have a proper unit_test for the
buffer code.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c | 64 ----------------------------------------------
 1 file changed, 64 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index e8723714..4e37b885 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -870,70 +870,6 @@ init_static(void)
     return false;
 #endif
 
-#ifdef BUFFER_LIST_AGGREGATE_TEST
-    /* test buffer_list_aggregate function */
-    {
-        static const char *text[] = {
-            "It was a bright cold day in April, ",
-            "and the clocks were striking ",
-            "thirteen. ",
-            "Winston Smith, ",
-            "his chin nuzzled into his breast in an ",
-            "effort to escape the vile wind, ",
-            "slipped quickly through the glass doors ",
-            "of Victory Mansions, though not quickly ",
-            "enough to prevent a swirl of gritty dust from ",
-            "entering along with him."
-        };
-
-        int iter, listcap;
-        for (listcap = 0; listcap < 12; ++listcap)
-        {
-            for (iter = 0; iter < 512; ++iter)
-            {
-                struct buffer_list *bl = buffer_list_new(listcap);
-                {
-                    int i;
-                    for (i = 0; i < SIZE(text); ++i)
-                    {
-                        buffer_list_push(bl, (unsigned char *)text[i]);
-                    }
-                }
-                printf("[cap=%d i=%d] *************************\n", listcap, iter);
-                if (!(iter & 8))
-                {
-                    buffer_list_aggregate(bl, iter/2);
-                }
-                if (!(iter & 16))
-                {
-                    buffer_list_push(bl, (unsigned char *)"Even more text...");
-                }
-                buffer_list_aggregate(bl, iter);
-                if (!(iter & 1))
-                {
-                    buffer_list_push(bl, (unsigned char *)"More text...");
-                }
-                {
-                    struct buffer *buf;
-                    while ((buf = buffer_list_peek(bl)))
-                    {
-                        int c;
-                        printf("'");
-                        while ((c = buf_read_u8(buf)) >= 0)
-                        {
-                            putchar(c);
-                        }
-                        printf("'\n");
-                        buffer_list_advance(bl, 0);
-                    }
-                }
-                buffer_list_free(bl);
-            }
-        }
-        return false;
-    }
-#endif /* ifdef BUFFER_LIST_AGGREGATE_TEST */
-
 #ifdef MSTATS_TEST
     {
         int i;
-- 
2.33.0


