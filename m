From: Bertrand Jacquin <beber@...1472...>
Date: Sun,  7 Aug 2011 12:59:15 +0200
Message-Id: <1312714757-10317-3-git-send-email-beber@...1472...>
In-Reply-To: <1312714757-10317-1-git-send-email-beber@...1472...>
References: <1312714757-10317-1-git-send-email-beber@...1472...>
Subject: [Openvpn-devel] [PATCH 2/4] Win32: Add OpenVPN RC file to add fill
	"Details" exe properties tabs
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

Signed-off-by: Bertrand Jacquin <beber@...1472...>
---
 openvpn-res.rc |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/openvpn-res.rc b/openvpn-res.rc
new file mode 100644
index 0000000..f5176a2
--- /dev/null
+++ b/openvpn-res.rc
@@ -0,0 +1,8 @@
+/*
+ * (c) 2011 Bertrand Jacquin <beber@...1472...>
+ */
+
+#include <windows.h>
+
+1 VERSIONINFO
+
-- 
1.7.6


