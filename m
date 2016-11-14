From: Steffan Karger <steffan@...1856...>
Date: Mon, 14 Nov 2016 20:58:10 +0100
Message-Id: <1479153490-6259-1-git-send-email-steffan@...1856...>
In-Reply-To: <54FC26BB.2000202@...1856...>
References: <54FC26BB.2000202@...1856...>
Subject: [Openvpn-devel] [PATCH] Deprecate key-method 1
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

Key method 2 has been the default since OpenVPN 2.0, and is both more
functional and secure.  Also, key method 1 was only ever supported for
peer-to-peer connections (i.e. not for client-server).

Let's get rid of some legacy and phase out key method 1.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/options.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 1eb3a41..f39c4fa 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2245,6 +2245,12 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 	  "may accept clients which do not present a certificate");
     }
 
+  if (options->key_method == 1)
+    {
+      msg (M_WARN, "WARNING: --key-method 1 is deprecated and will be removed"
+	  "in OpenVPN 2.5.  Migrate to --key-method 2 as soon as possible.");
+    }
+
   if (options->tls_server || options->tls_client)
     {
 #ifdef ENABLE_PKCS11
-- 
2.7.4


