From: Steffan Karger <steffan.karger@...1435...>
Date: Wed, 20 Mar 2013 19:52:47 +0100
Message-ID: <1CED409804E2164C8104F9E623B08B9013B904FFD9@...1436...>
References: <1363624652-7001-1-git-send-email-steffan.karger@...1435...>
	<1363624652-7001-2-git-send-email-steffan.karger@...1435...>
	<20130319142655.GX953@...1296...>
In-Reply-To: <20130319142655.GX953@...1296...>
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_002_1CED409804E2164C8104F9E623B08B9013B904FFD9FOXDFT02FOXlo_"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 1/5] PolarSSL-1.2 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--_002_1CED409804E2164C8104F9E623B08B9013B904FFD9FOXDFT02FOXlo_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Attached a patch for the second point you make. It was a pre-existing bug w=
here the autoconf script was not equipped to detect incorrectly compiled po=
larssl builds, e.g. without pkcs11 support.

I'm still working on the first (polarssl-blowfish) point, need to do some m=
ore testing first on that one.

Regards,
-Steffan

-----Original Message-----
From: Gert Doering [mailto:gert@...1296...]=20
Sent: dinsdag 19 maart 2013 15:27
To: Steffan Karger
Cc: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] [PATCH 1/5] PolarSSL-1.2 support

Hi,

On Mon, Mar 18, 2013 at 05:37:28PM +0100, steffan.karger@...1435... wrote:
> From: Steffan Karger <steffan.karger@...1435...>
>=20
> Add support for PolarSSL-1.2, which has changed the API in several places.
> This is a minimal port, new features have not been enabled. Only=20
> PolarSSL
> 1.2.5 and newer are accepted, as earlier versions contain unresolved
> (security) issues.

NAK, actually, for two reasons:=20=20

 - there is "something wrong" with the blowfish support - patching=20
   release/2.3 in git with these 5 patches and compiling with polar 1.2.5
   creates a binary that is not interoperating with openssl-compiled
   openvpn (cipher blowfish-cbc on the polar side, bf-cbc on openssl) - it=
=20
   negotiates just fine, but data packets cannot be decrypted

14:23 <@dazo> Tue Mar 19 14:16:08 2013 Authenticate/Decrypt packet error:=20
              cipher final failed

 - when configuring with --enable-pkcs11, compilation fails

14:17 <@dazo> ssl_polarssl.h:69:5: error: expected specifier-qualifier-list=
=20
              before \u2018pkcs11_context\u2019

(I'm just relaying, David did the actual testing... my buildbot box is stil=
l busy trying to compile polar 1.2.6...)

gert
--
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--_002_1CED409804E2164C8104F9E623B08B9013B904FFD9FOXDFT02FOXlo_
Content-Type: application/octet-stream;
	name="0001-Fixed-autoconf-script-to-properly-detect-missing-pkc.patch"
Content-Description: 0001-Fixed-autoconf-script-to-properly-detect-missing-pkc.patch
Content-Disposition: attachment;
	filename="0001-Fixed-autoconf-script-to-properly-detect-missing-pkc.patch";
	size=2616; creation-date="Wed, 20 Mar 2013 18:52:13 GMT";
	modification-date="Wed, 20 Mar 2013 18:42:06 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5Y2M3NGFlMDg2YjMxNTJhNjVlMzI1MDY4MjIxMDgzNTZiZTcwNzcxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGVmZmFuIEthcmdlciA8c3RlZmZhbi5rYXJnZXJAZm94LWl0
LmNvbT4KRGF0ZTogV2VkLCAyMCBNYXIgMjAxMyAxOTo0MToyOSArMDEwMApTdWJqZWN0OiBbUEFU
Q0hdIEZpeGVkIGF1dG9jb25mIHNjcmlwdCB0byBwcm9wZXJseSBkZXRlY3QgbWlzc2luZyBwa2Nz
MTEgd2l0aAogcG9sYXJzc2wuCgpXaGVuIHBvbGFyc3NsIGlzIGNvbXBpbGVkIHdpdGhvdXQgcGtj
czExIHN1cHBvcnQsIG9yIGEgcmVxdWlyZWQKcGtjczExLWhlbHBlciBsaWJyYXJ5IGlzIG1pc3Np
bmcsIGNvbmZpZ3VyZSB3aWxsIG5vdyBpc3N1ZSBhbiBlcnJvci4KClNpZ25lZC1vZmYtYnk6IFN0
ZWZmYW4gS2FyZ2VyIDxzdGVmZmFuLmthcmdlckBmb3gtaXQuY29tPgotLS0KIGNvbmZpZ3VyZS5h
YyB8ICAgNTQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNDMgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvY29uZmlndXJlLmFjIGIvY29uZmlndXJlLmFjCmluZGV4IDc4NWZjNGUu
LjU1ZTE0OTQgMTAwNjQ0Ci0tLSBhL2NvbmZpZ3VyZS5hYworKysgYi9jb25maWd1cmUuYWMKQEAg
LTcyNiw2ICs3MjYsMTMgQEAgY2FzZSAiJHt3aXRoX21lbV9jaGVja30iIGluCiBlc2FjCiAKIFBL
R19DSEVDS19NT0RVTEVTKAorCVtQS0NTMTFfSEVMUEVSXSwKKwlbbGlicGtjczExLWhlbHBlci0x
ID49IDEuMDJdLAorCVtoYXZlX3BrY3MxMV9oZWxwZXI9InllcyJdLAorCVtdCispCisKK1BLR19D
SEVDS19NT0RVTEVTKAogCVtPUEVOU1NMX0NSWVBUT10sCiAJW2xpYmNyeXB0byA+PSAwLjkuNl0s
CiAJW2hhdmVfb3BlbnNzbF9jcnlwdG89InllcyJdLApAQCAtNzg5LDkgKzc5NiwxMSBAQCBpZiB0
ZXN0IC16ICIke1BPTEFSU1NMX0xJQlN9IjsgdGhlbgogCQkJCVtwb2xhcnNzbF0sCiAJCQkJW2Fl
c19jcnlwdF9jYmNdLAogCQkJCSwKLQkJCQlbaGF2ZV9wb2xhcnNzbF9jcnlwdG89Im5vIl0KKwkJ
CQlbaGF2ZV9wb2xhcnNzbF9jcnlwdG89Im5vIl0sCisJCQkJWyR7UEtDUzExX0hFTFBFUl9MSUJT
fV0KIAkJCSkKLQkJXQorCQldLAorCQlbJHtQS0NTMTFfSEVMUEVSX0xJQlN9XQogCSkKIGZpCiAK
QEAgLTgwNiwxNCArODE1LDQ0IEBAIGlmIHRlc3QgIiR7d2l0aF9jcnlwdG9fbGlicmFyeX0iID0g
InBvbGFyc3NsIiA7IHRoZW4KIAkJCV1dLAogCQkJW1sKICNpZiBQT0xBUlNTTF9WRVJTSU9OX05V
TUJFUiA8IDB4MDEwMjA1MDAKLSNlcnJvciBpbnZhbGlkIHZlcnNpb24gUG9sYXJTU0wtMS4yLjUg
b3IgbmV3ZXIgcmVxdWlyZWQKKyNlcnJvciBpbnZhbGlkIHZlcnNpb24KICNlbmRpZgogCQkJXV0K
IAkJKV0sCiAJCVtBQ19NU0dfUkVTVUxUKFtva10pXSwKLQkJW0FDX01TR19FUlJPUihbaW52YWxp
ZCBwb2xhcnNzbCB2ZXJzaW9uXSldCisJCVtBQ19NU0dfRVJST1IoW1BvbGFyU1NMIDEuMi41IG9y
IG5ld2VyIHJlcXVpcmVkXSldCiAJKQogCUNGTEFHUz0iJHtvbGRfQ0ZMQUdTfSIKKworCXBvbGFy
c3NsX3dpdGhfcGtjczExPSJubyIKKwlBQ19DT01QSUxFX0lGRUxTRSgKKwkJW0FDX0xBTkdfUFJP
R1JBTSgKKwkJCVtbCisjaW5jbHVkZSA8cG9sYXJzc2wvY29uZmlnLmg+CisJCQldXSwKKwkJCVtb
CisjaWZuZGVmIFBPTEFSU1NMX1BLQ1MxMV9DCisjZXJyb3IgcGtjczExIHdyYXBwZXIgbWlzc2lu
ZworI2VuZGlmCisJCQldXQorCQkpXSwKKwkJcG9sYXJzc2xfd2l0aF9wa2NzMTE9InllcyIpCisK
KwlBQ19NU0dfQ0hFQ0tJTkcoW3BvbGFyc3NsIHBrY3MxMSBzdXBwb3J0XSkKKwlpZiB0ZXN0ICIk
e2VuYWJsZV9wa2NzMTF9IiA9ICJ5ZXMiOyB0aGVuCisJCWlmIHRlc3QgIiR7cG9sYXJzc2xfd2l0
aF9wa2NzMTF9IiA9ICJ5ZXMiOyB0aGVuCisJCQlBQ19NU0dfUkVTVUxUKFtva10pCisJCWVsc2UK
KwkJCUFDX01TR19FUlJPUihbcG9sYXJzc2wgaGFzIG5vIHBrY3MxMSB3cmFwcGVyIGNvbXBpbGVk
IGluXSkKKwkJZmkKKwllbHNlCisJCWlmIHRlc3QgIiR7cG9sYXJzc2xfd2l0aF9wa2NzMTF9IiAh
PSAieWVzIjsgdGhlbgorCQkJQUNfTVNHX1JFU1VMVChbb2tdKQorCQllbHNlCisJCQlBQ19NU0df
RVJST1IoW1BvbGFyU1NMIGNvbXBpbGVkIHdpdGggUEtDUzExLCB3aGlsZSBPcGVuVlBOIGlzIG5v
dF0pCisJCWZpCisJZmkKKwogZmkKIAogQUNfQVJHX1ZBUihbTFpPX0NGTEFHU10sIFtDIGNvbXBp
bGVyIGZsYWdzIGZvciBsem9dKQpAQCAtODU2LDEzICs4OTUsNiBAQCBpZiB0ZXN0ICIke2hhdmVf
bHpvfSIgPSAieWVzIjsgdGhlbgogCUNGTEFHUz0iJHtzYXZlZF9DRkxBR1N9IgogZmkKIAotUEtH
X0NIRUNLX01PRFVMRVMoCi0JW1BLQ1MxMV9IRUxQRVJdLAotCVtsaWJwa2NzMTEtaGVscGVyLTEg
Pj0gMS4wMl0sCi0JW2hhdmVfcGtjczExX2hlbHBlcj0ieWVzIl0sCi0JW10KLSkKLQogQUNfTVNH
X0NIRUNLSU5HKFtnaXQgY2hlY2tvdXRdKQogR0lUX0NIRUNLT1VUPSJubyIKIGlmIHRlc3QgLW4g
IiR7R0lUfSIgLWEgLWQgIiR7c3JjZGlyfS8uZ2l0IjsgdGhlbgotLSAKMS43LjkuNQoK

--_002_1CED409804E2164C8104F9E623B08B9013B904FFD9FOXDFT02FOXlo_--

