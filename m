From: Arne Schwabe <arne@...1227...>
Date: Wed,  1 Dec 2021 19:07:27 +0100
Message-Id: <20211201180727.2496903-9-arne@...1227...>
In-Reply-To: <20211201180727.2496903-1-arne@...1227...>
References: <20211201180727.2496903-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 9/9] Initialise kt_cipher even when no
 crypto is enabled
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

This avoids special casing the cipher none/auth none case in other
parts, e.g. in the upcoming buffer/frame rework.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 6c82c0dca..2c18313d6 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3068,9 +3068,15 @@ do_init_finalize_tls_frame(struct context *c)
  * No encryption or authentication.
  */
 static void
-do_init_crypto_none(const struct context *c)
+do_init_crypto_none(struct context *c)
 {
     ASSERT(!c->options.test_crypto);
+
+    /* Initialise key_type with auth/cipher "none", so the key_type struct is
+     * valid */
+    init_key_type(&c->c1.ks.key_type, "none", "none",
+                  c->options.test_crypto, true);
+
     msg(M_WARN,
         "******* WARNING *******: All encryption and authentication features "
         "disabled -- All data will be tunnelled as clear text and will not be "
-- 
2.33.0


