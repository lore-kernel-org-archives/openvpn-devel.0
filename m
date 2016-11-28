From: Gert Doering <gert@...1296...>
Date: Mon, 28 Nov 2016 20:06:52 +0100
Message-Id: <1480360012-9479-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Fix windows path in Changes.rst
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

Escape backslash characters in windows path names.

Signed-off-by: Gert Doering <gert@...1296...>
---
 Changes.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 6d7bd69..aa80c10 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -71,12 +71,12 @@ New interactive Windows service
 
     The interactive Windows service allows unprivileged users to start
     OpenVPN connections in the global config directory (usually
-    C:\Program Files\OpenVPN\config) using OpenVPN GUI without any
+    C:\\Program Files\\OpenVPN\\config) using OpenVPN GUI without any
     extra configuration.
 
     Users who belong to the built-in Administrator group or to the
     local "OpenVPN Administrator" group can also store configuration
-    files under %USERPROFILE%\OpenVPN\config for use with the
+    files under %USERPROFILE%\\OpenVPN\\config for use with the
     interactive service.
 
 redirect-gateway ipv6
-- 
2.7.3


