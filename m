From: luca.boccassi@...277...
Date: Sun, 15 Mar 2026 18:39:55 +0000
Message-ID: <20260315184337.1541272-2-luca.boccassi@...277...>
In-Reply-To: <20260315184337.1541272-1-luca.boccassi@...277...>
References: <20260315184337.1541272-1-luca.boccassi@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] Increase TLS_CHANNEL_BUF_SIZE from 2048
 to 8192
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
Cc: Luca Boccassi <luca.boccassi@...277...>

From: Luca Boccassi <luca.boccassi@...277...>

When authenticating via a JWT token 2048 bytes are not enough, which
breaks the auth process. In my local case the token is ~2100 bytes.
Bump the maximum harcoded size from 2k to 8k to leave some headroom.

Signed-off-by: Luca Boccassi <luca.boccassi@...277...>
---
 src/openvpn/common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/common.h b/src/openvpn/common.h
index aa7b7217..fbe6239a 100644
--- a/src/openvpn/common.h
+++ b/src/openvpn/common.h
@@ -67,7 +67,7 @@ typedef unsigned long ptr_type;
  * maximum size of a single TLS message (cleartext).
  * This parameter must be >= PUSH_BUNDLE_SIZE
  */
-#define TLS_CHANNEL_BUF_SIZE 2048
+#define TLS_CHANNEL_BUF_SIZE 8192
 
 /* TLS control buffer minimum size
  *
-- 
2.47.3


