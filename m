From: Antonio Quartulli <a@...2181...>
Date: Wed, 29 Dec 2021 18:27:14 +0100
Message-Id: <20211229172714.6424-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] options.c: fix version reported in --cipher
 warning message
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
Cc: Antonio Quartulli <a@...2181...>, Arne Schwabe <arne@...1227...>

BF-CBC is the default value for the --cipher option in OpenVPN <2.5
and not <2.6. However, the warning printed to screen talks about
"OpenVPN before 2.6", which is wrong and needs to be fixed.

Fix message by saying ".. before 2.5"

Cc: Arne Schwabe <arne@...1227...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index b840b767..6fdcf764 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3120,7 +3120,7 @@ options_postprocess_cipher(struct options *o)
          * parts of OpenVPN assert that the ciphername is set */
         o->ciphername = "BF-CBC";
 
-        msg(M_INFO, "Note: --cipher is not set. OpenVPN versions before 2.6 "
+        msg(M_INFO, "Note: --cipher is not set. OpenVPN versions before 2.5 "
                     "defaulted to BF-CBC as fallback when cipher negotiation "
                     "failed in this case. If you need this fallback please add "
                     "'--data-ciphers-fallback 'BF-CBC' to your configuration "
-- 
2.34.1


