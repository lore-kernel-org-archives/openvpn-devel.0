From: Gert Doering <gert@...1296...>
Date: Wed,  8 Oct 2025 19:01:44 +0200
Message-ID: <20251008170149.10301-1-gert@...1296...>
In-Reply-To: <gerrit.1759942426000.I4a5c46f321709c83a4a921366630fb8e02834701@...2715...>
References: <gerrit.1759942426000.I4a5c46f321709c83a4a921366630fb8e02834701@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] lzo: Fix conversion warning
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

We already have an assert ensuring the value is sane,
so just add the cast.

Change-Id: I4a5c46f321709c83a4a921366630fb8e02834701
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1260
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1260
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
index 8daaec0..8307b59 100644
--- a/src/openvpn/lzo.c
+++ b/src/openvpn/lzo.c
@@ -72,11 +72,6 @@
     *header = NO_COMPRESS_BYTE;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static void
 lzo_decompress(struct buffer *buf, struct buffer work, struct compress_context *compctx,
                const struct frame *frame)
@@ -107,7 +102,7 @@
         }
 
         ASSERT(buf_safe(&work, zlen));
-        work.len = zlen;
+        work.len = (int)zlen;
 
         dmsg(D_COMP, "LZO decompress %d -> %d", buf->len, work.len);
         compctx->pre_decompress += buf->len;
@@ -126,10 +121,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 const struct compress_alg lzo_alg = { "lzo", lzo_compress_init, lzo_compress_uninit, lzo_compress,
                                       lzo_decompress };
 #endif /* ENABLE_LZO */

