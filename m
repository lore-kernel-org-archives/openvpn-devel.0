MIME-Version: 1.0
From: Guido Vranken <guidovranken@...277...>
Date: Thu, 8 Jun 2017 16:36:54 +0200
Message-ID: <CAO5O-EL11jDxO+c1Gu0FvunqwUTW2uxjy910+A-s63Nr5O3NWw@...278...>
Subject: [Openvpn-devel] [PATCH] Fix 2 memory leaks in proxy authentication
 routine
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

Signed-off-by: Guido Vranken <guidovranken@...277...>
---
 src/openvpn/proxy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index b0ed327..8ff09ba 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -318,6 +318,7 @@ get_proxy_authenticate(socket_descriptor_t sd,
     {
         if (!recv_line(sd, buf, sizeof(buf), timeout, true, NULL,
signal_received))
         {
+            free(*data);
             *data = NULL;
             return HTTP_AUTH_NONE;
         }
@@ -991,6 +992,7 @@ establish_http_proxy_passthru(struct http_proxy_info *p,
                 if (p->options.auth_retry == PAR_NCT && method ==
HTTP_AUTH_BASIC)
                 {
                     msg(D_PROXY, "HTTP proxy: support for basic auth
and other cleartext proxy auth methods is disabled");
+                    free(pa);
                     goto error;
                 }
                 p->auth_method = method;
-- 
2.1.4

