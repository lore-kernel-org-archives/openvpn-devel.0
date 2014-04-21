Message-ID: <5354F0F2.5080200@...1856...>
Date: Mon, 21 Apr 2014 12:20:34 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1393530007-6225-1-git-send-email-steffan.karger@...1435...>	<53502E71.8070503@...515...>
	<53511F74.3010708@...1435...>	<53528943.3090205@...1435...>
	<20140421090448.GS16637@...1296...>
In-Reply-To: <20140421090448.GS16637@...1296...>
Content-Type: multipart/mixed; boundary="------------010905090904060301060301"
Subject: Re: [Openvpn-devel] [PATCH] PolarSSL 1.3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------010905090904060301060301
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

On 21-04-14 11:04, Gert Doering wrote:
> When test-building, it seems that there is a patch missing to the plugin 
> API bits...

Ah, right, I usually compile polar builds without the plugin api.
Attached a patch that should fix this. It compiles and passes client_t
tests, but I don't have plugin tests to really verify everything works...

-Steffan

--------------010905090904060301060301
Content-Type: text/x-patch;
	name="0001-Update-openvpn-plugin.h-for-PolarSSL-1.3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-Update-openvpn-plugin.h-for-PolarSSL-1.3.patch"

From 491fd5e253a62940caafd973377019be1e3164f3 Mon Sep 17 00:00:00 2001
From: Steffan Karger <steffan@...1856...>
Date: Mon, 21 Apr 2014 11:52:51 +0200
Subject: [PATCH] Update openvpn-plugin.h for PolarSSL 1.3.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 include/openvpn-plugin.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/openvpn-plugin.h b/include/openvpn-plugin.h
index 03da92a..5f2d407 100644
--- a/include/openvpn-plugin.h
+++ b/include/openvpn-plugin.h
@@ -29,10 +29,10 @@
 
 #ifdef ENABLE_SSL
 #ifdef ENABLE_CRYPTO_POLARSSL
-#include <polarssl/x509.h>
+#include <polarssl/x509_crt.h>
 #ifndef __OPENVPN_X509_CERT_T_DECLARED
 #define __OPENVPN_X509_CERT_T_DECLARED
-typedef x509_cert openvpn_x509_cert_t;
+typedef x509_crt openvpn_x509_cert_t;
 #endif
 #else
 #include <openssl/x509.h>
-- 
1.8.3.2


--------------010905090904060301060301--

