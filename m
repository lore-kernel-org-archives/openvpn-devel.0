From: Frank Lichtenheld <frank@...2641...>
Date: Mon, 15 May 2023 17:54:07 +0200
Message-Id: <20230515155407.38647-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix two unused assignments
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

A fallout of my memleak investigation. These are
not leaks, we just assign a value that is never
read before overwritten. Not critical, but since
I already stumbled over it...

Change-Id: I761ea3d289f49a20e42a3d1bfccebce3c7447afe
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 src/openvpn/push.c | 1 -
 src/openvpn/tun.c  | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 54e53f6a..8e962719 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -713,7 +713,6 @@ send_push_options(struct context *c, struct buffer *buf,
 {
     struct push_entry *e = push_list->head;
 
-    e = push_list->head;
     while (e)
     {
         if (e->enable)
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 2320e8b1..df10dbd2 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -4337,7 +4337,6 @@ get_unspecified_device_guid(const int device_number,
                             struct gc_arena *gc)
 {
     const struct tap_reg *tap_reg = tap_reg_src;
-    struct buffer ret = clear_buf();
     struct buffer actual = clear_buf();
     int i;
 
@@ -4381,7 +4380,7 @@ get_unspecified_device_guid(const int device_number,
     }
 
     /* Save GUID for return value */
-    ret = alloc_buf_gc(256, gc);
+    struct buffer ret = alloc_buf_gc(256, gc);
     buf_printf(&ret, "%s", tap_reg->guid);
     if (windows_driver != NULL)
     {
-- 
2.34.1


