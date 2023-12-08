Content-Type: multipart/mixed; boundary="------------3ih0q4BL4CokNzu4P78Unupk"
Message-ID: <ab19d7c6-302f-3056-d83e-0433f889e490@...277...>
Date: Fri, 8 Dec 2023 14:05:58 +0100
MIME-Version: 1.0
Content-Language: en-US
From: Reynir <reynirr@...277...>
Subject: [Openvpn-devel] Fail on odd number of hex digits in key files
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
--------------3ih0q4BL4CokNzu4P78Unupk
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Dear openvpn-devel,

Please find attached a patch that addresses the following bug:
When a key file has an odd number of hex digits the last digit is 
silently ignored. This can easily be tested by adding an extra hex digit 
at the line before the footer; openvpn does not notice and will use the 
key as if the file was not modified.

Best,
Reynir Björnsson
--------------3ih0q4BL4CokNzu4P78Unupk
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-read_key_file-Fail-on-odd-number-of-hex-digits.patch"
Content-Disposition: attachment;
 filename*0="0001-read_key_file-Fail-on-odd-number-of-hex-digits.patch"
Content-Transfer-Encoding: base64

RnJvbSBmZmYzZTI2YTkwYTRlMzczYmFhMDNlZDIwN2Y2N2Q1NjFlZDlhY2U1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmV5bmlyPTIwQmo9QzM9QjZybnNz
b24/PSA8cmV5bmlyQHJleW5pci5kaz4KRGF0ZTogRnJpLCA4IERlYyAyMDIzIDEzOjU4OjMz
ICswMTAwClN1YmplY3Q6IFtQQVRDSF0gcmVhZF9rZXlfZmlsZTogRmFpbCBvbiBvZGQgbnVt
YmVyIG9mIGhleCBkaWdpdHMKCldoZW4gcmVhZGluZyBhIGtleSBmaWxlIHdlIG11c3QgZW5z
dXJlIHdlIGhhdmUgcHJvY2Vzc2VkIGFsbCB0aGUgZGF0YS4KSWYgdGhlcmUgaXMgYW4gb2Rk
IG51bWJlciBvZiBoZXggZGlnaXRzIHdlIHNob3VsZCBub3Qgc2lsZW50bHkgaWdub3JlCnRo
ZSBsYXN0IGRpZ2l0IGJ1dCBpbnN0ZWFkIGZhaWwuCi0tLQogc3JjL29wZW52cG4vY3J5cHRv
LmMgfCAxMSArKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS9zcmMvb3BlbnZwbi9jcnlwdG8uYyBiL3NyYy9vcGVudnBuL2NyeXB0
by5jCmluZGV4IGU0NDUyZDdhLi5lZTVhZmUxYiAxMDA2NDQKLS0tIGEvc3JjL29wZW52cG4v
Y3J5cHRvLmMKKysrIGIvc3JjL29wZW52cG4vY3J5cHRvLmMKQEAgLTExMzksNiArMTEzOSw5
IEBAIHN0YXRpYyBjb25zdCBjaGFyIHByaW50YWJsZV9jaGFyX2ZtdFtdID0KIHN0YXRpYyBj
b25zdCBjaGFyIHVucHJpbnRhYmxlX2NoYXJfZm10W10gPQogICAgICJOb24tSGV4LCB1bnBy
aW50YWJsZSBjaGFyYWN0ZXIgKDB4JTAyeCkgZm91bmQgYXQgbGluZSAlZCBpbiBrZXkgZmls
ZSAnJXMnICglZC8lZC8lZCBieXRlcyBmb3VuZC9taW4vbWF4KSI7CiAKK3N0YXRpYyBjb25z
dCBjaGFyIG9kZF9oZXhfZGlnaXRzX2ZtdFtdID0KKyAgICAiT2RkIG51bWJlciBvZiBoZXgg
ZGlnaXRzIGZvdW5kIGluIGtleSBmaWxlICclcyciOworCiAvKiByZWFkIGtleSBmcm9tIGZp
bGUgKi8KIAogdm9pZApAQCAtMTI5Miw2ICsxMjk1LDE0IEBAIHJlYWRfa2V5X2ZpbGUoc3Ry
dWN0IGtleTIgKmtleTIsIGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IHVuc2lnbmVkIGludCBm
bGFncykKICAgICAgICAgLS1zaXplOwogICAgIH0KIAorICAgIC8qIGZhaWwgb24gb2RkIG51
bWJlciBvZiBoZXggZGlnaXRzICovCisgICAgaWYgKGhiX2luZGV4ID4gMCkKKyAgICB7Cisg
ICAgICAgIG1zZyhNX0ZBVEFMLAorICAgICAgICAgICAgb2RkX2hleF9kaWdpdHNfZm10LAor
ICAgICAgICAgICAgcHJpbnRfa2V5X2ZpbGVuYW1lKGZpbGUsIGZsYWdzICYgUktGX0lOTElO
RSkpOworICAgIH0KKwogICAgIC8qCiAgICAgICogTm9ybWFsbHkgd2Ugd2lsbCByZWFkIGVp
dGhlciAxIG9yIDIga2V5cyBmcm9tIGZpbGUuCiAgICAgICovCi0tIAoyLjMwLjIKCg==

--------------3ih0q4BL4CokNzu4P78Unupk--

