Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C64FAA.E32678FE"
Message-ID: <260656ABDEA7D848864F0C845A366BE8B43CD9@...591...>
From: "Barton, Christopher" <cpbarton@...590...>
Subject: [Openvpn-devel] Patch for Solaris & OpenSSL+Prngd/EGD
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Mar 24 17:25:15 2006
To: openvpn-devel@lists.sourceforge.net
Cc: "Vandenplas, Mark" <vandnpls@...590...>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C64FAA.E32678FE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I'm using OpenVPN 2.0.5 with OpenSSL built against PRNGD on Solaris 8
(sparc).  On startup, I always got "ERROR: Random number generator
cannot obtain entro <<openvpn-2.0.5-initprng.patch>> py for PRNG".  I
fixed it with the attached patch.
=20

------_=_NextPart_001_01C64FAA.E32678FE
Content-Type: application/octet-stream;
	name="openvpn-2.0.5-initprng.patch"
Content-Transfer-Encoding: base64
Content-Description: openvpn-2.0.5-initprng.patch
Content-Disposition: attachment;
	filename="openvpn-2.0.5-initprng.patch"

LS0tIG9wZW52cG4tMi4wLjUvY3J5cHRvLmMub3JpZwlGcmkgTWFyIDI0IDE4OjI1OjExIDIwMDYK
KysrIG9wZW52cG4tMi4wLjUvY3J5cHRvLmMJRnJpIE1hciAyNCAxODoyNjozMyAyMDA2CkBAIC0z
OSw2ICszOSw4IEBACiAKICNpbmNsdWRlICJtZW1kYmcuaCIKIAorI2luY2x1ZGUgPG9wZW5zc2wv
cmFuZC5oPgorCiAvKgogICogQ2hlY2sgZm9yIGtleSBzaXplIGNyZWVwYWdlLgogICovCkBAIC0x
NjIyLDkgKzE2MjQsNDggQEAKIAogc3RhdGljIHVpbnQ4X3Qgbm9uY2VfZGF0YSBbU0hBX0RJR0VT
VF9MRU5HVEggKyBOT05DRV9TRUNSRVRfTEVOXTsgLyogR0xPQkFMICovCiAKK3ZvaWQgU1NMSW5p
dFBSTkcoKQoreworI2lmIFNTTEVBWV9WRVJTSU9OX05VTUJFUiA+PSAweDAwOTA1MTAwCisgICAg
aWYgKFJBTkRfc3RhdHVzKCkgPT0gMCkgeworICAgICAgICBjaGFyIHJhbmRfZmlsZVsyNTZdOwor
ICAgICAgICB0aW1lX3QgdDsKKyAgICAgICAgcGlkX3QgcGlkOworICAgICAgICBsb25nIGwsc2Vl
ZDsKKworICAgICAgICB0ID0gdGltZShOVUxMKTsKKyAgICAgICAgcGlkID0gZ2V0cGlkKCk7Cisg
ICAgICAgIFJBTkRfZmlsZV9uYW1lKHJhbmRfZmlsZSwgMjU2KTsKKyAgICAgICAgaWYocmFuZF9m
aWxlICE9IE5VTEwpIHsKKyAgICAgICAgICAgIC8qIFNlZWQgYXMgbXVjaCBhcyAxMDI0IGJ5dGVz
IGZyb20gUkFORF9maWxlX25hbWUgKi8KKyAgICAgICAgICAgIFJBTkRfbG9hZF9maWxlKHJhbmRf
ZmlsZSwgMTAyNCk7CisgICAgICAgIH0KKyAgICAgICAgLyogU2VlZCBpbiB0aW1lIChtb2Rfc3Ns
IGRvZXMgdGhpcykgKi8KKyAgICAgICAgUkFORF9zZWVkKCh1bnNpZ25lZCBjaGFyICopJnQsIHNp
emVvZih0aW1lX3QpKTsKKyAgICAgICAgLyogU2VlZCBpbiBwaWQgKG1vZF9zc2wgZG9lcyB0aGlz
KSAqLworICAgICAgICBSQU5EX3NlZWQoKHVuc2lnbmVkIGNoYXIgKikmcGlkLCBzaXplb2YocGlk
X3QpKTsKKyAgICAgICAgLyogSW5pdGlhbGl6ZSBzeXN0ZW0ncyByYW5kb20gbnVtYmVyIGdlbmVy
YXRvciAqLworICAgICAgICBSQU5EX2J5dGVzKCh1bnNpZ25lZCBjaGFyICopJnNlZWQsIHNpemVv
Zihsb25nKSk7CisgICAgICAgIHNyYW5kNDgoc2VlZCk7CisgICAgICAgIHdoaWxlIChSQU5EX3N0
YXR1cygpID09IDApIHsKKyAgICAgICAgICAgIC8qIFJlcGVhdGVkbHkgc2VlZCB0aGUgUFJORyB1
c2luZyB0aGUgc3lzdGVtJ3MgcmFuZG9tIG51bWJlciBnZW5lcmF0b3IgdW50aWwgaXQgaGFzIGJl
ZW4gc2VlZGVkIHdpdGggZW5vdWdoIGRhdGEgKi8KKyAgICAgICAgICAgIGwgPSBscmFuZDQ4KCk7
CisgICAgICAgICAgICBSQU5EX3NlZWQoKHVuc2lnbmVkIGNoYXIgKikmbCwgc2l6ZW9mKGxvbmcp
KTsKKyAgICAgICAgfQorICAgICAgICBpZiAocmFuZF9maWxlICE9IE5VTEwpIHsKKyAgICAgICAg
ICAgIC8qIFdyaXRlIGEgcmFuZF9maWxlICovCisgICAgICAgICAgICBSQU5EX3dyaXRlX2ZpbGUo
cmFuZF9maWxlKTsKKyAgICAgICAgfQorICAgIH0KKyNlbmRpZiAvKiBTU0xFQVlfVkVSU0lPTl9O
VU1CRVIgPj0gMHgwMDkwNTEwMCAqLworICAgIHJldHVybjsKK30KKworCiB2b2lkCiBwcm5nX2lu
aXQgKHZvaWQpCiB7CisgIFNTTEluaXRQUk5HKCk7CiAgIGlmICghUkFORF9ieXRlcyAobm9uY2Vf
ZGF0YSwgc2l6ZW9mKG5vbmNlX2RhdGEpKSkKICAgICBtc2cgKE1fRkFUQUwsICJFUlJPUjogUmFu
ZG9tIG51bWJlciBnZW5lcmF0b3IgY2Fubm90IG9idGFpbiBlbnRyb3B5IGZvciBQUk5HIik7CiB9
Cg==

------_=_NextPart_001_01C64FAA.E32678FE--

