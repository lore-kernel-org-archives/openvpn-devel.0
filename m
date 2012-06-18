From: Alon Bar-Lev <alon.barlev@...277...>
Date: Mon, 18 Jun 2012 20:35:04 +0300
Message-Id: <1340040904-23950-1-git-send-email-alon.barlev@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] cleanup: pkcs11.c: resolve wanings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>

src/openvpn/pkcs11.c:794:2: warning: passing argument 1 of ‘pkcs11h_setPINPromptHook’ from incompatible pointer type

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/openvpn/pkcs11.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index d86e267..645f1f4 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -730,7 +730,7 @@ cleanup:
 }
 
 static
-bool
+PKCS11H_BOOL
 _pkcs11_openvpn_show_pkcs11_ids_pin_prompt (
 	void * const global_data,
 	void * const user_data,
-- 
1.7.3.4


