From: mykola.baibuz@...277...
Date: Mon, 14 Oct 2019 14:21:45 +0300
Message-Id: <20191014112145.251-1-mykola.baibuz@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix typo in NTLM proxy debug message
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

From: Mykola Baibuz <mykola.baibuz@...277...>

Signed-off-by: Mykola Baibuz <mykola.baibuz@...277...>
---
 src/openvpn/proxy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index c8bd86dd..9998623a 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -354,7 +354,7 @@ get_proxy_authenticate(socket_descriptor_t sd,
 #if NTLM
             else if (!strncmp(buf+20, "NTLM", 4))
             {
-                msg(D_PROXY, "PROXY AUTH HTLM: '%s'", buf);
+                msg(D_PROXY, "PROXY AUTH NTLM: '%s'", buf);
                 *data = NULL;
                 ret = HTTP_AUTH_NTLM;
             }
-- 
2.23.0.windows.1


