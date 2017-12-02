From: Antonio Quartulli <a@...2181...>
Date: Sat,  2 Dec 2017 21:45:38 +0800
Message-Id: <20171202134541.7688-4-a@...2181...>
In-Reply-To: <20171202134541.7688-1-a@...2181...>
References: <20171202134541.7688-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 4/7] Remove SSL_LIB_VER_STR
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

SSL_LIB_VER_STR made sense only when ENABLE_CRYPTO also
existed. It can now be removed and thus simplify the code.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/options.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9d9798f7..3f9ca710 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4087,16 +4087,15 @@ show_windows_version(const unsigned int flags)
 void
 show_library_versions(const unsigned int flags)
 {
-#define SSL_LIB_VER_STR get_ssl_library_version()
 #ifdef ENABLE_LZO
 #define LZO_LIB_VER_STR ", LZO ", lzo_version_string()
 #else
 #define LZO_LIB_VER_STR "", ""
 #endif
 
-    msg(flags, "library versions: %s%s%s", SSL_LIB_VER_STR, LZO_LIB_VER_STR);
+    msg(flags, "library versions: %s%s%s", get_ssl_library_version(),
+        LZO_LIB_VER_STR);
 
-#undef SSL_LIB_VER_STR
 #undef LZO_LIB_VER_STR
 }
 
-- 
2.15.1


