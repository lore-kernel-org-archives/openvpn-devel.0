From: Arne Schwabe <arne@...1227...>
Date: Thu,  1 Apr 2021 15:13:28 +0200
Message-Id: <20210401131337.3684-6-arne@...1227...>
In-Reply-To: <20210401131337.3684-1-arne@...1227...>
References: <20210401131337.3684-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 05/14] Remove unused variable
 pass_config_info
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl_common.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 4e1ff6c84..18bce403a 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -293,10 +293,6 @@ struct tls_options
     char *x509_username_field[2];
 #endif
 
-    /* allow openvpn config info to be
-     * passed over control channel */
-    bool pass_config_info;
-
     /* struct crypto_option flags */
     unsigned int crypto_flags;
 
-- 
2.30.1


