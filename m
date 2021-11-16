From: Richard T Bonhomme <stringvest88@...277...>
Date: Tue, 16 Nov 2021 15:08:23 +0000
Message-Id: <20211116150823.631970-1-tincantech@...2282...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Log messages: Replace NCP with
 --data-ciphers (NFC)
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

Signed-off-by: Richard T Bonhomme <tincantech@...2282...>
---
 src/openvpn/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4a5db8a6..fdac4732 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3240,7 +3240,7 @@ options_postprocess_mutate(struct options *o)
     o->ncp_ciphers = mutate_ncp_cipher_list(o->ncp_ciphers, &o->gc);
     if (o->ncp_ciphers == NULL)
     {
-        msg(M_USAGE, "NCP cipher list contains unsupported ciphers or is too long.");
+        msg(M_USAGE, "--data-ciphers list contains unsupported ciphers or is too long.");
     }
 
     if (o->remote_list && !o->connection_list)
-- 
2.25.1


