From: Antonio Quartulli <a@...2181...>
Date: Sat,  2 Dec 2017 21:45:39 +0800
Message-Id: <20171202134541.7688-5-a@...2181...>
In-Reply-To: <20171202134541.7688-1-a@...2181...>
References: <20171202134541.7688-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 5/7] Remove CIPHER_ENABLED
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
Cc: Antonio Quartulli <a@...2181...>

Now that ENABLE_CRYPTO has been removed, CIPHER_ENABLED is basically
a useless shortcut which does not really help the readability of the
code.

Remove it and use its expanded expression instead.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/init.c    | 4 ++--
 src/openvpn/openvpn.h | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index e013e9ca..f8034ec7 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2379,7 +2379,7 @@ frame_finalize_options(struct context *c, const struct options *o)
      * Set adjustment factor for buffer alignment when no
      * cipher is used.
      */
-    if (!CIPHER_ENABLED(c))
+    if (!c->c1.ks.key_type.cipher)
     {
         frame_align_to_extra_frame(&c->c2.frame);
         frame_or_align_flags(&c->c2.frame,
@@ -2904,7 +2904,7 @@ do_init_frame(struct context *c)
          * flexible enough for this, since the frame is already established
          * before it is known which compression options will be pushed.
          */
-        if (comp_unswapped_prefix(&c->options.comp) && CIPHER_ENABLED(c))
+        if (comp_unswapped_prefix(&c->options.comp) && c->c1.ks.key_type.cipher)
         {
             frame_add_to_align_adjust(&c->c2.frame, COMP_PREFIX_LEN);
             frame_or_align_flags(&c->c2.frame,
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index fb8ff1a4..d843c913 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -565,8 +565,6 @@ struct context
                                           gc)
 #define MD5SUM(buf, len, gc) md5sum((buf), (len), 0, (gc))
 
-#define CIPHER_ENABLED(c) (c->c1.ks.key_type.cipher != NULL)
-
 /* this represents "disabled peer-id" */
 #define MAX_PEER_ID 0xFFFFFF
 
-- 
2.15.1


