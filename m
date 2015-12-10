From: Arne Schwabe <arne@...1227...>
Date: Thu, 10 Dec 2015 13:37:15 +0100
Message-Id: <1449751035-10757-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Ignore stamp-h2 we generate during build
	process
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

---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 0403ae8..e154092 100644
--- a/.gitignore
+++ b/.gitignore
@@ -59,3 +59,4 @@ config-version.h
 nbproject
 test-driver
 compile
+stamp-h2
-- 
2.5.4 (Apple Git-61)


