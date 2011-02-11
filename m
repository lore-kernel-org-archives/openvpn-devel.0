From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
Date: Fri, 11 Feb 2011 17:09:37 +0200
Message-Id: <1297436985-18991-5-git-send-email-samuli@...515...>
In-Reply-To: <1297436985-18991-1-git-send-email-samuli@...515...>
References: <1297436985-18991-1-git-send-email-samuli@...515...>
Subject: [Openvpn-devel] [PATCH 05/13] Added support for viewing
	config-win32.h paramters to win/show.py
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

The win/show.py tools is used to view build parameters interactively. This
changes it so that it displays parameters parsed from config-win32.h in addition
to those from win/settings.in.
---
 win/show.py |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/win/show.py b/win/show.py
index 9558c87..6b1140a 100644
--- a/win/show.py
+++ b/win/show.py
@@ -1,9 +1,9 @@
-from wb import get_config
+from wb import get_config, get_build_params
 from js import JSON
 
 def main():
-    kv = get_config()
-    print JSON().encode(kv)
+    print JSON().encode(get_config())
+    print JSON().encode(get_build_params())
 
 # if we are run directly, and not loaded as a module
 if __name__ == "__main__":
-- 
1.6.3.3


