From: Arne Schwabe <arne@...1227...>
Date: Wed, 17 Aug 2022 15:53:48 +0200
Message-Id: <20220817135348.844178-1-arne@...1227...>
In-Reply-To: <20220316102317.3356246-1-arne@...1227...>
References: <20220316102317.3356246-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Fix IV_PLAT_VER and UV_ variables sent
 without push-peer-info
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

Commit 8c72d7981 changed the push_peer_info_detail to have an
additional level for P2P NCP and shifting most of the other levels
with 1. The check for UV_ and IV_PLAT_VER was not changed accordingly.

Fixes: 8c72d7981 ("Support NCP in pure P2P VPN setups")
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 77f572a40..33e145b3f 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2036,7 +2036,7 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
                 {
                     if ((((strncmp(e->string, "UV_", 3) == 0
                            || strncmp(e->string, "IV_PLAT_VER=", sizeof("IV_PLAT_VER=") - 1) == 0)
-                          && session->opt->push_peer_info_detail >= 2)
+                          && session->opt->push_peer_info_detail > 2)
                          || (strncmp(e->string, "IV_GUI_VER=", sizeof("IV_GUI_VER=") - 1) == 0)
                          || (strncmp(e->string, "IV_SSO=", sizeof("IV_SSO=") - 1) == 0)
                          )
-- 
2.32.1 (Apple Git-133)


