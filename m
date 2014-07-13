Message-ID: <53C251E2.7050605@...1856...>
Date: Sun, 13 Jul 2014 11:31:14 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <53BF9998.5020906@...1921...>
	<53C02A4E.6040103@...1147...>	<53C02E63.9070909@...1856...>
	<53C07082.8060906@...1147...>	<306985396.19324.1405156126494.JavaMail.zimbra@...1795...>	<20140712094130.GM1118@...1296...>	<63900614.19358.1405161674053.JavaMail.zimbra@...1795...>	<20140712113109.GQ1118@...1296...>	<1555229996.19407.1405169721263.JavaMail.zimbra@...1795...>
	<20140712135046.GS1118@...1296...>
In-Reply-To: <20140712135046.GS1118@...1296...>
Content-Type: multipart/mixed; boundary="------------060100010308000100080804"
Subject: Re: [Openvpn-devel] more SSL_OP_NO_TICKET fallout
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
--------------060100010308000100080804
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi,

Oh, joy, more SSL_OP_NO_TICKET fallout. Changing the subject to
separate this discussion from the original thread about topology subnet.

On 12-07-14 15:50, Gert Doering wrote:
> On Sat, Jul 12, 2014 at 02:55:21PM +0200, David Sommerseth wrote:
>>> Well, OpenSSL considers this a "feature", not an "issue"... and
>>> being able to turn off session resumption is also considered a
>>> "feature"...
>> 
>> Ahh, right!
>> 
>> I thought this was related to a CVE, but it seems not, according
>> the OpenSSL changelog I found on the net [1].  SSL_OP_NO_TICKET
>> comes with the implementation of RFC4507, which was introduced in
>> 0.9.8f.  I just double checked EL5, and it uses 0.9.8e as the
>> base version.  According to the RPM changelog, I don't see that
>> RFC4507 has ever been backported.
> 
> Ah.  So if that is correct, our simplistic implementation "if it is
> not there, just #define SSL_OP_NO_TICKET 0" would be perfectly safe
> in this regard, then.
> 
>> But it would be good if others can double this and see if I've
>> understood this correctly, just so I don't say anything wrong.
> 
> Indeed :-) - Steffann?

Yes, the SSL_OP_NO_TICKET flag was introduced together with the
feature it disables (stateless session resumption). Sane backporters
would also backport the flag when backporting the feature. So using
the same "#define SSL_OP_NO_TICKET 0"-construction as in 2.3 should be
fine.

I think this is the way to go for 2.4 if we want to support RHEL5
until their end-of-production. The alternatives would be to either
drop support for RHEL5 (seems unreasonable for such a silly fix) or
keep maintaining 2.3 until RHEL5 end-of-support (much more work).

Attached a patch that adds the 2.3 #ifdef construction to -master too.
I updated the message to reflect that this is in master too now, and
include the string '0.9.8', which should help with stripping this out
again if 0.9.8-support is ever dropped.

- -Steffan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJTwlHPAAoJEJgCyj0AftKImwcH/0mCSnA2LNFDP0542/yRnFTc
mwufEafiZ936xY0eEYKERNMuISucAoHiOGrp+5EqSHSoGqX7TTkxZ3hIBVgQ4L37
p4b9pbkXNj5J4RelcFkH78lNKnNr9AnU5JHO1SJEO1qKAY0q5ypRclvTbytcN8o6
6UVnRzcjmDnyUOgPrSct+JK7Rm9BVCpDU2a7PK0fGASs3qS9NZOmBSDV9Eg2P5tn
IdvoZUrI9ZPNLDWCoDpMOkpsvQPl2BeMJ0t5Ib/LRSE8dbvfxg+GldYYQ3YA4uu8
xylgnvNTwi1GfFEicwX+9g8NEkqDKmNJd6k/OzclVyhWi3209E6prwk20NX7RDs=
=u8ld
-----END PGP SIGNATURE-----

--------------060100010308000100080804
Content-Type: text/x-patch;
	name="0001-Define-dummy-SSL_OP_NO_TICKET-flag-if-not-present-in.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-Define-dummy-SSL_OP_NO_TICKET-flag-if-not-present-in.pa";
	filename*1="tch"

From bbe56efb085138dca65dfe15b480eab47074b7e2 Mon Sep 17 00:00:00 2001
From: Steffan Karger <steffan@...1856...>
Date: Sun, 13 Jul 2014 11:26:32 +0200
Subject: [PATCH] Define dummy SSL_OP_NO_TICKET flag if not present in OpenSSL.

This restores support for pre-0.9.8f OpenSSL versions, which do not include
stateless session resumption, and the accompanying SSL_OP_NO_TICKET flag.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 configure.ac              | 19 -------------------
 src/openvpn/ssl_openssl.h | 11 +++++++++++
 2 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/configure.ac b/configure.ac
index 117eaf6..0d0ab88 100644
--- a/configure.ac
+++ b/configure.ac
@@ -814,25 +814,6 @@ if test "${have_openssl_crypto}" = "yes"; then
 	LIBS="${saved_LIBS}"
 fi
 
-if test "${enable_ssl}" = "yes" && test "${with_crypto_library}" = "openssl";
-then
-    saved_CPPFLAGS="${CPPFLAGS}"
-    CPPFLAGS="${CPPFLAGS} ${OPENSSL_CRYPTO_CFLAGS}"
-    AC_MSG_CHECKING([for SSL_OP_NO_TICKET flag in OpenSSL])
-    AC_EGREP_CPP(have_ssl_op_no_ticket, [
-    #include <openssl/ssl.h>
-    #ifdef SSL_OP_NO_TICKET
-    have_ssl_op_no_ticket
-    #endif
-    ], [
-        AC_MSG_RESULT([yes])
-    ], [
-        AC_MSG_RESULT([no])
-        AC_ERROR([OpenVPN 2.4+ requires SSL_OP_NO_TICKET in OpenSSL])
-    ])
-    CPPFLAGS="${saved_CPPFLAGS}"
-fi
-
 AC_ARG_VAR([POLARSSL_CFLAGS], [C compiler flags for polarssl])
 AC_ARG_VAR([POLARSSL_LIBS], [linker flags for polarssl])
 have_polarssl_ssl="yes"
diff --git a/src/openvpn/ssl_openssl.h b/src/openvpn/ssl_openssl.h
index fc2052c..97dc742 100644
--- a/src/openvpn/ssl_openssl.h
+++ b/src/openvpn/ssl_openssl.h
@@ -33,6 +33,17 @@
 #include <openssl/ssl.h>
 
 /**
+ * SSL_OP_NO_TICKET tells OpenSSL to disable "stateless session resumption",
+ * as this is something we do not want nor need, but could potentially be
+ * used for a future attack.  For compatibility reasons we keep building if the
+ * OpenSSL version is too old (pre-0.9.8f) to support stateless session
+ * resumption (and the accompanying SSL_OP_NO_TICKET flag).
+ */
+#ifndef SSL_OP_NO_TICKET
+# define SSL_OP_NO_TICKET 0
+#endif
+
+/**
  * Structure that wraps the TLS context. Contents differ depending on the
  * SSL library used.
  */
-- 
1.9.1


--------------060100010308000100080804
Content-Type: application/pgp-signature;
	name="0001-Define-dummy-SSL_OP_NO_TICKET-flag-if-not-present-in.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename*0="0001-Define-dummy-SSL_OP_NO_TICKET-flag-if-not-present-in.pa";
	filename*1="tch.sig"

iQEcBAABAgAGBQJTwlHiAAoJEJgCyj0AftKInpoH/jDENpjel4wIqM8UDnk9raR6Jwh2e2Xm
BiUVPPJs1PSENVttB50xnlK8LyPYTbKSqmTPpzxseSDV6PxPSkycduRsy7m5jqjrdyhXX58L
MzhsCV+tRt0LCHxoeT0PVvK8XgPNOk5e9MUvHJ96occ/7DKPXrw5Oz8YlOFH4Drp6TCrWEeH
i7Al0Mx3PtqCG6NwZn2KDnudqlt0BbRZ9WiCFqrh86y+Kmu9qlFNbiuw0P8SVs7xdjgzUXZE
hI6jyDRvorKY/8SAFHDNj3FTLD0GJpPtSGopc9tdPD9E8W1fmu6jlYmN0xFEyyIeMVHdGSeG
Jz7qs56ffUOryQ1rLC7RrOE=
--------------060100010308000100080804--

