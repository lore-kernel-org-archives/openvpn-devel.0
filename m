From: Arne Schwabe <arne@...1227...>
Date: Wed, 20 May 2020 00:00:01 +0200
Message-Id: <20200519220004.25136-3-arne@...1227...>
In-Reply-To: <20200519220004.25136-1-arne@...1227...>
References: <20200519220004.25136-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v3 2/5] Implement support for signalling
 IV_SSO to server
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
index c2e9a4f3..f85ef3eb 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2333,7 +2333,9 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
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
2.26.0


