From: Fish <fish.thss@...277...>
Date: Mon, 14 Dec 2015 13:06:16 -0800
Message-Id: <1450127176-43837-1-git-send-email-fish.thss@...277...>
Subject: [Openvpn-devel] [PATCH] Make MSVC happy about route.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Move the definition of out to the beginning of functions to comply with
old-style C compilers. Tested on MSVC 2010.
---
 src/openvpn/route.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index cf5a067..c4459f9 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1551,6 +1551,9 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
 {
   struct gc_arena gc;
   struct argv argv;
+#ifdef WIN32
+  struct buffer out;
+#endif
 
   const char *network;
   const char *gateway;
@@ -1622,8 +1625,7 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
   status = openvpn_execve_check (&argv, es, 0, "ERROR: Linux route -6/-A inet6 add command failed");
 
 #elif defined (WIN32)
-
-  struct buffer out = alloc_buf_gc (64, &gc);
+  out = alloc_buf_gc(64, &gc);
   buf_printf (&out, "interface=%d", tt->adapter_index );
   device = buf_bptr(&out);
 
@@ -1900,6 +1902,9 @@ delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, unsigne
 {
   struct gc_arena gc;
   struct argv argv;
+#ifdef WIN32
+  struct buffer out;
+#endif
   const char *network;
   const char *gateway;
   const char *device = tt->actual_name;
@@ -1958,7 +1963,7 @@ delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, unsigne
 
 #elif defined (WIN32)
 
-  struct buffer out = alloc_buf_gc (64, &gc);
+  out = alloc_buf_gc(64, &gc);
   buf_printf (&out, "interface=%d", tt->adapter_index );
   device = buf_bptr(&out);
 
-- 
2.6.4


