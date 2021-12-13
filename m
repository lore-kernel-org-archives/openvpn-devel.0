From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 13 Dec 2021 15:52:53 +0200
Message-Id: <20211213135253.212-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH master] config-msvc.h: indicate key material
 export support
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

MSVC build uses OpenSSL from vcpkg, which at the moment
is 1.1.1l. Key material export was added to 1.1.1, so it is safe
to indicate its support unconditionally.

This enables Windows releases to benefit from tls-ekm
data channel keys derivation.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 config-msvc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config-msvc.h b/config-msvc.h
index 0ae38482..b08beb52 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -40,6 +40,7 @@
 #define HAVE_IN_PKTINFO 1
 
 #define HAVE_OPENSSL_ENGINE 1
+#define HAVE_EXPORT_KEYING_MATERIAL 1
 
 #define HAVE_DIINSTALLDEVICE 1
 
-- 
2.23.0.windows.1


