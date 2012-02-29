From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:11:40 +0200
Message-Id: <1330546342-17794-11-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 10/52] fixup: init.c: add missing
	conditional for ENABLE_CLIENT_CR
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
To: 
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 init.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/init.c b/init.c
index d2ad318..b8f57b2 100644
--- a/init.c
+++ b/init.c
@@ -2282,9 +2282,11 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
   to.x509_track = options->x509_track;
 #endif
 
+#if P2MP
 #ifdef ENABLE_CLIENT_CR
   to.sci = &options->sc_info;
 #endif
+#endif
 
   /* TLS handshake authentication (--tls-auth) */
   if (options->tls_auth_file)
-- 
1.7.3.4


