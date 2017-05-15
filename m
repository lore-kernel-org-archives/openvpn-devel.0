From: Steffan Karger <steffan.karger@...1435...>
Date: Mon, 15 May 2017 16:43:55 +0200
Message-ID: <1494859435-16379-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Log the negotiated (NCP) cipher
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

To make it clear that NCP is in effect, print a log message (at --verb 2)
to show that we selected a cipher using NCP.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/ssl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 21c9d6f..3d5e824 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1959,6 +1959,12 @@ tls_session_update_crypto_params(struct tls_session *session,
         return false;
     }
 
+    if (strcmp(options->ciphername, session->opt->config_ciphername))
+    {
+        msg(D_HANDSHAKE, "Data Channel: using negotiated cipher '%s'",
+            options->ciphername);
+    }
+
     init_key_type(&session->opt->key_type, options->ciphername,
                   options->authname, options->keysize, true, true);
 
-- 
2.7.4


