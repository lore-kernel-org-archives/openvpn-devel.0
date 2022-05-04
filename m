From: Arne Schwabe <arne@...1227...>
Date: Wed,  4 May 2022 13:31:58 +0200
Message-Id: <20220504113158.1051861-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix format specifier for printing size_t on
 32bit size_t platforms
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

Today even 32 bit platform generally use a 64bit size_t but Android
armeabi-v7a is an expection to that and uses a 32bit size_t. Use
z as correct specifier for a size_t.

Clang complained about this:

warning: format specifies type 'unsigned long' but the
argument has type 'size_t' (aka 'unsigned int') [-Wformat]

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 3085e97b..e7d39645 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2431,7 +2431,7 @@ get_frame_mtu(struct context *c, const struct options *o)
 
     if (mtu < TUN_MTU_MIN)
     {
-        msg(M_WARN, "TUN MTU value (%lu) must be at least %d", mtu, TUN_MTU_MIN);
+        msg(M_WARN, "TUN MTU value (%zu) must be at least %d", mtu, TUN_MTU_MIN);
         frame_print(&c->c2.frame, M_FATAL, "MTU is too small");
     }
     return mtu;
-- 
2.32.0 (Apple Git-132)


