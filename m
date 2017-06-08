MIME-Version: 1.0
From: Guido Vranken <guidovranken@...277...>
Date: Thu, 8 Jun 2017 23:56:38 +0200
Message-ID: <CAO5O-ELO64OT4zjNSLvXn2tNRj6eMi=z0zQsx1TGt29ioFAS2Q@...278...>
Subject: [Openvpn-devel] [PATCH] Fix a null-pointer dereference in
 establish_http_proxy_passthru()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Prevents that the client crashes if the peer does not specify
the 'realm' and/or 'nonce' values. These pointers are
dereferenced in DigestCalcHA1() and DigestCalcResponse();
hence, if not set, a null-pointer dereference would occur.

Signed-off-by: Guido Vranken <guidovranken@...277...>
---
 src/openvpn/proxy.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 8ff09ba..c96367e 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -876,6 +876,11 @@ establish_http_proxy_passthru(struct http_proxy_info *p,
                 const char *algor = get_pa_var("algorithm", pa, &gc);
                 const char *opaque = get_pa_var("opaque", pa, &gc);

+                if ( !realm || !nonce )
+                {
+                    goto error;
+                }
+
                 /* generate a client nonce */
                 ASSERT(rand_bytes(cnonce_raw, sizeof(cnonce_raw)));
                 cnonce = make_base64_string2(cnonce_raw,
sizeof(cnonce_raw), &gc);
-- 
2.1.4

