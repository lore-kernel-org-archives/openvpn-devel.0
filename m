From: Arne Schwabe <arne@...1227...>
Date: Thu, 13 Jun 2019 16:41:11 +0200
Message-Id: <20190613144113.6418-4-arne@...1227...>
In-Reply-To: <20190613144113.6418-1-arne@...1227...>
References: <20190613144113.6418-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 3/5] Implement support for signalling IV_SSO
 to server
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
 src/openvpn/ssl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 640808f9..45806553 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2343,7 +2343,9 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
                 if ((((strncmp(e->string, "UV_", 3)==0
                        || strncmp(e->string, "IV_PLAT_VER=", sizeof("IV_PLAT_VER=")-1)==0)
                       && session->opt->push_peer_info_detail >= 2)
-                     || (strncmp(e->string,"IV_GUI_VER=",sizeof("IV_GUI_VER=")-1)==0))
+                     || (strncmp(e->string,"IV_GUI_VER=",sizeof("IV_GUI_VER=")-1)==0)
+                     || (strncmp(e->string,"IV_SSO=",sizeof("IV_SSO=")-1)==0)
+                     )
                     && buf_safe(&out, strlen(e->string)+1))
                 {
                     buf_printf(&out, "%s\n", e->string);
-- 
2.22.0


