From: Steffan Karger <steffan.karger@...1435...>
Date: Wed, 1 Nov 2017 13:55:11 +0100
Message-ID: <1509540912-8739-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] doxygen: use relative paths from the
 project root
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

Instead of genering docs with full path names (e.g.
/home/steffan/dev/openvpn/src/openvpn/crypto.h), use a relative path wrt
the project root (e.g. src/openvpn/crypto.h).  This makes the generated
doxygen easier to read.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 doc/doxygen/openvpn.doxyfile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/doxygen/openvpn.doxyfile b/doc/doxygen/openvpn.doxyfile
index a7d9728..80cda2b 100644
--- a/doc/doxygen/openvpn.doxyfile
+++ b/doc/doxygen/openvpn.doxyfile
@@ -25,7 +25,7 @@ ABBREVIATE_BRIEF       = "The $name class" \
 ALWAYS_DETAILED_SEC    = NO
 INLINE_INHERITED_MEMB  = NO
 FULL_PATH_NAMES        = YES
-STRIP_FROM_PATH        = ""
+STRIP_FROM_PATH        = "."
 STRIP_FROM_INC_PATH    =
 SHORT_NAMES            = NO
 JAVADOC_AUTOBRIEF      = YES # NO
-- 
2.7.4


