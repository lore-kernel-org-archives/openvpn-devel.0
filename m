From: Arne Schwabe <arne@...1227...>
Date: Mon, 14 Feb 2022 01:31:40 +0100
Message-Id: <20220214003140.3741349-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add better documentation for CAS_* states
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl_common.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 42b63cd0..10a3f730 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -522,9 +522,10 @@ struct tls_session
 #define KEY_SCAN_SIZE 3
 
 
-/* client authentication state, CAS_SUCCEEDED must be 0 since
- * non multi code path still checks this variable but does not initialise it
- * so the code depends on zero initialisation */
+/* multi state (originally client authentication state (=CAS))
+ * CAS_NOT_CONNECTED must be 0 since non multi code paths still check
+ * this variable but do not explicitly initialise it and depend
+ * on zero initialisation */
 
 /* CAS_NOT_CONNECTED is the initial state for every context. When the *first*
  * tls_session reaches S_ACTIVE, this state machine moves to CAS_PENDING (server)
@@ -532,11 +533,11 @@ struct tls_session
  * connect scripts/plugins */
 enum multi_status {
     CAS_NOT_CONNECTED,
-    CAS_WAITING_AUTH,               /**< TLS connection established but deferred auth not finished */
-    CAS_PENDING,
-    CAS_PENDING_DEFERRED,
-    CAS_PENDING_DEFERRED_PARTIAL,   /**< at least handler succeeded, no result yet*/
-    CAS_FAILED,
+    CAS_WAITING_AUTH,               /**< Initial TLS connection established but deferred auth is not yet finished */
+    CAS_PENDING,                    /**< Options import (Connect script/plugin, ccd,...) */
+    CAS_PENDING_DEFERRED,           /**< Waiting on an async option import handler */
+    CAS_PENDING_DEFERRED_PARTIAL,   /**< at least handler succeeded but another is still pending */
+    CAS_FAILED,                     /**< Option import failed or explicitly denied the client */
     CAS_WAITING_OPTIONS_IMPORT,     /**< client with pull or p2p waiting for first time options import */
     CAS_CONNECT_DONE,
 };
-- 
2.33.0


