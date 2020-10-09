From: Gert Doering <gert@...1296...>
Date: Fri,  9 Oct 2020 22:33:31 +0200
Message-Id: <20201009203331.11779-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix compilation on pre-EKM mbedTLS
 libraries.
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

commit f0734e49956217 simplified key_state_export_keying_material(),
changing the function prototype.  For older mbedTLS versions, there
is "always fail" dummy function which was overlooked in that change.

Fix prototype.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/ssl_mbedtls.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index bb5633b7..b100d03e 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -252,11 +252,10 @@ key_state_export_keying_material(struct tls_session *session,
     }
 }
 #else
-unsigned char*
+bool
 key_state_export_keying_material(struct tls_session *session,
                                  const char* label, size_t label_size,
-                                 size_t ekm_size,
-                                 struct gc_arena *gc)
+                                 void *ekm, size_t ekm_size)
 {
     /* Dummy function to avoid ifdefs in the common code */
     return NULL;
-- 
2.22.0


