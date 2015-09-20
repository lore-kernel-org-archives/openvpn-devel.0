References: <55DB4C39.9040105@...2010...>
	<55DDBBE2.9010205@...1114...> <55F7EFD0.1040501@...2010...>
	<CAA1Abx+EBkkGhSLBnGonHdLur4g3w4cm44U_nDP7UhMuNxXrUg@...278...>
	<55FE9852.5040600@...1856...>
From: Boris Lytochkin <lytboris@...2010...>
Message-ID: <55FEBF7E.3010209@...2010...>
Date: Sun, 20 Sep 2015 17:15:26 +0300
MIME-Version: 1.0
In-Reply-To: <55FE9852.5040600@...1856...>
Content-Type: multipart/mixed; boundary="------------010905020606040203010907"
Subject: Re: [Openvpn-devel] Log cert serial no if it is revoked
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------010905020606040203010907
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

v2 patch is attached.

Thanks for comments!

On 20.09.2015 14:28, Steffan Karger wrote:
>
> On 15-09-15 23:49, Steffan Karger wrote:
>> I agree that the functionality makes, but need to look at the code.  I'm
>> currently on a long holiday and haven't had enough spare cycles to spend
>> on openvpn. After I get back (next week), this will be part of my 
>> backlog :)
>
> I looked at the code this morning, and tested with both OpenSSL and 
> PolarSSL.  The functionality makes sense.  The serial formatting is a 
> bit confusing ("serial 12" is actually serial 0x12, or 18 in dec), but 
> this matches 'openssl crl -text' output, and putting 0x in front will 
> make the longer AA:BB:CC formatting look weird...  So I guess I'm fine 
> with this.
>
> Regarding
> <cut>
> backend_x509_get_serial_hex() may return NULL, and passing NULL as a 
> string format specifier to printf() results in undefined behaviour.  
> So please add a NULL check before passing the string to msg().
>
> Finally, when you send a v2 of this patch, could you use 'git 
> format-patch' to create a patch file with a clear commit message 
> explaining why this change is useful? (Your original email probably 
> suffices).
>
> -Steffan

-- 
Boris Lytochkin
Yandex NOC
+7 (495) 739 70 00 ext. 7671


--------------010905020606040203010907
Content-Type: text/plain; charset=UTF-8;
	name="0001-Log-serial-number-of-revoked-certificate.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="0001-Log-serial-number-of-revoked-certificate.patch"

RnJvbSBlODM2OGVmMWI3ZDE4ZTE4OGRjNjZjMDE3ZGM4MWM3ZjE1ZjY2YWIwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBCb3JpcyBMeXRvY2hraW4gPGx5dGJvcmlzQHlhbmRl
eC10ZWFtLnJ1PgpEYXRlOiBTdW4sIDIwIFNlcCAyMDE1IDE3OjA1OjIyICswMzAwClN1Ympl
Y3Q6IFtQQVRDSF0gTG9nIHNlcmlhbCBudW1iZXIgb2YgcmV2b2tlZCBjZXJ0aWZpY2F0ZQoK
SW4gbW9zdCBvZiBzaXR1YXRpb25zIGFkbWluIG9mIE9wZW5WUE4gc2VydmVyIG5lZWRzIHRv
IGtub3cgd2hpY2ggcGFydGljdWxhciBjZXJ0aWZpY2F0ZSBpcyB1c2VkIGJ5IGNsaWVudC4K
SW4gdGhlIGNhc2Ugd2hlbiBjZXJ0aWZpY2F0ZSBpcyBPSywgZW52aXJvbm1lbnQgdmFyaWFi
bGUgY2FuIGJlIHVzZWQgZm9yIHRoYXQgYnV0IG9uY2UgaXQgaXMgcmV2b2tlZApubyB1c2Vy
IHNjcmlwdHMgYXJlIGludm9rZWQgc28gdGhlcmUgaXMgbm8gd2F5IHRvIGdldCBzZXJpYWwg
bnVtYmVyOiBvbmx5IHN1YmplY3QgaXMgcHJpbnRlZCBpbiBsb2dzLgoKU28gd2UgbG9nIGNl
cnRpZmljYXRlIHNlcmlhbCBpbiBjYXNlIGl0IGlzIHJldm9rZWQuCgpTcG9uc29yZWQtYnk6
IFlhbmRleCBMTEMKClNpZ25lZC1vZmYtYnk6IEJvcmlzIEx5dG9jaGtpbiA8bHl0Ym9yaXNA
eWFuZGV4LXRlYW0ucnU+Ci0tLQogc3JjL29wZW52cG4vc3NsX3ZlcmlmeV9vcGVuc3NsLmMg
IHwgNiArKysrKy0KIHNyYy9vcGVudnBuL3NzbF92ZXJpZnlfcG9sYXJzc2wuYyB8IDYgKysr
KystCiAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvc3JjL29wZW52cG4vc3NsX3ZlcmlmeV9vcGVuc3NsLmMgYi9zcmMv
b3BlbnZwbi9zc2xfdmVyaWZ5X29wZW5zc2wuYwppbmRleCA4MWIyZTM4Li5iZjUzNTIyIDEw
MDY0NAotLS0gYS9zcmMvb3BlbnZwbi9zc2xfdmVyaWZ5X29wZW5zc2wuYworKysgYi9zcmMv
b3BlbnZwbi9zc2xfdmVyaWZ5X29wZW5zc2wuYwpAQCAtNTg1LDYgKzU4NSw4IEBAIHg1MDlf
dmVyaWZ5X2NybChjb25zdCBjaGFyICpjcmxfZmlsZSwgWDUwOSAqcGVlcl9jZXJ0LCBjb25z
dCBjaGFyICpzdWJqZWN0KQogICBCSU8gKmluPU5VTEw7CiAgIGludCBuLGk7CiAgIHJlc3Vs
dF90IHJldHZhbCA9IEZBSUxVUkU7CisgIHN0cnVjdCBnY19hcmVuYSBnYyA9IGdjX25ldygp
OworICBjaGFyICpzZXJpYWw7CiAKICAgaW4gPSBCSU9fbmV3X2ZpbGUgKGNybF9maWxlLCAi
ciIpOwogCkBAIC02MDksNyArNjExLDggQEAgeDUwOV92ZXJpZnlfY3JsKGNvbnN0IGNoYXIg
KmNybF9maWxlLCBYNTA5ICpwZWVyX2NlcnQsIGNvbnN0IGNoYXIgKnN1YmplY3QpCiAgIGZv
ciAoaSA9IDA7IGkgPCBuOyBpKyspIHsKICAgICByZXZva2VkID0gKFg1MDlfUkVWT0tFRCAq
KXNrX1g1MDlfUkVWT0tFRF92YWx1ZShYNTA5X0NSTF9nZXRfUkVWT0tFRChjcmwpLCBpKTsK
ICAgICBpZiAoQVNOMV9JTlRFR0VSX2NtcChyZXZva2VkLT5zZXJpYWxOdW1iZXIsIFg1MDlf
Z2V0X3NlcmlhbE51bWJlcihwZWVyX2NlcnQpKSA9PSAwKSB7Ci0gICAgICBtc2cgKERfSEFO
RFNIQUtFLCAiQ1JMIENIRUNLIEZBSUxFRDogJXMgaXMgUkVWT0tFRCIsc3ViamVjdCk7Cisg
ICAgICBzZXJpYWwgPSBiYWNrZW5kX3g1MDlfZ2V0X3NlcmlhbF9oZXgocGVlcl9jZXJ0LCAm
Z2MpOworICAgICAgbXNnIChEX0hBTkRTSEFLRSwgIkNSTCBDSEVDSyBGQUlMRUQ6ICVzIChz
ZXJpYWwgJXMpIGlzIFJFVk9LRUQiLCBzdWJqZWN0LCAoc2VyaWFsID8gc2VyaWFsIDogIk5P
VCBBVkFJTEFCTEUiKSk7CiAgICAgICBnb3RvIGVuZDsKICAgICB9CiAgIH0KQEAgLTYxOCw2
ICs2MjEsNyBAQCB4NTA5X3ZlcmlmeV9jcmwoY29uc3QgY2hhciAqY3JsX2ZpbGUsIFg1MDkg
KnBlZXJfY2VydCwgY29uc3QgY2hhciAqc3ViamVjdCkKICAgbXNnIChEX0hBTkRTSEFLRSwg
IkNSTCBDSEVDSyBPSzogJXMiLHN1YmplY3QpOwogCiBlbmQ6CisgIGdjX2ZyZWUoJmdjKTsK
ICAgQklPX2ZyZWUoaW4pOwogICBpZiAoY3JsKQogICAgIFg1MDlfQ1JMX2ZyZWUgKGNybCk7
CmRpZmYgLS1naXQgYS9zcmMvb3BlbnZwbi9zc2xfdmVyaWZ5X3BvbGFyc3NsLmMgYi9zcmMv
b3BlbnZwbi9zc2xfdmVyaWZ5X3BvbGFyc3NsLmMKaW5kZXggMmVkZjIxZC4uNDg1MjI0MyAx
MDA2NDQKLS0tIGEvc3JjL29wZW52cG4vc3NsX3ZlcmlmeV9wb2xhcnNzbC5jCisrKyBiL3Ny
Yy9vcGVudnBuL3NzbF92ZXJpZnlfcG9sYXJzc2wuYwpAQCAtMzczLDYgKzM3Myw4IEBAIHg1
MDlfdmVyaWZ5X2NybChjb25zdCBjaGFyICpjcmxfZmlsZSwgeDUwOV9jcnQgKmNlcnQsIGNv
bnN0IGNoYXIgKnN1YmplY3QpCiB7CiAgIHJlc3VsdF90IHJldHZhbCA9IEZBSUxVUkU7CiAg
IHg1MDlfY3JsIGNybCA9IHswfTsKKyAgc3RydWN0IGdjX2FyZW5hIGdjID0gZ2NfbmV3KCk7
CisgIGNoYXIgKnNlcmlhbDsKIAogICBpbnQgcG9sYXJfcmV0dmFsID0geDUwOV9jcmxfcGFy
c2VfZmlsZSgmY3JsLCBjcmxfZmlsZSk7CiAgIGlmIChwb2xhcl9yZXR2YWwgIT0gMCkKQEAg
LTM5NCw3ICszOTYsOCBAQCB4NTA5X3ZlcmlmeV9jcmwoY29uc3QgY2hhciAqY3JsX2ZpbGUs
IHg1MDlfY3J0ICpjZXJ0LCBjb25zdCBjaGFyICpzdWJqZWN0KQogCiAgIGlmICgwICE9IHg1
MDlfY3J0X3Jldm9rZWQoY2VydCwgJmNybCkpCiAgICAgewotICAgICAgbXNnIChEX0hBTkRT
SEFLRSwgIkNSTCBDSEVDSyBGQUlMRUQ6ICVzIGlzIFJFVk9LRUQiLCBzdWJqZWN0KTsKKyAg
ICAgIHNlcmlhbCA9IGJhY2tlbmRfeDUwOV9nZXRfc2VyaWFsX2hleChjZXJ0LCAmZ2MpOwor
ICAgICAgbXNnIChEX0hBTkRTSEFLRSwgIkNSTCBDSEVDSyBGQUlMRUQ6ICVzIChzZXJpYWwg
JXMpIGlzIFJFVk9LRUQiLCBzdWJqZWN0LCAoc2VyaWFsID8gc2VyaWFsIDogIk5PVCBBVkFJ
TEFCTEUiKSk7CiAgICAgICBnb3RvIGVuZDsKICAgICB9CiAKQEAgLTQwMiw2ICs0MDUsNyBA
QCB4NTA5X3ZlcmlmeV9jcmwoY29uc3QgY2hhciAqY3JsX2ZpbGUsIHg1MDlfY3J0ICpjZXJ0
LCBjb25zdCBjaGFyICpzdWJqZWN0KQogICBtc2cgKERfSEFORFNIQUtFLCAiQ1JMIENIRUNL
IE9LOiAlcyIsc3ViamVjdCk7CiAKIGVuZDoKKyAgZ2NfZnJlZSgmZ2MpOwogICB4NTA5X2Ny
bF9mcmVlKCZjcmwpOwogICByZXR1cm4gcmV0dmFsOwogfQotLSAKMi4xLjIKCg==
--------------010905020606040203010907--

