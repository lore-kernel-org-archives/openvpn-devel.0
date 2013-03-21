From: Steffan Karger <steffan.karger@...1435...>
Date: Thu, 21 Mar 2013 18:48:20 +0100
Message-ID: <1CED409804E2164C8104F9E623B08B9013B9050669@...1436...>
References: <1363624652-7001-1-git-send-email-steffan.karger@...1435...>
	<1363624652-7001-2-git-send-email-steffan.karger@...1435...>
	<20130319142655.GX953@...1296...>
	<1CED409804E2164C8104F9E623B08B9013B904FFD9@...1436...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B9013B904FFD9@...1436...>
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_002_1CED409804E2164C8104F9E623B08B9013B9050669FOXDFT02FOXlo_"
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
To: Steffan Karger <steffan.karger@...1435...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--_002_1CED409804E2164C8104F9E623B08B9013B9050669FOXDFT02FOXlo_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Attached an updated version, which will not fail when polarssl is not insta=
lled in some system library path.

Sorry for the spam!

-Steffan

-----Original Message-----
From: Steffan Karger [mailto:steffan.karger@...1435...]=20
Sent: woensdag 20 maart 2013 19:53
To: Gert Doering
Cc: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] [PATCH 1/5] PolarSSL-1.2 support

Hi,

Attached a patch for the second point you make. It was a pre-existing bug w=
here the autoconf script was not equipped to detect incorrectly compiled po=
larssl builds, e.g. without pkcs11 support.

I'm still working on the first (polarssl-blowfish) point, need to do some m=
ore testing first on that one.

Regards,
-Steffan

-----Original Message-----
From: Gert Doering [mailto:gert@...1296...]
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

--_002_1CED409804E2164C8104F9E623B08B9013B9050669FOXDFT02FOXlo_
Content-Type: application/octet-stream;
	name="0006-Fixed-autoconf-script-to-properly-detect-missing-pkc.patch"
Content-Description: 0006-Fixed-autoconf-script-to-properly-detect-missing-pkc.patch
Content-Disposition: attachment;
	filename="0006-Fixed-autoconf-script-to-properly-detect-missing-pkc.patch";
	size=2620; creation-date="Thu, 21 Mar 2013 17:48:17 GMT";
	modification-date="Thu, 21 Mar 2013 17:29:37 GMT"
Content-Transfer-Encoding: base64

RnJvbSA2MDU3MDBkNzYxYjI2YTY5YTdjODU2YmIxNGU1MTg0YTkwMmUyMzA4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGVmZmFuIEthcmdlciA8c3RlZmZhbi5rYXJnZXJAZm94LWl0
LmNvbT4KRGF0ZTogVGh1LCAyMSBNYXIgMjAxMyAxODoxNjozOSArMDEwMApTdWJqZWN0OiBbUEFU
Q0ggNi82XSBGaXhlZCBhdXRvY29uZiBzY3JpcHQgdG8gcHJvcGVybHkgZGV0ZWN0IG1pc3Npbmcg
cGtjczExCiB3aXRoIHBvbGFyc3NsLgoKV2hlbiBwb2xhcnNzbCBpcyBjb21waWxlZCB3aXRob3V0
IHBrY3MxMSBzdXBwb3J0LCBvciBhIHJlcXVpcmVkCnBrY3MxMS1oZWxwZXIgbGlicmFyeSBpcyBt
aXNzaW5nLCBjb25maWd1cmUgd2lsbCBub3cgaXNzdWUgYW4gZXJyb3IuCgpTaWduZWQtb2ZmLWJ5
OiBTdGVmZmFuIEthcmdlciA8c3RlZmZhbi5rYXJnZXJAZm94LWl0LmNvbT4KLS0tCiBjb25maWd1
cmUuYWMgfCAgIDU0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDQzIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2NvbmZpZ3VyZS5hYyBiL2NvbmZpZ3VyZS5hYwppbmRleCA3ODVm
YzRlLi43YjM1ZTUwIDEwMDY0NAotLS0gYS9jb25maWd1cmUuYWMKKysrIGIvY29uZmlndXJlLmFj
CkBAIC03MjYsNiArNzI2LDEzIEBAIGNhc2UgIiR7d2l0aF9tZW1fY2hlY2t9IiBpbgogZXNhYwog
CiBQS0dfQ0hFQ0tfTU9EVUxFUygKKwlbUEtDUzExX0hFTFBFUl0sCisJW2xpYnBrY3MxMS1oZWxw
ZXItMSA+PSAxLjAyXSwKKwlbaGF2ZV9wa2NzMTFfaGVscGVyPSJ5ZXMiXSwKKwlbXQorKQorCitQ
S0dfQ0hFQ0tfTU9EVUxFUygKIAlbT1BFTlNTTF9DUllQVE9dLAogCVtsaWJjcnlwdG8gPj0gMC45
LjZdLAogCVtoYXZlX29wZW5zc2xfY3J5cHRvPSJ5ZXMiXSwKQEAgLTc4OSw5ICs3OTYsMTEgQEAg
aWYgdGVzdCAteiAiJHtQT0xBUlNTTF9MSUJTfSI7IHRoZW4KIAkJCQlbcG9sYXJzc2xdLAogCQkJ
CVthZXNfY3J5cHRfY2JjXSwKIAkJCQksCi0JCQkJW2hhdmVfcG9sYXJzc2xfY3J5cHRvPSJubyJd
CisJCQkJW2hhdmVfcG9sYXJzc2xfY3J5cHRvPSJubyJdLAorCQkJCVske1BLQ1MxMV9IRUxQRVJf
TElCU31dCiAJCQkpCi0JCV0KKwkJXSwKKwkJWyR7UEtDUzExX0hFTFBFUl9MSUJTfV0KIAkpCiBm
aQogCkBAIC04MDYsMTQgKzgxNSw0NCBAQCBpZiB0ZXN0ICIke3dpdGhfY3J5cHRvX2xpYnJhcnl9
IiA9ICJwb2xhcnNzbCIgOyB0aGVuCiAJCQldXSwKIAkJCVtbCiAjaWYgUE9MQVJTU0xfVkVSU0lP
Tl9OVU1CRVIgPCAweDAxMDIwNTAwCi0jZXJyb3IgaW52YWxpZCB2ZXJzaW9uIFBvbGFyU1NMLTEu
Mi41IG9yIG5ld2VyIHJlcXVpcmVkCisjZXJyb3IgaW52YWxpZCB2ZXJzaW9uCiAjZW5kaWYKIAkJ
CV1dCiAJCSldLAogCQlbQUNfTVNHX1JFU1VMVChbb2tdKV0sCi0JCVtBQ19NU0dfRVJST1IoW2lu
dmFsaWQgcG9sYXJzc2wgdmVyc2lvbl0pXQorCQlbQUNfTVNHX0VSUk9SKFtQb2xhclNTTCAxLjIu
NSBvciBuZXdlciByZXF1aXJlZF0pXQogCSkKKworCXBvbGFyc3NsX3dpdGhfcGtjczExPSJubyIK
KwlBQ19DT01QSUxFX0lGRUxTRSgKKwkJW0FDX0xBTkdfUFJPR1JBTSgKKwkJCVtbCisjaW5jbHVk
ZSA8cG9sYXJzc2wvY29uZmlnLmg+CisJCQldXSwKKwkJCVtbCisjaWZuZGVmIFBPTEFSU1NMX1BL
Q1MxMV9DCisjZXJyb3IgcGtjczExIHdyYXBwZXIgbWlzc2luZworI2VuZGlmCisJCQldXQorCQkp
XSwKKwkJcG9sYXJzc2xfd2l0aF9wa2NzMTE9InllcyIpCiAJQ0ZMQUdTPSIke29sZF9DRkxBR1N9
IgorCisJQUNfTVNHX0NIRUNLSU5HKFtwb2xhcnNzbCBwa2NzMTEgc3VwcG9ydF0pCisJaWYgdGVz
dCAiJHtlbmFibGVfcGtjczExfSIgPSAieWVzIjsgdGhlbgorCQlpZiB0ZXN0ICIke3BvbGFyc3Ns
X3dpdGhfcGtjczExfSIgPSAieWVzIjsgdGhlbgorCQkJQUNfTVNHX1JFU1VMVChbb2tdKQorCQll
bHNlCisJCQlBQ19NU0dfRVJST1IoW3BvbGFyc3NsIGhhcyBubyBwa2NzMTEgd3JhcHBlciBjb21w
aWxlZCBpbl0pCisJCWZpCisJZWxzZQorCQlpZiB0ZXN0ICIke3BvbGFyc3NsX3dpdGhfcGtjczEx
fSIgIT0gInllcyI7IHRoZW4KKwkJCUFDX01TR19SRVNVTFQoW29rXSkKKwkJZWxzZQorCQkJQUNf
TVNHX0VSUk9SKFtQb2xhclNTTCBjb21waWxlZCB3aXRoIFBLQ1MxMSwgd2hpbGUgT3BlblZQTiBp
cyBub3RdKQorCQlmaQorCWZpCisKIGZpCiAKIEFDX0FSR19WQVIoW0xaT19DRkxBR1NdLCBbQyBj
b21waWxlciBmbGFncyBmb3IgbHpvXSkKQEAgLTg1NiwxMyArODk1LDYgQEAgaWYgdGVzdCAiJHto
YXZlX2x6b30iID0gInllcyI7IHRoZW4KIAlDRkxBR1M9IiR7c2F2ZWRfQ0ZMQUdTfSIKIGZpCiAK
LVBLR19DSEVDS19NT0RVTEVTKAotCVtQS0NTMTFfSEVMUEVSXSwKLQlbbGlicGtjczExLWhlbHBl
ci0xID49IDEuMDJdLAotCVtoYXZlX3BrY3MxMV9oZWxwZXI9InllcyJdLAotCVtdCi0pCi0KIEFD
X01TR19DSEVDS0lORyhbZ2l0IGNoZWNrb3V0XSkKIEdJVF9DSEVDS09VVD0ibm8iCiBpZiB0ZXN0
IC1uICIke0dJVH0iIC1hIC1kICIke3NyY2Rpcn0vLmdpdCI7IHRoZW4KLS0gCjEuNy45LjUKCg==

--_002_1CED409804E2164C8104F9E623B08B9013B9050669FOXDFT02FOXlo_--

