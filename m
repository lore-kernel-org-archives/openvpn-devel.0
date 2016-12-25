From: Gert Doering <gert@...1296...>
Date: Sun, 25 Dec 2016 11:59:19 +0100
Message-Id: <20161225105919.25792-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Remove IV_RGI6=1 peer-info signalling.
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

This is no longer needed, as anything 2.4 or later is known to have
this functionality, and IV_VER can be used to detect this on the server.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/ssl.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 15f62f2..cff4052 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2270,9 +2270,6 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
         comp_generate_peer_info_string(&session->opt->comp_options, &out);
 #endif
 
-        /* support for redirecting IPv6 gateway */
-        buf_printf(&out, "IV_RGI6=1\n");
-
         if (session->opt->push_peer_info_detail >= 2)
         {
             /* push mac addr */
-- 
2.10.2


