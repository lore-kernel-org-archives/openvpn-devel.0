From: Steffan Karger <steffan@...1856...>
Date: Tue, 22 Nov 2016 21:12:08 +0100
Message-Id: <1479845528-16068-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Change cmocka remote to use https in stead
	of git protocol
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

From: Steffan Karger <steffan.karger@...1435...>

Allows to clone the cmocka submodule from networks where 'anything but
web and mail' is firewalled.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 .gitmodules | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitmodules b/.gitmodules
index e9c6388..c1ff36e 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -1,4 +1,4 @@
 [submodule "vendor/cmocka"]
 	path = vendor/cmocka
-	url = git://git.cryptomilk.org/projects/cmocka.git
+	url = https://git.cryptomilk.org/projects/cmocka.git
 	branch = master
-- 
2.7.4


