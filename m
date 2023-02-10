From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 10 Feb 2023 15:31:59 +0200
Message-Id: <20230210133159.1336-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Improve format specifier for socket handle
 in Windows
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
Cc: Lev Stipakov <lev@...515...>, Selva Nair <selva.nair@...277...>

From: Lev Stipakov <lev@...515...>

Socket is a handle on Windows, which is usually logged in hex.
Also an interesting value is INVALID_SOCKET, which is ~0.

PRIuPTR prints decimals, and for INVALID_SOCKET it prints something like

  2023-02-10 14:45:21 us=906000 write to TUN/TAP : Jrjestelmkutsulle
annettu data-alue on liian pieni.   (fd=18446744073709551615,code=122)

PRIxPTR prints hex, and INVALID_SOCKET looks a bit nicer:

  2023-02-10 15:17:11 us=828000 write to TUN/TAP : Jrjestelmkutsulle
annettu data-alue on liian pieni.   (fd=ffffffffffffffff,code=122)

Reported-by: Selva Nair <selva.nair@...277...>
Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/syshead.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 12ccf2f4..53359225 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -441,7 +441,7 @@ typedef unsigned short sa_family_t;
  */
 #ifdef _WIN32
 #define SOCKET_UNDEFINED (INVALID_SOCKET)
-#define SOCKET_PRINTF "%" PRIuPTR
+#define SOCKET_PRINTF "%" PRIxPTR
 typedef SOCKET socket_descriptor_t;
 #else
 #define SOCKET_UNDEFINED (-1)
-- 
2.23.0.windows.1


