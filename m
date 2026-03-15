From: luca.boccassi@...277...
Date: Sun, 15 Mar 2026 23:05:30 +0000
Message-ID: <20260315230620.1594780-3-luca.boccassi@...277...>
In-Reply-To: <20260315230620.1594780-1-luca.boccassi@...277...>
References: <20260315184337.1541272-1-luca.boccassi@...277...>
 <20260315230620.1594780-1-luca.boccassi@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 2/3] Unconditionally set USER_PASS_LEN to
 4096
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

When authenticating via a JWT token 128 bytes are not enough, which
breaks the auth process. Currently the hardcoded password limit is
increased to 4k when PKCS11 is enabled, for similar reasons.
Remove the compile time conditional and always set the limit to 4k.

Signed-off-by: Luca Boccassi <luca.boccassi@...277...>
---
 src/openvpn/misc.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index e9cfadba..2c495d41 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -58,11 +58,7 @@ struct user_pass
     bool protected;
 
 /* max length of username/password */
-#ifdef ENABLE_PKCS11
 #define USER_PASS_LEN 4096
-#else
-#define USER_PASS_LEN 128
-#endif
     /* Note that username and password are expected to be null-terminated */
     char username[USER_PASS_LEN];
     char password[USER_PASS_LEN];
-- 
2.47.3


