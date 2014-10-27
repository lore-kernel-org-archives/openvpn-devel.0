Message-ID: <544EB12E.40200@...1856...>
Date: Mon, 27 Oct 2014 21:55:10 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1414269324-14102-1-git-send-email-steffan@...1856...>
	<1414269324-14102-7-git-send-email-steffan@...1856...>
	<544EA7DB.1000801@...1227...>
In-Reply-To: <544EA7DB.1000801@...1227...>
Content-Type: multipart/mixed; boundary="------------000804080401010205080306"
Subject: Re: [Openvpn-devel] [PATCH 6/6] openssl: add more descriptive
 message for "no shared cipher" error
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------000804080401010205080306
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit



On 27-10-14 21:15, Arne Schwabe wrote:
> Am 25.10.14 22:35, schrieb Steffan Karger:
>> Overzealous users using the --tls-cipher option, or users with actual
>> incompatible crypto libaries often waste quite some time debugging the
>> "no shared cipher" error from openssl. See e.g. trac ticket #359:
>> https://community.openvpn.net/openvpn/ticket/359
>>
>> This change adds a more clear, verb 1 error message reporting the problem
>> directly to the user, instead of just printing the openssl error.
>>
>> S
> ACK.

Thanks. Attached a v2 of this patch. Only difference is that adds an
#include <openssl/err.h> (and reorders the openssl includes since I was
touching them now anyway). On my machine (ubuntu 14.04) both gcc and
clang compile happily without the extra include, but Arne reported
(off-list) that without the include it breaks while compiling for Android.

-Steffan

--------------000804080401010205080306
Content-Type: text/x-patch;
	name="0006-openssl-add-more-descriptive-message-for-no-shared-c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0006-openssl-add-more-descriptive-message-for-no-shared-c.pa";
	filename*1="tch"

From 12aa3470bb5881f3b4fddab4d13852b1e38e3715 Mon Sep 17 00:00:00 2001
From: Steffan Karger <steffan@...1856...>
Date: Sat, 25 Oct 2014 20:49:26 +0200
Subject: [PATCH 6/6] openssl: add more descriptive message for "no shared
 cipher" error

Overzealous users using the --tls-cipher option, or users with actual
incompatible crypto libaries often waste quite some time debugging the
"no shared cipher" error from openssl. See e.g. trac ticket #359:
https://community.openvpn.net/openvpn/ticket/359

This change adds a more clear, verb 1 error message reporting the problem
directly to the user, instead of just printing the openssl error.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto_openssl.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 114a856..cc00a7d 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -42,9 +42,12 @@
 #include "integer.h"
 #include "crypto.h"
 #include "crypto_backend.h"
-#include <openssl/objects.h>
-#include <openssl/evp.h>
+
 #include <openssl/des.h>
+#include <openssl/err.h>
+#include <openssl/evp.h>
+#include <openssl/objects.h>
+#include <openssl/ssl.h>
 
 /*
  * Check for key size creepage.
@@ -201,7 +204,18 @@ crypto_print_openssl_errors(const unsigned int flags) {
   size_t err = 0;
 
   while ((err = ERR_get_error ()))
-    msg (flags, "OpenSSL: %s", ERR_error_string (err, NULL));
+    {
+      /* Be more clear about frequently occurring "no shared cipher" error */
+      if (err == ERR_PACK(ERR_LIB_SSL,SSL_F_SSL3_GET_CLIENT_HELLO,
+	  SSL_R_NO_SHARED_CIPHER))
+	{
+	  msg (D_CRYPT_ERRORS, "TLS error: The server has no TLS ciphersuites "
+	      "in common with the client. Your --tls-cipher setting might be "
+	      "too restrictive.");
+	}
+
+      msg (flags, "OpenSSL: %s", ERR_error_string (err, NULL));
+    }
 }
 
 
-- 
1.9.1


--------------000804080401010205080306--

