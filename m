From: Mike Auty <mike.auty@...277...>
Message-ID: <57016632.9060306@...277...>
Date: Sun, 3 Apr 2016 19:51:30 +0100
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/7] vlan: add compile-time option
	ENABLE_VLAN_TAGGING
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

The option can be disabled via "./configure --disable-vlan-tagging".

Patch authored by Fabian Knittel <fabian.knittel@...2126...>.

Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
---
 configure.ac | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/configure.ac b/configure.ac
index b75d51f..89556c4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -271,6 +271,12 @@ AC_ARG_ENABLE(
 	[enable_async_push="no"]
 )
 
+AC_ARG_ENABLE(vlan-tagging,
+	[  --disable-vlan-tagging  Disable support for 802.1Q-based VLAN tagging],
+	[VLAN_TAGGING="$enableval"],
+	[VLAN_TAGGING="yes"]
+)
+
 AC_ARG_WITH(
 	[special-build],
 	[AS_HELP_STRING([--with-special-build=STRING], [specify special build string])],
@@ -1163,6 +1169,10 @@ if test "${enable_async_push}" = "yes"; then
 	)
 fi
 
+if test "$VLAN_TAGGING" = "yes"; then
+   AC_DEFINE(ENABLE_VLAN_TAGGING, 1, [Enable 802.1Q-based VLAN tagging/untagging])
+fi
+
 CONFIGURE_DEFINES="`set | grep '^enable_.*=' ; set | grep '^with_.*='`"
 AC_DEFINE_UNQUOTED([CONFIGURE_DEFINES], ["`echo ${CONFIGURE_DEFINES}`"], [Configuration settings])
 
-- 
2.7.1

