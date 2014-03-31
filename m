Message-ID: <5339EFFC.6090908@...1856...>
Date: Tue, 01 Apr 2014 00:45:16 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1395017376-24554-1-git-send-email-james@...515...>
	<20140323122624.GD16637@...1296...>
	<CAA1AbxJh17KYmVU1BVa5kp4iJsUJT+xnXp0rVU_3g3c5hPnqDQ@...278...>
	<1443881.kcztAJWLkP@...1526...>
In-Reply-To: <1443881.kcztAJWLkP@...1526...>
Content-Type: multipart/mixed; boundary="------------090906060708080406040108"
Subject: Re: [Openvpn-devel] [PATCH] Set SSL_OP_NO_TICKET flag in SSL
 context for OpenSSL builds, to disable TLS stateless session resumption.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------090906060708080406040108
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

On 31-03-14 16:13, Heiko Hund wrote:
> On Sunday 23 March 2014 14:27:43 Steffan Karger wrote:
>> +    AC_EGREP_CPP(have_ssl_op_no_ticket, [
>> +    #include <openssl/ssl.h>
> 
> We just found that this breaks if the openssl headers are in a non-standard 
> place. The test above sets the -I option in CFLAGS, but not in CPPFLAGS. So, 
> maybe we should generally set -I in CPPFLAGS instead.

I'm not much of an autotools wizard, so I don't really know if there are
downsides to using CPPFLAGS insteadof CFLAGS everywhere.

The attached patch fixes your problem, but if there is someone around
with a better idea (and, preferrably, patch) to fix it, I'm all ears!

-Steffan

--------------090906060708080406040108
Content-Type: text/x-patch;
	name="0001-configure.ac-use-CPPFLAGS-for-SSL_OP_NO_TICKET-check.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-configure.ac-use-CPPFLAGS-for-SSL_OP_NO_TICKET-check.pa";
	filename*1="tch"

From ccebcab605325f98a0ff22edbbbc089194e2e0ad Mon Sep 17 00:00:00 2001
From: Steffan Karger <steffan@...1856...>
Date: Tue, 1 Apr 2014 00:33:55 +0200
Subject: [PATCH] configure.ac: use CPPFLAGS for SSL_OP_NO_TICKET check

AC_EGREP_CPP uses CPPFLAGS, not CFLAGS. Make sure the macro can find
OpenSSL by temporarily adding OPENSSL_CRYPTO_FLAGS to CPPFLAGS.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 configure.ac | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configure.ac b/configure.ac
index 7e94280..0c2abb9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -794,6 +794,8 @@ if test "${have_openssl_crypto}" = "yes"; then
 fi
 
 if test "${have_openssl_ssl}" = "yes"; then
+    saved_CPPFLAGS="${CPPFLAGS}"
+    CPPFLAGS="${CPPFLAGS} ${OPENSSL_CRYPTO_CFLAGS}"
     AC_MSG_CHECKING([for SSL_OP_NO_TICKET flag in OpenSSL])
     AC_EGREP_CPP(have_ssl_op_no_ticket, [
     #include <openssl/ssl.h>
@@ -806,6 +808,7 @@ if test "${have_openssl_ssl}" = "yes"; then
         AC_MSG_RESULT([no])
         AC_ERROR([OpenVPN 2.4+ requires SSL_OP_NO_TICKET in OpenSSL])
     ])
+    CPPFLAGS="${saved_CPPFLAGS}"
 fi
 
 AC_ARG_VAR([POLARSSL_CFLAGS], [C compiler flags for polarssl])
-- 
1.8.3.2


--------------090906060708080406040108--

