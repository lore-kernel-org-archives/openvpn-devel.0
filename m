From: Arne Schwabe <arne@...1227...>
Date: Thu, 15 Dec 2022 20:01:43 +0100
Message-Id: <20221215190143.2107896-9-arne@...1227...>
In-Reply-To: <20221215190143.2107896-1-arne@...1227...>
References: <20221215190143.2107896-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 8/8] Deprecate NTLMv1 proxy auth method.
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

NTLMv1 is ancient and not considered secure anymore and we are not
aware of any users or software still requiring this feature.

Additionally it currently depends on our "doing single DES using
3DES" workaround for OpenSSL (cipher_des_encrypt_ecb). So removing
NTLMv1 will also allow us to remove that workaround.

Reported-By: Trial of Bits (TOB-OVPN-7)
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/proxy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index ed7201616..633caee09 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -519,6 +519,8 @@ http_proxy_new(const struct http_proxy_options *o)
 #if NTLM
         else if (!strcmp(o->auth_method_string, "ntlm"))
         {
+            msg(M_INFO, "NTLM v1 authentication is deprecated and will be removed in "
+                "OpenVPN 2.7");
             p->auth_method = HTTP_AUTH_NTLM;
         }
         else if (!strcmp(o->auth_method_string, "ntlm2"))
-- 
2.37.1 (Apple Git-137.1)


