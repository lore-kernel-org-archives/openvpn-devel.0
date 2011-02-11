From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
Date: Fri, 11 Feb 2011 17:09:42 +0200
Message-Id: <1297436985-18991-10-git-send-email-samuli@...515...>
In-Reply-To: <1297436985-18991-1-git-send-email-samuli@...515...>
References: <1297436985-18991-1-git-send-email-samuli@...515...>
Subject: [Openvpn-devel] [PATCH 10/13] Added comments to win/build_ddk.py
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
 win/build_ddk.py |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/win/build_ddk.py b/win/build_ddk.py
index 1a0cf82..65eed25 100644
--- a/win/build_ddk.py
+++ b/win/build_ddk.py
@@ -8,6 +8,7 @@ def build_ddk(config, dir, x64):
     return build_tap(ddk_path, ddk_major, debug, dir, x64)
 
 def build_tap(ddk_path, ddk_major, debug, dir, x64):
+    """Build drivers using WinDDK tools"""
     setenv_bat = os.path.realpath(os.path.join(ddk_path, 'bin/setenv.bat'))
     target = 'chk' if debug else 'fre'
     if x64:
-- 
1.6.3.3


