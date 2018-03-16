From: Ning Wei <xiaoningning@...109...>
Date: Fri, 16 Mar 2018 09:40:59 -0700
Message-Id: <20180316164059.9120-1-xiaoningning@...109...>
Subject: [Openvpn-devel] [PATCH] Increase TLS Control Channel Buffer Size
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

Increase TLS_CHANNEL_BUF_SIZE to 4096. When the build is enabled with
ENABLE_PKCS11, the password field can be 4096.  The old size of
TLS_CHANNEL_BUF_SIZE was 2048, which is not enough.

Signed-off-by: Ning Wei <xiaoningning@...109...>
---
 src/openvpn/common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/common.h b/src/openvpn/common.h
index 4e6f4809..7e9b5f3a 100644
--- a/src/openvpn/common.h
+++ b/src/openvpn/common.h
@@ -75,7 +75,7 @@ typedef unsigned long ptr_type;
  * maximum size of a single TLS message (cleartext).
  * This parameter must be >= PUSH_BUNDLE_SIZE
  */
-#define TLS_CHANNEL_BUF_SIZE 2048
+#define TLS_CHANNEL_BUF_SIZE 4096
 
 /*
  * This parameter controls the maximum size of a bundle
-- 
2.15.0.windows.1


