From: Frank Lichtenheld <frank@...2641...>
Date: Mon,  6 Feb 2023 14:08:46 +0100
Message-Id: <20230206130846.63415-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] configure: fix formatting of --disable-lz4
 and --enable-comp-stub
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

Make consistent with the other options.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 configure.ac | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

A small issue I noticed when staring at configure.ac for "enable
DCO by default" patch.

diff --git a/configure.ac b/configure.ac
index acfa4bc1..7ce4c826 100644
--- a/configure.ac
+++ b/configure.ac
@@ -67,14 +67,16 @@ AC_ARG_ENABLE(
 	[enable_lzo="yes"]
 )
 
-AC_ARG_ENABLE(lz4,
-	[  --disable-lz4           Disable LZ4 compression support],
+AC_ARG_ENABLE(
+	[lz4],
+	[AS_HELP_STRING([--disable-lz4], [disable LZ4 compression support @<:@default=yes@:>@])],
 	[enable_lz4="$enableval"],
 	[enable_lz4="yes"]
 )
 
-AC_ARG_ENABLE(comp-stub,
-	[  --enable-comp-stub      Don't compile compression support but still allow limited interoperability with compression-enabled peers],
+AC_ARG_ENABLE(
+	[comp-stub],
+	[AS_HELP_STRING([--enable-comp-stub], [disable compression support but still allow limited interoperability with compression-enabled peers @<:@default=no@:>@])],
 	[enable_comp_stub="$enableval"],
 	[enable_comp_stub="no"]
 )
-- 
2.34.1


