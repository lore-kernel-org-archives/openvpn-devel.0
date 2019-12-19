From: Simon Rozman <simon@...2293...>
Date: Thu, 19 Dec 2019 23:39:17 +0100
Message-Id: <20191219223917.1614-7-simon@...2293...>
In-Reply-To: <20191219223917.1614-1-simon@...2293...>
References: <20191219223917.1614-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 7/7] tun.c: reword the
 at_least_one_tap_win() error
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

Signed-off-by: Simon Rozman <simon@...2293...>
---
 src/openvpn/tun.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 8508b9c0..14ff0259 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -4031,7 +4031,7 @@ at_least_one_tap_win(const struct tap_reg *tap_reg)
 {
     if (!tap_reg)
     {
-        msg(M_FATAL, "There are no TAP-Windows adapters on this system.  You should be able to create a TAP-Windows adapter by going to Start -> All Programs -> TAP-Windows -> Utilities -> Add a new TAP-Windows virtual ethernet adapter.");
+        msg(M_FATAL, "There are no TAP-Windows nor Wintun adapters on this system.  You should be able to create an adapter by using tapctl.exe utility.");
     }
 }
 
-- 
2.24.1.windows.2


