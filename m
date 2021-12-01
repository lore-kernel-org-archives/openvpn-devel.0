From: Lev Stipakov <lstipakov@...277...>
Date: Wed,  1 Dec 2021 11:20:02 +0200
Message-Id: <20211201092002.162-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH master+release/2.5] ssh_openssl.h: remove
 unused declaration
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

Commit 95993a1df3 ("Refactored SSL initialisation functions")
has declared openssl_set_mydata_index(void) function but
hasn't added definition.

There hasn't been need in this function for 10 years,
so it can be safely removed.

Found by MSVC.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/ssl_openssl.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/openvpn/ssl_openssl.h b/src/openvpn/ssl_openssl.h
index 2eeb716c..46338c24 100644
--- a/src/openvpn/ssl_openssl.h
+++ b/src/openvpn/ssl_openssl.h
@@ -54,6 +54,4 @@ struct key_state_ssl {
  */
 extern int mydata_index; /* GLOBAL */
 
-void openssl_set_mydata_index(void);
-
 #endif /* SSL_OPENSSL_H_ */
-- 
2.23.0.windows.1


