From: Fabian Knittel <fabian.knittel@...1338...>
Date: Wed, 28 Apr 2010 16:55:09 +0200
Message-Id: <1272466514-18866-2-git-send-email-fabian.knittel@...1338...>
In-Reply-To: <1272466514-18866-1-git-send-email-fabian.knittel@...1338...>
References: <1272466514-18866-1-git-send-email-fabian.knittel@...1338...>
Subject: [Openvpn-devel] [PATCH 1/6] vlan: Mention 802.1Q in configuration
	descriptions
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

To clarify that the tagging/untagging is based on the 802.1Q standard, this
patch adds "802.1Q-based" to a few descriptive strings.

The improvement was suggested by Peter Stuge.

Signed-off-by: Fabian Knittel <fabian.knittel@...1338...>
---
 configure.ac |    4 ++--
 options.c    |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index b99bc11..89e3d30 100644
--- a/configure.ac
+++ b/configure.ac
@@ -213,7 +213,7 @@ AC_ARG_ENABLE(selinux,
 )
 
 AC_ARG_ENABLE(vlan-tagging,
-   [  --disable-vlan-tagging  Disable support for VLAN tagging/untagging],
+   [  --disable-vlan-tagging  Disable support for 802.1Q-based VLAN tagging],
    [VLAN_TAGGING="$enableval"],
    [VLAN_TAGGING="yes"]
 )
@@ -894,7 +894,7 @@ fi
 
 dnl enable --vlan-tagging
 if test "$VLAN_TAGGING" = "yes"; then
-   AC_DEFINE(ENABLE_VLAN_TAGGING, 1, [Enable VLAN tagging/untagging])
+   AC_DEFINE(ENABLE_VLAN_TAGGING, 1, [Enable 802.1Q-based VLAN tagging/untagging])
 fi
 
 
diff --git a/options.c b/options.c
index bf8b3a1..2d47f20 100644
--- a/options.c
+++ b/options.c
@@ -422,7 +422,7 @@ static const char usage_message[] =
   "                  to a web server at host:port.\n"
 #endif
 #ifdef ENABLE_VLAN_TAGGING
-  "--vlan-tagging  : Enable VLAN tagging.\n"
+  "--vlan-tagging  : Enable 802.1Q-based VLAN tagging.\n"
   "--vlan-accept tagged|untagged|all : Set VLAN tagging mode. Default is 'all'.\n"
   "--vlan-pvid v   : Sets the Port VLAN Identifier. Defaults to 1.\n"
 #endif
-- 
1.7.0


