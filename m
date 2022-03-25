Content-Type: multipart/mixed; boundary="------------R7Vc4ghb5bS7OcSyaMxuf8HS"
Message-ID: <1315401d-b450-6db4-08f5-fed79f51a205@...2666...>
Date: Fri, 25 Mar 2022 08:21:28 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <400a4652-39d6-ec8d-6f58-824f552e0440@...2666...>
 <9f710eb5-007c-cc8e-56b0-1b00c3f12c19@...1227...>
From: Michael Baentsch <info@...2666...>
In-Reply-To: <9f710eb5-007c-cc8e-56b0-1b00c3f12c19@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Enablement of quantum-safe key
 establishment
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------R7Vc4ghb5bS7OcSyaMxuf8HS
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Thanks very much for the quick and thorough feedback. Indeed your last 
question is pivotal making the patch _much_ simpler (attached): The 
problem manifests itself only in the presence of providers introduced in 
OpenSSL3.0. At the same time, the curve name causing the "dance code" is 
permitted as of OpenSSL3.0...

So all other observations below are moot/should be resolved with the 
much simpler new patch attached. Feel free to delete/amend the comment 
changes as you see fit.

--Michael

Am 24.03.22 um 18:48 schrieb Arne Schwabe:
> Am 24.03.22 um 14:40 schrieb Michael Baentsch:
>> Hello,
>>
>>     as per https://community.openvpn.net/openvpn/ticket/1460 the 
>> current openvpn master fails when activating a TLS1.3 group 
>> implemented in an external provider.
>>
>> The patch attached fixes this and enables successful OpenSSL key 
>> establishment using any of the quantum-safe and hybrid (classic/QSC) 
>> algorithms supported by 
>> https://github.com/open-quantum-safe/oqs-provider
>
> Thanks for the patch. Usually we would like to have patches in a git 
> format that contains a commit message (see git format-patch) and 
> https://github.com/OpenVPN/openvpn/blob/master/CONTRIBUTING.rst
>
> The current patch has a few problems:
>
> - Breaks OpenSSL 1.0.2 compatibity. Currently we still support RHEL7, 
> which only has OpenSSL 1.0.2
> - uses C90 variable declaration (int rc)
> - indentation problems
>
> We normally use our own gc_alloc etc usage for strings as the previous 
> code did. That usage was replaced with malloc/free.
>
> And the code does not have any comments but removes the existing ones 
> and with a line like this:
>
> memcpy(idx, f+strlen("secp256r1"), 
> strlen(groups)-(f-groups)-strlen("secp256r1"));
>
> some comments what the code is doing would improve readibility.
>
> The fix itself is right of using the newer SSL_CTX_set1_groups_list 
> function that uses strings instead of nids.
>
> But if we use a function that only newer OpenSSL version, have you 
> double checked that the prime256v1 vs secp256r1 is still necessary
>
>
> Build failure with OpenSSL 1.0.2: 
> https://github.com/schwabe/openvpn/runs/5680551849?check_suite_focus=true
>
> Arne


--------------R7Vc4ghb5bS7OcSyaMxuf8HS
Content-Type: text/x-patch; charset=UTF-8; name="ssl_openssl.c.patch"
Content-Disposition: attachment; filename="ssl_openssl.c.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3NyYy9vcGVudnBuL3NzbF9vcGVuc3NsLmMgYi9zcmMvb3BlbnZwbi9z
c2xfb3BlbnNzbC5jCmluZGV4IGI4NTk1MTc0Li5hZjk3ZGFiYyAxMDA2NDQKLS0tIGEvc3Jj
L29wZW52cG4vc3NsX29wZW5zc2wuYworKysgYi9zcmMvb3BlbnZwbi9zc2xfb3BlbnNzbC5j
CkBAIC01NzIsMTMgKzU3MiwxNSBAQCB2b2lkCiB0bHNfY3R4X3NldF90bHNfZ3JvdXBzKHN0
cnVjdCB0bHNfcm9vdF9jdHggKmN0eCwgY29uc3QgY2hhciAqZ3JvdXBzKQogewogICAgIEFT
U0VSVChjdHgpOworI2lmIE9QRU5TU0xfVkVSU0lPTl9OVU1CRVIgPCAweDMwMDAwMDAwTAog
ICAgIHN0cnVjdCBnY19hcmVuYSBnYyA9IGdjX25ldygpOwogICAgIC8qIFRoaXMgbWV0aG9k
IGNvdWxkIGJlIGFzIGVhc3kgYXMKICAgICAgKiAgU1NMX0NUWF9zZXQxX2dyb3Vwc19saXN0
KGN0eC0+Y3R4LCBncm91cHMpCi0gICAgICogYnV0IE9wZW5TU0wgZG9lcyBub3QgbGlrZSB0
aGUgbmFtZSBzZWNwMjU2cjEgZm9yIHByaW1lMjU2djEKKyAgICAgKiBidXQgT3BlblNTTCAo
PCAzLjApIGRvZXMgbm90IGxpa2UgdGhlIG5hbWUgc2VjcDI1NnIxIGZvciBwcmltZTI1NnYx
CiAgICAgICogVGhpcyBpcyBvbmUgb2YgdGhlIGltcG9ydGFudCBjdXJ2ZXMuCiAgICAgICog
VG8gc3VwcG9ydCB0aGUgc2FtZSBuYW1lIGZvciBPcGVuU1NMIGFuZCBtYmVkVExTLCB3ZSBk
bwogICAgICAqIHRoaXMgZGFuY2UuCisgICAgICogQWxzbyBub3RlIHRoYXQgdGhlIGNvZGUg
aXMgd3JvbmcgaW4gdGhlIHByZXNlbmNlIG9mIE9wZW5TU0wzIHByb3ZpZGVycy4KICAgICAg
Ki8KIAogICAgIGludCBncm91cHNfY291bnQgPSBnZXRfbnVtX2VsZW1lbnRzKGdyb3Vwcywg
JzonKTsKQEAgLTYxNyw2ICs2MTksMTMgQEAgdGxzX2N0eF9zZXRfdGxzX2dyb3VwcyhzdHJ1
Y3QgdGxzX3Jvb3RfY3R4ICpjdHgsIGNvbnN0IGNoYXIgKmdyb3VwcykKICAgICAgICAgICAg
ICAgICAgICBncm91cHMpOwogICAgIH0KICAgICBnY19mcmVlKCZnYyk7CisjZWxzZQorICAg
IGlmICghU1NMX0NUWF9zZXQxX2dyb3Vwc19saXN0KGN0eC0+Y3R4LCBncm91cHMpKQorICAg
IHsKKyAgICAgICAgY3J5cHRvX21zZyhNX0ZBVEFMLCAiRmFpbGVkIHRvIHNldCBhbGxvd2Vk
IFRMUyBncm91cCBsaXN0OiAlcyIsCisgICAgICAgICAgICAgICAgICAgZ3JvdXBzKTsKKyAg
ICB9CisjZW5kaWYKIH0KIAogdm9pZAo=

--------------R7Vc4ghb5bS7OcSyaMxuf8HS--

