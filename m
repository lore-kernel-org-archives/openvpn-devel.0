From: Adriaan de Jong <dejong@...1435...>
Date: Mon, 2 Apr 2012 09:28:06 +0200
Message-ID: <1333351687-3732-5-git-send-email-dejong@...1435...>
In-Reply-To: <1333351687-3732-1-git-send-email-dejong@...1435...>
References: <1333351687-3732-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 5/6] Removed stray "Fox-IT hardening" string.
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

Signed-off-by: Adriaan de Jong <dejong@...1435...>
---
 src/openvpn/ssl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 767bc8e..19512c0 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -392,7 +392,7 @@ init_ssl (const struct options *options, struct tls_root_ctx *new_ctx)
     }
 
 #ifdef ENABLE_CRYPTO_POLARSSL
-  /* Fox-IT hardening: Personalise the random by mixing in the certificate */
+  /* Personalise the random by mixing in the certificate */
   tls_ctx_personalise_random (new_ctx);
 #endif
 
-- 
1.7.5.4


