From: tincanteksup <tincanteksup@...277...>
Message-ID: <87a06f64-26df-d1f2-3039-08f8addfaa3b@...277...>
Date: Tue, 30 Oct 2018 23:20:32 +0000
MIME-Version: 1.0
Content-Language: en-GB
Subject: [Openvpn-devel] [PATCH] Correct error message for
 --tls-crypt-v2-genkey client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Correct error message for --tls-crypt-v2-genkey client

Signed-off-by: Richard Bonhomme <tincanteksup@...277...>
---
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 882337b2..39e8ca5f 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1087,7 +1087,7 @@ do_genkey(const struct options *options)
          {
              if (!options->tls_crypt_v2_file)
              {
-                msg(M_USAGE, "--tls-crypt-v2-gen-client-key requires a 
server key to be set via --tls-crypt-v2");
+                msg(M_USAGE, "--tls-crypt-v2-genkey requires a server 
key to be set via --tls-crypt-v2 to create a client key");
              }

 
tls_crypt_v2_write_client_key_file(options->tls_crypt_v2_genkey_file,
-- 
2.17.1


