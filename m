From: Arne Schwabe <arne@...1227...>
Date: Mon, 13 Dec 2021 16:09:50 +0100
Message-Id: <20211213150950.3993881-1-arne@...1227...>
In-Reply-To: <20211201180727.2496903-1-arne@...1227...>
References: <20211201180727.2496903-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Move deprecation of SWEET32/64bit block
 size ciphers to 2.7
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

We originally wanted to deprecated these ciphers (especially BF-CBC) with
2.6 but currently these ciphers are still too widespread to make this
transition for 2.6.
---
 src/openvpn/crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 36f880433..c4cf72a55 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -721,7 +721,7 @@ warn_insecure_key_type(const char *ciphername)
             " bit (%d bit).  This allows attacks like SWEET32.  Mitigate by "
             "using a --cipher with a larger block size (e.g. AES-256-CBC). "
             "Support for these insecure ciphers will be removed in "
-            "OpenVPN 2.6.",
+            "OpenVPN 2.7.",
             ciphername, cipher_kt_block_size(ciphername)*8);
     }
 }
-- 
2.33.0


