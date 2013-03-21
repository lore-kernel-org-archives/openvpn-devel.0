From: Steffan Karger <steffan.karger@...1435...>
Date: Thu, 21 Mar 2013 18:44:12 +0100
Message-ID: <1CED409804E2164C8104F9E623B08B9013B9050668@...1436...>
References: <1363624652-7001-1-git-send-email-steffan.karger@...1435...>
	<1363624652-7001-4-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1363624652-7001-4-git-send-email-steffan.karger@...1435...>
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_002_1CED409804E2164C8104F9E623B08B9013B9050668FOXDFT02FOXlo_"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 3/5] Improve verify_callback messages
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--_002_1CED409804E2164C8104F9E623B08B9013B9050668FOXDFT02FOXlo_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Attached an updated patch, which removes the stale 0 from %0x in the printf=
 format string.

-Steffan

-----Original Message-----
From: Steffan Karger=20
Sent: maandag 18 maart 2013 17:38
To: openvpn-devel@lists.sourceforge.net
Cc: Steffan Karger
Subject: [PATCH 3/5] Improve verify_callback messages

From: Steffan Karger <steffan.karger@...1435...>

Print the *flags argument, which - for PolarSSL-1.2 - contains the reasons =
that the certificate failed (pre-)verification.

Signed-off-by: Joachim Schipper <joachim.schipper@...1435...>
---
 src/openvpn/ssl_verify_polarssl.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_pol=
arssl.c
index 653248f..e07f2b3 100644
--- a/src/openvpn/ssl_verify_polarssl.c
+++ b/src/openvpn/ssl_verify_polarssl.c
@@ -63,10 +63,10 @@ verify_callback (void *session_obj, x509_cert *cert, in=
t cert_depth,
       char *subject =3D x509_get_subject(cert, &gc);
=20
       if (subject)
-	msg (D_TLS_ERRORS, "VERIFY ERROR: depth=3D%d, %s", cert_depth, subject);
+	msg (D_TLS_ERRORS, "VERIFY ERROR: depth=3D%d, flags=3D%0x, %s",=20
+cert_depth, *flags, subject);
       else
-	msg (D_TLS_ERRORS, "VERIFY ERROR: depth=3D%d, could not extract X509 "
-	      "subject string from certificate", cert_depth);
+	msg (D_TLS_ERRORS, "VERIFY ERROR: depth=3D%d, flags=3D%0x, could not extr=
act X509 "
+	      "subject string from certificate", *flags, cert_depth);
=20
       /* Leave flags set to non-zero to indicate that the cert is not ok */
     }
--
1.7.9.5


--_002_1CED409804E2164C8104F9E623B08B9013B9050668FOXDFT02FOXlo_
Content-Type: application/octet-stream;
	name="0003-Improve-verify_callback-messages.patch"
Content-Description: 0003-Improve-verify_callback-messages.patch
Content-Disposition: attachment;
	filename="0003-Improve-verify_callback-messages.patch"; size=1405;
	creation-date="Thu, 21 Mar 2013 17:41:26 GMT";
	modification-date="Thu, 21 Mar 2013 17:29:37 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4NzZmZmEwMWJlMTJmNTdmNzczNzAyODNkZTZjNDUwMjQ5NmQzNTEzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGVmZmFuIEthcmdlciA8c3RlZmZhbi5rYXJnZXJAZm94LWl0
LmNvbT4KRGF0ZTogVHVlLCAxOSBNYXIgMjAxMyAxMjozOTo0OSArMDEwMApTdWJqZWN0OiBbUEFU
Q0ggMy82XSBJbXByb3ZlIHZlcmlmeV9jYWxsYmFjayBtZXNzYWdlcwoKUHJpbnQgdGhlICpmbGFn
cyBhcmd1bWVudCwgd2hpY2ggLSBmb3IgUG9sYXJTU0wtMS4yIC0gY29udGFpbnMgdGhlIHJlYXNv
bnMgdGhhdAp0aGUgY2VydGlmaWNhdGUgZmFpbGVkIChwcmUtKXZlcmlmaWNhdGlvbi4KClNpZ25l
ZC1vZmYtYnk6IEpvYWNoaW0gU2NoaXBwZXIgPGpvYWNoaW0uc2NoaXBwZXJAZm94LWl0LmNvbT4K
LS0tCiBzcmMvb3BlbnZwbi9zc2xfdmVyaWZ5X3BvbGFyc3NsLmMgfCAgICA2ICsrKy0tLQogMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9zcmMvb3BlbnZwbi9zc2xfdmVyaWZ5X3BvbGFyc3NsLmMgYi9zcmMvb3BlbnZwbi9zc2xfdmVy
aWZ5X3BvbGFyc3NsLmMKaW5kZXggNjUzMjQ4Zi4uNWRiNGYwMiAxMDA2NDQKLS0tIGEvc3JjL29w
ZW52cG4vc3NsX3ZlcmlmeV9wb2xhcnNzbC5jCisrKyBiL3NyYy9vcGVudnBuL3NzbF92ZXJpZnlf
cG9sYXJzc2wuYwpAQCAtNjMsMTAgKzYzLDEwIEBAIHZlcmlmeV9jYWxsYmFjayAodm9pZCAqc2Vz
c2lvbl9vYmosIHg1MDlfY2VydCAqY2VydCwgaW50IGNlcnRfZGVwdGgsCiAgICAgICBjaGFyICpz
dWJqZWN0ID0geDUwOV9nZXRfc3ViamVjdChjZXJ0LCAmZ2MpOwogCiAgICAgICBpZiAoc3ViamVj
dCkKLQltc2cgKERfVExTX0VSUk9SUywgIlZFUklGWSBFUlJPUjogZGVwdGg9JWQsICVzIiwgY2Vy
dF9kZXB0aCwgc3ViamVjdCk7CisJbXNnIChEX1RMU19FUlJPUlMsICJWRVJJRlkgRVJST1I6IGRl
cHRoPSVkLCBmbGFncz0leCwgJXMiLCBjZXJ0X2RlcHRoLCAqZmxhZ3MsIHN1YmplY3QpOwogICAg
ICAgZWxzZQotCW1zZyAoRF9UTFNfRVJST1JTLCAiVkVSSUZZIEVSUk9SOiBkZXB0aD0lZCwgY291
bGQgbm90IGV4dHJhY3QgWDUwOSAiCi0JICAgICAgInN1YmplY3Qgc3RyaW5nIGZyb20gY2VydGlm
aWNhdGUiLCBjZXJ0X2RlcHRoKTsKKwltc2cgKERfVExTX0VSUk9SUywgIlZFUklGWSBFUlJPUjog
ZGVwdGg9JWQsIGZsYWdzPSV4LCBjb3VsZCBub3QgZXh0cmFjdCBYNTA5ICIKKwkgICAgICAic3Vi
amVjdCBzdHJpbmcgZnJvbSBjZXJ0aWZpY2F0ZSIsICpmbGFncywgY2VydF9kZXB0aCk7CiAKICAg
ICAgIC8qIExlYXZlIGZsYWdzIHNldCB0byBub24temVybyB0byBpbmRpY2F0ZSB0aGF0IHRoZSBj
ZXJ0IGlzIG5vdCBvayAqLwogICAgIH0KLS0gCjEuNy45LjUKCg==

--_002_1CED409804E2164C8104F9E623B08B9013B9050668FOXDFT02FOXlo_--

