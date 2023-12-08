Content-Type: multipart/mixed; boundary="------------zPtzuCBp5vX8RzOBwYkpwngI"
Message-ID: <efc75bca-0ada-c361-f3d5-959d4be06aa6@...277...>
Date: Fri, 8 Dec 2023 14:26:56 +0100
MIME-Version: 1.0
Content-Language: en-US
From: Reynir <reynirr@...277...>
References: <ab19d7c6-302f-3056-d83e-0433f889e490@...277...>
In-Reply-To: <ab19d7c6-302f-3056-d83e-0433f889e490@...277...>
Subject: Re: [Openvpn-devel] Fail on odd number of hex digits in key files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------zPtzuCBp5vX8RzOBwYkpwngI
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Dear openvpn-devel,

Please find an updated version that doesn't hide away the format string 
in a variable and is instead a string literal.

Best,
Reynir Björnsson
--------------zPtzuCBp5vX8RzOBwYkpwngI
Content-Type: text/x-patch; charset=UTF-8;
 name="v2-0001-read_key_file-Fail-on-odd-number-of-hex-digits.patch"
Content-Disposition: attachment;
 filename*0="v2-0001-read_key_file-Fail-on-odd-number-of-hex-digits.patch"
Content-Transfer-Encoding: base64

RnJvbSBkN2RlNWFmMTY2YjUwYmE2NDQ5Y2RiZWU1OGFkOTNhN2Q4YjUyZmM3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpJbi1SZXBseS1UbzogPGFiMTlkN2M2LTMwMmYtMzA1Ni1kODNl
LTA0MzNmODg5ZTQ5MEBnbWFpbC5jb20+ClJlZmVyZW5jZXM6IDxhYjE5ZDdjNi0zMDJmLTMw
NTYtZDgzZS0wNDMzZjg4OWU0OTBAZ21haWwuY29tPgpGcm9tOiA9P1VURi04P3E/UmV5bmly
PTIwQmo9QzM9QjZybnNzb24/PSA8cmV5bmlyQHJleW5pci5kaz4KRGF0ZTogRnJpLCA4IERl
YyAyMDIzIDEzOjU4OjMzICswMTAwClN1YmplY3Q6IFtQQVRDSCB2Ml0gcmVhZF9rZXlfZmls
ZTogRmFpbCBvbiBvZGQgbnVtYmVyIG9mIGhleCBkaWdpdHMKCldoZW4gcmVhZGluZyBhIGtl
eSBmaWxlIHdlIG11c3QgZW5zdXJlIHdlIGhhdmUgcHJvY2Vzc2VkIGFsbCB0aGUgZGF0YS4K
SWYgdGhlcmUgaXMgYW4gb2RkIG51bWJlciBvZiBoZXggZGlnaXRzIHdlIHNob3VsZCBub3Qg
c2lsZW50bHkgaWdub3JlCnRoZSBsYXN0IGRpZ2l0IGJ1dCBpbnN0ZWFkIGZhaWwuCi0tLQog
c3JjL29wZW52cG4vY3J5cHRvLmMgfCA4ICsrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgOCBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvc3JjL29wZW52cG4vY3J5cHRvLmMgYi9zcmMv
b3BlbnZwbi9jcnlwdG8uYwppbmRleCBlNDQ1MmQ3YS4uMzc2ZTYwOGUgMTAwNjQ0Ci0tLSBh
L3NyYy9vcGVudnBuL2NyeXB0by5jCisrKyBiL3NyYy9vcGVudnBuL2NyeXB0by5jCkBAIC0x
MjkyLDYgKzEyOTIsMTQgQEAgcmVhZF9rZXlfZmlsZShzdHJ1Y3Qga2V5MiAqa2V5MiwgY29u
c3QgY2hhciAqZmlsZSwgY29uc3QgdW5zaWduZWQgaW50IGZsYWdzKQogICAgICAgICAtLXNp
emU7CiAgICAgfQogCisgICAgLyogZmFpbCBvbiBvZGQgbnVtYmVyIG9mIGhleCBkaWdpdHMg
Ki8KKyAgICBpZiAoaGJfaW5kZXggPiAwKQorICAgIHsKKyAgICAgICAgbXNnKE1fRkFUQUws
CisgICAgICAgICAgICAiT2RkIG51bWJlciBvZiBoZXggZGlnaXRzIGZvdW5kIGluIGtleSBm
aWxlICclcyciLAorICAgICAgICAgICAgcHJpbnRfa2V5X2ZpbGVuYW1lKGZpbGUsIGZsYWdz
ICYgUktGX0lOTElORSkpOworICAgIH0KKwogICAgIC8qCiAgICAgICogTm9ybWFsbHkgd2Ug
d2lsbCByZWFkIGVpdGhlciAxIG9yIDIga2V5cyBmcm9tIGZpbGUuCiAgICAgICovCi0tIAoy
LjMwLjIKCg==

--------------zPtzuCBp5vX8RzOBwYkpwngI--

