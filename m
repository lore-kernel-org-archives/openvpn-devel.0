From: David Sommerseth <davids@...515...>
Date: Mon,  2 Oct 2017 21:07:32 +0200
Message-Id: <20171002190732.12531-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH] lz4: Fix broken builds when pkg-config is
 not present but system library is
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

In commit f91e4863bc1382 we fixed an issue where LZ4_LIBS could be
overwritten in some situations.  But on systems where lz4 is installed on
the system but is lacking pkg-config information, the linker will not know
about the lz4 library when completing the build.

This fixes the issue by explicitly setting LZ4_LIBS to contain -llz4
if pkg-config test was run and failed verifying the installed lz4 version
number.  This also ensures that LZ4_LIBS will not be overwritten if it
has been provided on the ./configure command line.

Signed-off-by: David Sommerseth <davids@...515...>
---
 configure.ac | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 394f5b09..6f59baef 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1093,7 +1093,9 @@ if test "$enable_lz4" = "yes" && test "$enable_comp_stub" = "no"; then
 	PKG_CHECK_MODULES([LZ4],
 			  [liblz4 >= 1.7.1 liblz4 < 100],
 			  [have_lz4="yes"],
-			  [] # If this fails, we will do another test next
+			  [LZ4_LIBS="-llz4"] # If this fails, we will do another test next.
+					     # We also add set LZ4_LIBS otherwise the
+					     # linker will not know about the lz4 library
 	)
     fi
 
-- 
2.13.5


