From: Arne Schwabe <arne@...1227...>
Date: Fri,  5 Jul 2019 13:42:43 +0200
Message-Id: <20190705114243.9481-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Remove -no-cpp-precomp flag from Darwin
 builds
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

GCC 9 no longer accepts this flag and trying to find out what it does do
leads to an article

"-no-cpp-precomp: the compiler flag that time forgot"

that also no longer on the Internet. And most other things are
PRs/commits from over ten years ago that remove the flag since it
is no longer needed.
---
 configure.ac | 2 --
 1 file changed, 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 2cc396e5..e9f8a2f9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -323,8 +323,6 @@ case "$host" in
 		AC_DEFINE([TARGET_DARWIN], [1], [Are we running on Mac OS X?])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["M"], [Target prefix])
 		have_tap_header="yes"
-		dnl some Mac OS X tendering (we use vararg macros...)
-		CPPFLAGS="$CPPFLAGS -no-cpp-precomp"
 		ac_cv_type_struct_in_pktinfo=no
 		;;
 	*-mingw*)
-- 
2.22.0


