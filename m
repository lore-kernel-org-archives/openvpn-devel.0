Mime-Version: 1.0
Message-Id: <p05111701b8fbef2f355b@[192.168.22.100]>
From: Christoph Pfisterer <cp@...16...>
Content-Type: multipart/mixed; boundary="============_-1191431998==_============"
Subject: [Openvpn-devel] Mac OS X support
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Mon May  6 06:09:15 2002
To: openvpn-devel@lists.sourceforge.net

--============_-1191431998==_============
Content-Type: text/plain; charset="us-ascii" ; format="flowed"

Hi all!

With some tweaking, I was able to get OpenVPN running on Mac OS X and 
use it happily with a Linux peer. Discussion and patches follow.

First of all, current versions of Mac OS X don't include a tun 
driver, although it is present in the source tree (publicly available 
via CVS). An independent port of the FreeBSD driver as a loadable 
module exists, but OpenVPN uncovered some bugs in it. I was able to 
fix those bugs and effectively took over maintenance of the driver. 
It is available from <http://chrisp.de/en/projects/tunnel.html>; 
OpenVPN requires at least version 1.1.0.

OpenVPN itself also needed some small patches, mostly due to Mac OS 
X's customized GCC and its outdated BSD headers. There are three main 
problems:

1. There is no in_addr_t and uint32_t is not automatically defined. 
Some research revealed that uint32_t is defined in <stdint.h>, which 
is not included explicitly. On Linux, it is included implicitly by 
<netinet/in.h>, but not so on Mac OS X. This is easily fixed in 
syshead.h.

2. Apple's precompiling version of cpp doesn't know about macros with 
variable arguments. Passing the "--no-cpp-precomp" command line 
option gets rid of this. I added a small check to configure to add it 
automatically.

3. There is no socklen_t. Coming up with a quick workaround was easy, 
but fixing it properly wasn't. I found a quite complete configure 
test for this in OpenSSH, it actually originated from curl. 
Unfortunately it only works with autoconf 2.50 or newer.

The attached patch is against the current CVS version (which 
identifies itself as 1.1.1.6). It compiles and runs fine on my Mac OS 
X box, although I haven't tested the new features yet.

Please let me know what you think.

Greetings,
chrisp

-- 
chrisp a.k.a. Christoph Pfisterer   "Any sufficiently advanced
cp@...16... - http://chrisp.de      bug is indistinguishable
PGP key & geek code available        from a feature."
--============_-1191431998==_============
Content-Id: <p05111701b8fbef2f355b@[192.168.22.100].0.0>
Content-Type: multipart/appledouble; boundary="============_-1191431998==_D============"

--============_-1191431998==_D============
Content-Transfer-Encoding: base64
Content-Type: application/applefile; name="%darwin-support.patch"
Content-Disposition: attachment; filename="%darwin-support.patch"
 ; modification-date="Mon, 6 May 2002 10:17:52 +0200"

AAUWBwACAAAAAAAAAAAAAAAAAAAAAAAAAAMAAAADAAAAPgAAABQAAAAJAAAAUgAAACAA
AAAIAAAAcgAAABBkYXJ3aW4tc3VwcG9ydC5wYXRjaAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAABGkUvgRpFNBLbQwABGlY4g==
--============_-1191431998==_D============
Content-Type: application/octet-stream; name="darwin-support.patch"
 ; x-mac-type="00000000"
 ; x-mac-creator="00000000"
Content-Disposition: attachment; filename="darwin-support.patch"
Content-Transfer-Encoding: base64

SW5kZXg6IGFjY29uZmlnLmgKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2c3Jv
b3Qvb3BlbnZwbi9vcGVudnBuL2FjY29uZmlnLmgsdgpyZXRyaWV2aW5nIHJldmlzaW9u
IDEuMgpkaWZmIC11IC1yMS4yIGFjY29uZmlnLmgKLS0tIGFjY29uZmlnLmgJMiBNYXkg
MjAwMiAwNzoxODowOCAtMDAwMAkxLjIKKysrIGFjY29uZmlnLmgJNiBNYXkgMjAwMiAw
ODoxNzozMSAtMDAwMApAQCAtNDgsNiArNDgsOSBAQAogLyogZWFybHkgdmVyc2lvbnMg
b2YgZ2xpYmMgZG9uJ3QgZGVmaW5lIGluX2FkZHJfdCAqLwogI3VuZGVmIGluX2FkZHJf
dAogCisvKiBzb21lIG91dGRhdGVkIHN5c3RlbXMgZG9uJ3QgaGF2ZSBzb2NrbGVuX3Qg
Ki8KKyN1bmRlZiBzb2NrbGVuX3QKKwogLyogd2hhdCBzeXN0ZW0gYXJlIHdlIHJ1bm5p
bmcgb24/ICovCiAjdW5kZWYgVEFSR0VUX0FMSUFTCiAKQEAgLTU5LDMgKzYyLDYgQEAK
IAogLyogYXJlIHdlIHJ1bm5pbmcgb24gQlNEPyAqLwogI3VuZGVmIFRBUkdFVF9CU0QK
KworLyogYXJlIHdlIHJ1bm5pbmcgb24gTWFjIE9TIFggLyBEYXJ3aW4/ICovCisjdW5k
ZWYgVEFSR0VUX0RBUldJTgpJbmRleDogY29uZmlndXJlLmluCj09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0KUkNTIGZpbGU6IC9jdnNyb290L29wZW52cG4vb3BlbnZwbi9jb25maWd1cmUuaW4s
dgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuOApkaWZmIC11IC1yMS44IGNvbmZpZ3VyZS5p
bgotLS0gY29uZmlndXJlLmluCTIgTWF5IDIwMDIgMDc6MTg6MDggLTAwMDAJMS44Cisr
KyBjb25maWd1cmUuaW4JNiBNYXkgMjAwMiAwODoxNzozMiAtMDAwMApAQCAtNTgsNiAr
NTgsNDggQEAKICAgTElCUz0iJExJQl9QUkVGSVggJExJQl9TVUZGSVgiCiBdKQogCitk
bmwgLS0gVGhlIGZvbGxvd2luZyBpcyB0YWtlIGZyb20gY3VybCdzIGFjaW5jbHVkZS5t
NCAtLQorZG5sIENoZWNrIGZvciBzb2NrbGVuX3Q6IGhpc3RvcmljYWxseSBvbiBCU0Qg
aXQgaXMgYW4gaW50LCBhbmQgaW4KK2RubCBQT1NJWCAxZyBpdCBpcyBhIHR5cGUgb2Yg
aXRzIG93biwgYnV0IHNvbWUgcGxhdGZvcm1zIHVzZSBkaWZmZXJlbnQKK2RubCB0eXBl
cyBmb3IgdGhlIGFyZ3VtZW50IHRvIGdldHNvY2tvcHQsIGdldHBlZXJuYW1lLCBldGMu
ICBTbyB3ZQorZG5sIGhhdmUgdG8gdGVzdCB0byBmaW5kIHNvbWV0aGluZyB0aGF0IHdp
bGwgd29yay4KK0FDX0RFRlVOKFtUWVBFX1NPQ0tMRU5fVF0sCitbCisgICBBQ19DSEVD
S19UWVBFKFtzb2NrbGVuX3RdLCAsWworICAgICAgQUNfTVNHX0NIRUNLSU5HKFtmb3Ig
c29ja2xlbl90IGVxdWl2YWxlbnRdKQorICAgICAgQUNfQ0FDSEVfVkFMKFtjdXJsX2N2
X3NvY2tsZW5fdF9lcXVpdl0sCisgICAgICBbCisgICAgICAgICAjIFN5c3RlbXMgaGF2
ZSBlaXRoZXIgInN0cnVjdCBzb2NrYWRkciAqIiBvcgorICAgICAgICAgIyAidm9pZCAq
IiBhcyB0aGUgc2Vjb25kIGFyZ3VtZW50IHRvIGdldHBlZXJuYW1lCisgICAgICAgICBj
dXJsX2N2X3NvY2tsZW5fdF9lcXVpdj0KKyAgICAgICAgIGZvciBhcmcyIGluICJzdHJ1
Y3Qgc29ja2FkZHIiIHZvaWQ7IGRvCisgICAgICAgICAgICBmb3IgdCBpbiBpbnQgc2l6
ZV90IHVuc2lnbmVkIGxvbmcgInVuc2lnbmVkIGxvbmciOyBkbworICAgICAgICAgICAg
ICAgQUNfVFJZX0NPTVBJTEUoWworICAgICAgICAgICAgICAgICAgI2luY2x1ZGUgPHN5
cy90eXBlcy5oPgorICAgICAgICAgICAgICAgICAgI2luY2x1ZGUgPHN5cy9zb2NrZXQu
aD4KKworICAgICAgICAgICAgICAgICAgaW50IGdldHBlZXJuYW1lIChpbnQsICRhcmcy
ICosICR0ICopOworICAgICAgICAgICAgICAgXSxbCisgICAgICAgICAgICAgICAgICAk
dCBsZW47CisgICAgICAgICAgICAgICAgICBnZXRwZWVybmFtZSgwLDAsJmxlbik7Cisg
ICAgICAgICAgICAgICBdLFsKKyAgICAgICAgICAgICAgICAgIGN1cmxfY3Zfc29ja2xl
bl90X2VxdWl2PSIkdCIKKyAgICAgICAgICAgICAgICAgIGJyZWFrCisgICAgICAgICAg
ICAgICBdKQorICAgICAgICAgICAgZG9uZQorICAgICAgICAgZG9uZQorCisgICAgICAg
ICBpZiB0ZXN0ICJ4JGN1cmxfY3Zfc29ja2xlbl90X2VxdWl2IiA9IHg7IHRoZW4KKyAg
ICAgICAgICAgIEFDX01TR19FUlJPUihbQ2Fubm90IGZpbmQgYSB0eXBlIHRvIHVzZSBp
biBwbGFjZSBvZiBzb2NrbGVuX3RdKQorICAgICAgICAgZmkKKyAgICAgIF0pCisgICAg
ICBBQ19NU0dfUkVTVUxUKCRjdXJsX2N2X3NvY2tsZW5fdF9lcXVpdikKKyAgICAgIEFD
X0RFRklORV9VTlFVT1RFRChzb2NrbGVuX3QsICRjdXJsX2N2X3NvY2tsZW5fdF9lcXVp
diwKKwkJCVt0eXBlIHRvIHVzZSBpbiBwbGFjZSBvZiBzb2NrbGVuX3QgaWYgbm90IGRl
ZmluZWRdKV0sCisgICAgICBbI2luY2x1ZGUgPHN5cy90eXBlcy5oPgorI2luY2x1ZGUg
PHN5cy9zb2NrZXQuaD5dKQorXSkKKwogQUNfSU5JVChvcGVudnBuLmMpCiAKIEFNX0NP
TkZJR19IRUFERVIoY29uZmlnLmgpCkBAIC0xNDUsNiArMTg3LDcgQEAKIAogZG5sIGNo
ZWNrIHRoYXQgaW5fYWRkcl90IGlzIGRlZmluZWQKIE9QRU5WUE5fQ0hFQ0tfVFlQRShp
bl9hZGRyX3QsIHVpbnQzMl90KQorVFlQRV9TT0NLTEVOX1QKIAogQUNfREVGSU5FX1VO
UVVPVEVEKFRBUkdFVF9BTElBUywgIiR0YXJnZXRfYWxpYXMiKQogCkBAIC0xNTIsNiAr
MTk1LDE0IEBACiBPUEVOVlBOX0NIRUNLX1RBUkdFVChsaW51eCwgVEFSR0VUX0xJTlVY
KQogT1BFTlZQTl9DSEVDS19UQVJHRVQoc29sYXJpcywgVEFSR0VUX1NPTEFSSVMpCiBP
UEVOVlBOX0NIRUNLX1RBUkdFVChic2QsIFRBUkdFVF9CU0QpCitPUEVOVlBOX0NIRUNL
X1RBUkdFVChkYXJ3aW4sIFRBUkdFVF9EQVJXSU4pCisKK2RubCBzb21lIE1hYyBPUyBY
IHRlbmRlcmluZyAod2UgdXNlIHZhcmFyZyBtYWNyb3MuLi4pCitjYXNlICIkaG9zdCIg
aW4KKyotKi1kYXJ3aW4qKQorCUNQUEZMQUdTPSIkQ1BQRkxBR1MgLW5vLWNwcC1wcmVj
b21wIgorCTs7Citlc2FjCiAKIEFDX0NIRUNLSU5HKCBmb3IgVFVOL1RBUCBkcml2ZXIg
dmVyc2lvbiAuLi4gKQogQUNfQ0hFQ0tfSEVBREVSKGxpbnV4L2lmX3R1bi5oLApJbmRl
eDogc3lzaGVhZC5oCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KUkNTIGZpbGU6IC9jdnNyb290L29w
ZW52cG4vb3BlbnZwbi9zeXNoZWFkLmgsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMgpk
aWZmIC11IC1yMS4yIHN5c2hlYWQuaAotLS0gc3lzaGVhZC5oCTIgTWF5IDIwMDIgMDc6
MTg6MDggLTAwMDAJMS4yCisrKyBzeXNoZWFkLmgJNiBNYXkgMjAwMiAwODoxNzozMiAt
MDAwMApAQCAtMzQsNiArMzQsNyBAQAogI2luY2x1ZGUgPHN5cy9zdGF0Lmg+CiAjaW5j
bHVkZSA8ZmNudGwuaD4KICNpbmNsdWRlIDxzdGRsaWIuaD4KKyNpbmNsdWRlIDxzdGRp
bnQuaD4KICNpbmNsdWRlIDxzdGRhcmcuaD4KICNpbmNsdWRlIDx1bmlzdGQuaD4KICNp
bmNsdWRlIDxzaWduYWwuaD4K
--============_-1191431998==_D============--

--============_-1191431998==_============--

