From: Steffan Karger <steffan@...1856...>
Date: Thu,  7 Jan 2016 21:22:12 +0100
Message-Id: <1452198132-25560-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] polarssl: use wrappers to access md_info_t
	member functions
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

The md_info_t will become an opaque struct in mbed TLS 2.x, start using
the wrapper function in preparation to a future upgrade to 2.x.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto_polarssl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/crypto_polarssl.c b/src/openvpn/crypto_polarssl.c
index cd50fe5..407a176 100644
--- a/src/openvpn/crypto_polarssl.c
+++ b/src/openvpn/crypto_polarssl.c
@@ -214,7 +214,7 @@ show_available_digests ()
 
       if (info)
 	printf ("%s %d bit default key\n",
-		info->name, info->size * 8);
+		md_get_name(info), md_get_size(info) * 8);
       digests++;
     }
   printf ("\n");
@@ -576,10 +576,10 @@ md_kt_get (const char *digest)
   md = md_info_from_string(digest);
   if (!md)
     msg (M_FATAL, "Message hash algorithm '%s' not found", digest);
-  if (md->size > MAX_HMAC_KEY_LENGTH)
+  if (md_get_size(md) > MAX_HMAC_KEY_LENGTH)
     msg (M_FATAL, "Message hash algorithm '%s' uses a default hash size (%d bytes) which is larger than " PACKAGE_NAME "'s current maximum hash size (%d bytes)",
 	 digest,
-	 md->size,
+	 md_get_size(md),
 	 MAX_HMAC_KEY_LENGTH);
   return md;
 }
-- 
2.5.0


