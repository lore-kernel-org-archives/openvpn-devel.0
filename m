From: Steffan Karger <steffan@...1856...>
Date: Sun, 18 Dec 2016 17:38:15 +0100
Message-Id: <1482079095-14880-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Bump master to version 2.5_git
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

Now that we have the release/2.4 branch, the master branch version should
be bumped to 2.5.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 version.m4 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/version.m4 b/version.m4
index a8496f4..b1f446a 100644
--- a/version.m4
+++ b/version.m4
@@ -2,13 +2,13 @@ dnl define the OpenVPN version
 define([PRODUCT_NAME], [OpenVPN])
 define([PRODUCT_TARNAME], [openvpn])
 define([PRODUCT_VERSION_MAJOR], [2])
-define([PRODUCT_VERSION_MINOR], [4])
-define([PRODUCT_VERSION_PATCH], [_rc2])
+define([PRODUCT_VERSION_MINOR], [5])
+define([PRODUCT_VERSION_PATCH], [_git])
 m4_append([PRODUCT_VERSION], [PRODUCT_VERSION_MAJOR])
 m4_append([PRODUCT_VERSION], [PRODUCT_VERSION_MINOR], [[.]])
 m4_append([PRODUCT_VERSION], [PRODUCT_VERSION_PATCH], [[]])
 define([PRODUCT_BUGREPORT], [openvpn-users@lists.sourceforge.net])
-define([PRODUCT_VERSION_RESOURCE], [2,4,0,0])
+define([PRODUCT_VERSION_RESOURCE], [2,5,0,0])
 dnl define the TAP version
 define([PRODUCT_TAP_WIN_COMPONENT_ID], [tap0901])
 define([PRODUCT_TAP_WIN_MIN_MAJOR], [9])
-- 
2.7.4


