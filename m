From: Simon Rozman <simon@...2293...>
Date: Sun, 21 Mar 2021 15:46:23 +0100
Message-Id: <20210321144627.1621-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/5] MSVC: Disable LZ4
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

Commit 24596b25 ("build: Remove compat-lz4") removed lz4 compat layer,
but openvpn-build\msvc doesn't provide LZ4 library either.

Signed-off-by: Simon Rozman <simon@...2293...>
---
 config-msvc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config-msvc.h b/config-msvc.h
index e430ca96..53d97902 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -9,7 +9,6 @@
 #define ENABLE_FRAGMENT 1
 #define ENABLE_HTTP_PROXY 1
 #define ENABLE_LZO 1
-#define ENABLE_LZ4 1
 #define ENABLE_MANAGEMENT 1
 #define ENABLE_MULTIHOME 1
 #define ENABLE_PKCS11 1
-- 
2.30.0.windows.2


