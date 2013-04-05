From: Steffan Karger <steffan.karger@...1435...>
Date: Fri, 5 Apr 2013 10:00:31 +0200
Message-ID: <1CED409804E2164C8104F9E623B08B9013BC28A538@...1436...>
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_002_1CED409804E2164C8104F9E623B08B9013BC28A538FOXDFT02FOXlo_"
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fixed tls-cipher translation bug in
	openssl-build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--_002_1CED409804E2164C8104F9E623B08B9013BC28A538FOXDFT02FOXlo_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Attached a patch to fix a bug in the TLS-cipher translation introduced (by =
me) in commit 030c7b0. The previous version would not parse tls-cipher stri=
ngs with more than two ciphers specified correctly.

The patch has been tested by the user that reported the bug.

-Steffan

--_002_1CED409804E2164C8104F9E623B08B9013BC28A538FOXDFT02FOXlo_
Content-Type: application/octet-stream;
	name="0001-Fixed-tls-cipher-translation-bug-in-openssl-build.patch"
Content-Description: 0001-Fixed-tls-cipher-translation-bug-in-openssl-build.patch
Content-Disposition: attachment;
	filename="0001-Fixed-tls-cipher-translation-bug-in-openssl-build.patch";
	size=1507; creation-date="Fri, 05 Apr 2013 07:38:38 GMT";
	modification-date="Thu, 04 Apr 2013 20:09:32 GMT"
Content-Transfer-Encoding: base64

RnJvbSBjMzJhNTU5NzQzZDBiMjYxNjYzYzQ4OWE1NmQ2YjY1MWRjMzAxMWZmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGVmZmFuIEthcmdlciA8c3RlZmZhbi5rYXJnZXJAZm94LWl0
LmNvbT4KRGF0ZTogVGh1LCA0IEFwciAyMDEzIDIxOjUzOjA3ICswMjAwClN1YmplY3Q6IFtQQVRD
SF0gRml4ZWQgdGxzLWNpcGhlciB0cmFuc2xhdGlvbiBidWcgaW4gb3BlbnNzbC1idWlsZAoKU2ln
bmVkLW9mZi1ieTogU3RlZmZhbiBLYXJnZXIgPHN0ZWZmYW4ua2FyZ2VyQGZveC1pdC5jb20+Ci0t
LQogc3JjL29wZW52cG4vc3NsX29wZW5zc2wuYyB8ICAgIDcgKysrKystLQogMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zcmMvb3Bl
bnZwbi9zc2xfb3BlbnNzbC5jIGIvc3JjL29wZW52cG4vc3NsX29wZW5zc2wuYwppbmRleCAxMDA2
NjE3Li43OWNjMDU2IDEwMDY0NAotLS0gYS9zcmMvb3BlbnZwbi9zc2xfb3BlbnNzbC5jCisrKyBi
L3NyYy9vcGVudnBuL3NzbF9vcGVuc3NsLmMKQEAgLTIxNyw4ICsyMTcsOSBAQCB0bHNfY3R4X3Jl
c3RyaWN0X2NpcGhlcnMoc3RydWN0IHRsc19yb290X2N0eCAqY3R4LCBjb25zdCBjaGFyICpjaXBo
ZXJzKQogICBBU1NFUlQoTlVMTCAhPSBjdHgpOwogCiAgIC8vIFRyYW5zbGF0ZSBJQU5BIGNpcGhl
ciBzdWl0ZSBuYW1lcyB0byBPcGVuU1NMIG5hbWVzCi0gIGZvciAoYmVnaW5fb2ZfY2lwaGVyID0g
MDsgYmVnaW5fb2ZfY2lwaGVyIDwgc3RybGVuKGNpcGhlcnMpOyBiZWdpbl9vZl9jaXBoZXIgPSBl
bmRfb2ZfY2lwaGVyKzEpIHsKLSAgICAgIGVuZF9vZl9jaXBoZXIgPSBzdHJjc3BuKCZjaXBoZXJz
W2JlZ2luX29mX2NpcGhlcl0sICI6Iik7CisgIGJlZ2luX29mX2NpcGhlciA9IGVuZF9vZl9jaXBo
ZXIgPSAwOworICBmb3IgKDsgYmVnaW5fb2ZfY2lwaGVyIDwgc3RybGVuKGNpcGhlcnMpOyBiZWdp
bl9vZl9jaXBoZXIgPSBlbmRfb2ZfY2lwaGVyKSB7CisgICAgICBlbmRfb2ZfY2lwaGVyICs9IHN0
cmNzcG4oJmNpcGhlcnNbYmVnaW5fb2ZfY2lwaGVyXSwgIjoiKTsKICAgICAgIGNpcGhlcl9wYWly
ID0gdGxzX2dldF9jaXBoZXJfbmFtZV9wYWlyKCZjaXBoZXJzW2JlZ2luX29mX2NpcGhlcl0sIGVu
ZF9vZl9jaXBoZXIgLSBiZWdpbl9vZl9jaXBoZXIpOwogCiAgICAgICBpZiAoTlVMTCA9PSBjaXBo
ZXJfcGFpcikKQEAgLTI1Nyw2ICsyNTgsOCBAQCB0bHNfY3R4X3Jlc3RyaWN0X2NpcGhlcnMoc3Ry
dWN0IHRsc19yb290X2N0eCAqY3R4LCBjb25zdCBjaGFyICpjaXBoZXJzKQogICAgICAgb3BlbnNz
bF9jaXBoZXJzX2xlbiArPSBjdXJyZW50X2NpcGhlcl9sZW47CiAgICAgICBvcGVuc3NsX2NpcGhl
cnNbb3BlbnNzbF9jaXBoZXJzX2xlbl0gPSAnOic7CiAgICAgICBvcGVuc3NsX2NpcGhlcnNfbGVu
Kys7CisKKyAgICAgIGVuZF9vZl9jaXBoZXIrKzsKICAgfQogCiAgIGlmIChvcGVuc3NsX2NpcGhl
cnNfbGVuID4gMCkKLS0gCjEuNy45LjUKCg==

--_002_1CED409804E2164C8104F9E623B08B9013BC28A538FOXDFT02FOXlo_--

