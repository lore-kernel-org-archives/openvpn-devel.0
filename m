From: Yegor Yefremov <yegorslists@...1030...>
Date: Mon, 20 Apr 2015 16:30:56 +0200
Message-Id: <1429540256-4906-1-git-send-email-yegorslists@...1030...>
Subject: [Openvpn-devel] [PATCH] cert_data: fix memory leak
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

Release pCertName, if SecCertificateCopyValues() fails.

Found via cppcheck.

Signed-off-by: Yegor Yefremov <yegorslists@...1030...>
Cc: Vasily Kulikov <segoon@...2008...>
---
 contrib/keychain-mcd/cert_data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/keychain-mcd/cert_data.c b/contrib/keychain-mcd/cert_data.c
index f2b33ed..a04bf79 100644
--- a/contrib/keychain-mcd/cert_data.c
+++ b/contrib/keychain-mcd/cert_data.c
@@ -146,6 +146,7 @@ CFArrayRef GetFieldsFromCertificate(SecCertificateRef certificate, CFTypeRef oid
       printErrorMsg("GetFieldsFromCertificate: SecCertificateCopyValues", error);
       CFRelease(keySelection);
       CFRelease(fields);
+      destroyCertName(pCertName);
       return NULL;
   }
   CFDictionaryRef vals = CFDictionaryGetValue(dict, oid);
-- 
2.1.0


