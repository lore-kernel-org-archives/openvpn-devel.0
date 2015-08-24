From: Boris Lytochkin <lytboris@...2010...>
Message-ID: <55DB4C39.9040105@...2010...>
Date: Mon, 24 Aug 2015 19:54:17 +0300
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000402090409050205030203"
Subject: [Openvpn-devel] Log cert serial no if it is revoked
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------000402090409050205030203
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

Author: Boris Lytochkin <lytboris@...2010...>
Sponsored-by: Yandex LLC

Log serial number of revoked certificate

In most of situations admin of OpenVPN server needs to know which particular certificate is used by client.
In the case when certificate is OK, environment variable can be used for that but once it is revoked no user scripts are invoked so there is no way to get serial number: only subject is printed in 
logs. Patch attached addresses this issue logging certificate directly on the line with certificate subject.

Tested with OpenSSL but PolarSSL should be good too.

Signed-off-by Boris Lytochkin <lytboris@...2010...>

-- 
Boris Lytochkin
Yandex NOC
+7 (495) 739 70 00 ext. 7671


--------------000402090409050205030203
Content-Type: text/plain; charset=UTF-8;
	name="openvpn-log-cert-serial-for-revoked.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="openvpn-log-cert-serial-for-revoked.patch"

ZGlmZiAtLWdpdCBhL3NyYy9vcGVudnBuL3NzbF92ZXJpZnlfb3BlbnNzbC5jIGIvc3JjL29w
ZW52cG4vc3NsX3ZlcmlmeV9vcGVuc3NsLmMKaW5kZXggODFiMmUzOC4uMGEzY2JlNiAxMDA2
NDQKLS0tIGEvc3JjL29wZW52cG4vc3NsX3ZlcmlmeV9vcGVuc3NsLmMKKysrIGIvc3JjL29w
ZW52cG4vc3NsX3ZlcmlmeV9vcGVuc3NsLmMKQEAgLTU4NSw2ICs1ODUsNyBAQCB4NTA5X3Zl
cmlmeV9jcmwoY29uc3QgY2hhciAqY3JsX2ZpbGUsIFg1MDkgKnBlZXJfY2VydCwgY29uc3Qg
Y2hhciAqc3ViamVjdCkKICAgQklPICppbj1OVUxMOwogICBpbnQgbixpOwogICByZXN1bHRf
dCByZXR2YWwgPSBGQUlMVVJFOworICBzdHJ1Y3QgZ2NfYXJlbmEgZ2MgPSBnY19uZXcoKTsK
IAogICBpbiA9IEJJT19uZXdfZmlsZSAoY3JsX2ZpbGUsICJyIik7CiAKQEAgLTYwOSw3ICs2
MTAsNyBAQCB4NTA5X3ZlcmlmeV9jcmwoY29uc3QgY2hhciAqY3JsX2ZpbGUsIFg1MDkgKnBl
ZXJfY2VydCwgY29uc3QgY2hhciAqc3ViamVjdCkKICAgZm9yIChpID0gMDsgaSA8IG47IGkr
KykgewogICAgIHJldm9rZWQgPSAoWDUwOV9SRVZPS0VEICopc2tfWDUwOV9SRVZPS0VEX3Zh
bHVlKFg1MDlfQ1JMX2dldF9SRVZPS0VEKGNybCksIGkpOwogICAgIGlmIChBU04xX0lOVEVH
RVJfY21wKHJldm9rZWQtPnNlcmlhbE51bWJlciwgWDUwOV9nZXRfc2VyaWFsTnVtYmVyKHBl
ZXJfY2VydCkpID09IDApIHsKLSAgICAgIG1zZyAoRF9IQU5EU0hBS0UsICJDUkwgQ0hFQ0sg
RkFJTEVEOiAlcyBpcyBSRVZPS0VEIixzdWJqZWN0KTsKKyAgICAgIG1zZyAoRF9IQU5EU0hB
S0UsICJDUkwgQ0hFQ0sgRkFJTEVEOiAlcyAoc2VyaWFsICVzKSBpcyBSRVZPS0VEIiwgc3Vi
amVjdCwgYmFja2VuZF94NTA5X2dldF9zZXJpYWxfaGV4KHBlZXJfY2VydCwgJmdjKSk7CiAg
ICAgICBnb3RvIGVuZDsKICAgICB9CiAgIH0KQEAgLTYxOCw2ICs2MTksNyBAQCB4NTA5X3Zl
cmlmeV9jcmwoY29uc3QgY2hhciAqY3JsX2ZpbGUsIFg1MDkgKnBlZXJfY2VydCwgY29uc3Qg
Y2hhciAqc3ViamVjdCkKICAgbXNnIChEX0hBTkRTSEFLRSwgIkNSTCBDSEVDSyBPSzogJXMi
LHN1YmplY3QpOwogCiBlbmQ6CisgIGdjX2ZyZWUoJmdjKTsKICAgQklPX2ZyZWUoaW4pOwog
ICBpZiAoY3JsKQogICAgIFg1MDlfQ1JMX2ZyZWUgKGNybCk7CmRpZmYgLS1naXQgYS9zcmMv
b3BlbnZwbi9zc2xfdmVyaWZ5X3BvbGFyc3NsLmMgYi9zcmMvb3BlbnZwbi9zc2xfdmVyaWZ5
X3BvbGFyc3NsLmMKaW5kZXggMmVkZjIxZC4uMTQ3MzBmMiAxMDA2NDQKLS0tIGEvc3JjL29w
ZW52cG4vc3NsX3ZlcmlmeV9wb2xhcnNzbC5jCisrKyBiL3NyYy9vcGVudnBuL3NzbF92ZXJp
ZnlfcG9sYXJzc2wuYwpAQCAtMzczLDYgKzM3Myw3IEBAIHg1MDlfdmVyaWZ5X2NybChjb25z
dCBjaGFyICpjcmxfZmlsZSwgeDUwOV9jcnQgKmNlcnQsIGNvbnN0IGNoYXIgKnN1YmplY3Qp
CiB7CiAgIHJlc3VsdF90IHJldHZhbCA9IEZBSUxVUkU7CiAgIHg1MDlfY3JsIGNybCA9IHsw
fTsKKyAgc3RydWN0IGdjX2FyZW5hIGdjID0gZ2NfbmV3KCk7CiAKICAgaW50IHBvbGFyX3Jl
dHZhbCA9IHg1MDlfY3JsX3BhcnNlX2ZpbGUoJmNybCwgY3JsX2ZpbGUpOwogICBpZiAocG9s
YXJfcmV0dmFsICE9IDApCkBAIC0zOTQsNyArMzk1LDcgQEAgeDUwOV92ZXJpZnlfY3JsKGNv
bnN0IGNoYXIgKmNybF9maWxlLCB4NTA5X2NydCAqY2VydCwgY29uc3QgY2hhciAqc3ViamVj
dCkKIAogICBpZiAoMCAhPSB4NTA5X2NydF9yZXZva2VkKGNlcnQsICZjcmwpKQogICAgIHsK
LSAgICAgIG1zZyAoRF9IQU5EU0hBS0UsICJDUkwgQ0hFQ0sgRkFJTEVEOiAlcyBpcyBSRVZP
S0VEIiwgc3ViamVjdCk7CisgICAgICBtc2cgKERfSEFORFNIQUtFLCAiQ1JMIENIRUNLIEZB
SUxFRDogJXMgKHNlcmlhbCAlcykgaXMgUkVWT0tFRCIsIHN1YmplY3QsIGJhY2tlbmRfeDUw
OV9nZXRfc2VyaWFsX2hleChjZXJ0LCAmZ2MpKTsKICAgICAgIGdvdG8gZW5kOwogICAgIH0K
IApAQCAtNDAyLDYgKzQwMyw3IEBAIHg1MDlfdmVyaWZ5X2NybChjb25zdCBjaGFyICpjcmxf
ZmlsZSwgeDUwOV9jcnQgKmNlcnQsIGNvbnN0IGNoYXIgKnN1YmplY3QpCiAgIG1zZyAoRF9I
QU5EU0hBS0UsICJDUkwgQ0hFQ0sgT0s6ICVzIixzdWJqZWN0KTsKIAogZW5kOgorICBnY19m
cmVlKCZnYyk7CiAgIHg1MDlfY3JsX2ZyZWUoJmNybCk7CiAgIHJldHVybiByZXR2YWw7CiB9
Cg==
--------------000402090409050205030203--

