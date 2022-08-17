Content-Type: multipart/mixed; boundary="------------0NrzYkjZzIQSGvp3XWnHqph1"
Message-ID: <48db419f-0d5d-a9b9-6f55-dffc5d4fbbe5@...1227...>
Date: Thu, 18 Aug 2022 00:40:09 +0200
MIME-Version: 1.0
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
Subject: [Openvpn-devel] wolfSSL unit test failures
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Juliusz Sosinowicz <juliusz@...2525...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------0NrzYkjZzIQSGvp3XWnHqph1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey,

currently we still have test failures in wolfSSL in

EVP_PKEY_CTX_new with clang asan. Github action patch that reproduces 
this also attached. With the OpenVPN 2.6 release coming up in the next 
months it would be good if these can be fixed. These look like problems
in the upstream wolfSSL code.


Details are below:

=================================================================
==19723==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 160 byte(s) in 4 object(s) allocated from:
     #0 0x49604d in malloc 
(/home/runner/work/openvpn/openvpn/tests/unit_tests/openvpn/crypto_testdriver+0x49604d)
     #1 0x7f64e8318291 in wolfSSL_EVP_PKEY_CTX_new 
(/usr/local/lib/libwolfssl.so.34+0x9e291)

Indirect leak of 400 byte(s) in 2 object(s) allocated from:
     #0 0x49604d in malloc 
(/home/runner/work/openvpn/openvpn/tests/unit_tests/openvpn/crypto_testdriver+0x49604d)
     #1 0x7f64e833c537 in wolfSSL_EVP_PKEY_new_ex 
(/usr/local/lib/libwolfssl.so.34+0xc2537)

Indirect leak of 240 byte(s) in 2 object(s) allocated from:
     #0 0x49604d in malloc 
(/home/runner/work/openvpn/openvpn/tests/unit_tests/openvpn/crypto_testdriver+0x49604d)
     #1 0x7f64e82b4ac2 in _InitRng.isra.0 
(/usr/local/lib/libwolfssl.so.34+0x3aac2)

Indirect leak of 118 byte(s) in 2 object(s) allocated from:
     #0 0x49604d in malloc 
(/home/runner/work/openvpn/openvpn/tests/unit_tests/openvpn/crypto_testdriver+0x49604d)
     #1 0x7f64e833c72b in wolfSSL_EVP_PKEY_new_mac_key 
(/usr/local/lib/libwolfssl.so.34+0xc272b)

SUMMARY: AddressSanitizer: 918 byte(s) leaked in 10 allocation(s).
FAIL: crypto_testdriver


--------------0NrzYkjZzIQSGvp3XWnHqph1
Content-Type: text/plain; charset=UTF-8;
 name="0001-Add-wolfSSL-to-github-actions.patch"
Content-Disposition: attachment;
 filename="0001-Add-wolfSSL-to-github-actions.patch"
Content-Transfer-Encoding: base64

RnJvbSAwMmQ0YzRkODQ0NDE4OGJkZjMyYTA1NDE3MWVhN2UyMGNjN2MxMmZmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBBcm5lIFNjaHdhYmUgPGFybmVAcmZjMjU0OS5vcmc+
CkRhdGU6IFRodSwgMTEgQXVnIDIwMjIgMTk6Mjc6MTIgKzAyMDAKU3ViamVjdDogW1BBVENI
XSBBZGQgd29sZlNTTCB0byBnaXRodWIgYWN0aW9ucwoKSSBqdXN0IHdhbnQgdG8gc2VlIHRo
ZSB3b3JsZCBidXJuIGEgbGl0dGxlIGJpdAoKU2lnbmVkLW9mZi1ieTogQXJuZSBTY2h3YWJl
IDxhcm5lQHJmYzI1NDkub3JnPgotLS0KIC5naXRodWIvd29ya2Zsb3dzL2J1aWxkLnlhbWwg
fCA0MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFu
Z2VkLCA0MiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvLmdpdGh1Yi93b3JrZmxvd3Mv
YnVpbGQueWFtbCBiLy5naXRodWIvd29ya2Zsb3dzL2J1aWxkLnlhbWwKaW5kZXggMmE5YTRl
OTQ2Li45YzY0MGNjN2YgMTAwNjQ0Ci0tLSBhLy5naXRodWIvd29ya2Zsb3dzL2J1aWxkLnlh
bWwKKysrIGIvLmdpdGh1Yi93b3JrZmxvd3MvYnVpbGQueWFtbApAQCAtMzQsNiArMzQsNDgg
QEAgam9iczoKICAgICAgIC0gbmFtZTogU2V0IGpvYiBzdGF0dXMKICAgICAgICAgcnVuOiB0
ZXN0ICEgLXMgdW5jcnVzdGlmeS1jaGFuZ2VzLnBhdGNoCiAgICAgICAgIHdvcmtpbmctZGly
ZWN0b3J5OiBvcGVudnBuCisgIHdvbGZzc2w6CisgICAgc3RyYXRlZ3k6CisgICAgICBmYWls
LWZhc3Q6IGZhbHNlCisgICAgICBtYXRyaXg6CisgICAgICAgIG9zOiBbdWJ1bnR1LTIwLjA0
XQorICAgICAgICBzc2xsaWI6IFt3b2xmc3NsXQorCisgICAgbmFtZTogImdjYyAtICR7e21h
dHJpeC5vc319IC0gJHt7bWF0cml4LnNzbGxpYn19IgorCisgICAgcnVucy1vbjogJHt7bWF0
cml4Lm9zfX0KKyAgICBzdGVwczoKKyAgICAgIC0gbmFtZTogSW5zdGFsbCBkZXBlbmRlbmNp
ZXMKKyAgICAgICAgcnVuOiBzdWRvIGFwdCB1cGRhdGUgJiYgc3VkbyBhcHQgaW5zdGFsbCAt
eSBsaWJsem8yLWRldiBsaWJwYW0wZy1kZXYgbGlibHo0LWRldiBsaW51eC1saWJjLWRldiBt
YW4yaHRtbCBjbGFuZyBsaWJjbW9ja2EtZGV2IHB5dGhvbjMtZG9jdXRpbHMgbGlidG9vbCBh
dXRvbWFrZSBhdXRvY29uZiBsaWJtYmVkdGxzLWRldiBwa2ctY29uZmlnIGxpYmNhcC1uZy1k
ZXYKKyAgICAgIC0gbmFtZTogIndvbGZTU0w6IGNoZWNrb3V0IgorICAgICAgICB1c2VzOiBh
Y3Rpb25zL2NoZWNrb3V0QHYzCisgICAgICAgIHdpdGg6CisgICAgICAgICAgcGF0aDogd29s
ZnNzbAorICAgICAgICAgIHJlcG9zaXRvcnk6IHdvbGZTU0wvd29sZnNzbAorICAgICAgLSBu
YW1lOiAid29sZlNTTDogYXV0b2NvbmYiCisgICAgICAgIHJ1bjogYXV0b3JlY29uZiAtZnZp
CisgICAgICAgIHdvcmtpbmctZGlyZWN0b3J5OiB3b2xmc3NsCisgICAgICAtIG5hbWU6ICJ3
b2xmU1NMOiBjb25maWd1cmUiCisgICAgICAgIHJ1bjogLi9jb25maWd1cmUgLS1lbmFibGUt
b3BlbnZwbgorICAgICAgICB3b3JraW5nLWRpcmVjdG9yeTogd29sZnNzbAorICAgICAgLSBu
YW1lOiAid29sZlNTTDogbWFrZSBhbGwiCisgICAgICAgIHJ1bjogbWFrZSAtajMKKyAgICAg
ICAgd29ya2luZy1kaXJlY3Rvcnk6IHdvbGZzc2wKKyAgICAgIC0gbmFtZTogIndvbGZTU0w6
IG1ha2UgaW5zdGFsbCIKKyAgICAgICAgcnVuOiBzdWRvIG1ha2UgaW5zdGFsbAorICAgICAg
ICB3b3JraW5nLWRpcmVjdG9yeTogd29sZnNzbAorICAgICAgLSBuYW1lOiAibGRjb25maWci
CisgICAgICAgIHJ1bjogc3VkbyBsZGNvbmZpZworICAgICAgLSBuYW1lOiBDaGVja291dCBP
cGVuVlBOCisgICAgICAgIHVzZXM6IGFjdGlvbnMvY2hlY2tvdXRAdjMKKyAgICAgIC0gbmFt
ZTogYXV0b2NvbmYKKyAgICAgICAgcnVuOiBhdXRvcmVjb25mIC1mdmkKKyAgICAgIC0gbmFt
ZTogY29uZmlndXJlCisgICAgICAgIHJ1bjogQ0ZMQUdTPSItZnNhbml0aXplPWFkZHJlc3Mg
LWZuby1vbWl0LWZyYW1lLXBvaW50ZXIgLU8yIiBDQz1jbGFuZyAuL2NvbmZpZ3VyZSAtLXdp
dGgtY3J5cHRvLWxpYnJhcnk9JHt7bWF0cml4LnNzbGxpYn19CisgICAgICAtIG5hbWU6IG1h
a2UgYWxsCisgICAgICAgIHJ1bjogbWFrZSAtajMKKyAgICAgIC0gbmFtZTogbWFrZSBjaGVj
aworICAgICAgICBydW46IG1ha2UgY2hlY2sKIAogICBtaW5ndzoKICAgICBzdHJhdGVneToK
LS0gCjIuMzIuMSAoQXBwbGUgR2l0LTEzMykKCg==

--------------0NrzYkjZzIQSGvp3XWnHqph1--

