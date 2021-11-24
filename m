From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 24 Nov 2021 18:03:47 +0200
Message-Id: <20211124160347.1245-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] ring_buffer.h: fix GCC warning about unused
 function
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

With register_ring_buffers() being declared as "static" in header file,
all translation units, which include that header, got a copy of that function.
This causes GCC warning

  warning: "register_ring_buffers" defined but not used [-Wunused-function]

when compiling C files which include header, but don't use function.

Add "inline" keyword to silence this warning.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/ring_buffer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/ring_buffer.h b/src/openvpn/ring_buffer.h
index 77579e3f..9661ceb3 100644
--- a/src/openvpn/ring_buffer.h
+++ b/src/openvpn/ring_buffer.h
@@ -94,7 +94,7 @@ struct TUN_PACKET
  *                            that data has been written to receive ring
  * @return                    true if registration is successful, false otherwise - use GetLastError()
  */
-static bool
+static inline bool
 register_ring_buffers(HANDLE device,
                       struct tun_ring *send_ring,
                       struct tun_ring *receive_ring,
-- 
2.23.0.windows.1


