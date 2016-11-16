From: Steffan Karger <steffan.karger@...1435...>
Date: Wed, 16 Nov 2016 14:23:04 +0100
Message-ID: <1479302584-28598-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1478636302-9678-2-git-send-email-steffan.karger@...1435...>
References: <1478636302-9678-2-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Remove unused variables from
	do_init_crypto_static()
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

Commit 28c115e4 refactored the key loading, but forgot to remove these
variables from do_init_crypto_static().  Fix that.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/init.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index d6733f0..c42aed2 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2132,9 +2132,6 @@ do_init_crypto_static (struct context *c, const unsigned int flags)
 
   if (!key_ctx_bi_defined (&c->c1.ks.static_key))
     {
-      struct key2 key2;
-      struct key_direction_state kds;
-
       /* Get cipher & hash algorithms */
       init_key_type (&c->c1.ks.key_type, options->ciphername, options->authname,
 		     options->keysize, options->test_crypto, true);
-- 
2.7.4


