Message-ID: <4BF14A59.2000200@...1369...>
Date: Mon, 17 May 2010 15:53:29 +0200
From: Martin Mokrejs <mmokrejs@...1369...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030407060507090909040504"
Subject: [Openvpn-devel] openvpn-2.1.0-r1: easy-rsa tools creates broken
 client CERTs unusable for TLS
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
--------------030407060507090909040504
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,
  I think the easy-rsa/openssl.cnf file should be modified so thet client
CERTs would match current openVPN expectations. Please see my bug report
at http://bugs.gentoo.org/show_bug.cgi?id=320171 . For convenience, I am
attaching the patch here. Did I get it right what has to be done? Would
someone fix the HOWTO and FAQ documentation to describe the keyUsage
fields and what is actually required for what? There is too many hit
in google for "unsupported certificate purpose". ;)

Regards
Martin

--------------030407060507090909040504
Content-Type: text/plain;
 name="openssl.cf.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="openssl.cf.diff"

LS0tIC91c3Ivc2hhcmUvb3BlbnZwbi9lYXN5LXJzYS9vcGVuc3NsLmNuZgkyMDEwLTA1LTE3
IDE0OjUxOjAyLjAwMDAwMDAwMCArMDIwMAorKysgb3BlbnNzbC5jbmYJMjAxMC0wNS0xNyAx
NDozNjowNS4wMDAwMDAwMDAgKzAyMDAKQEAgLTE3Myw3ICsxNzMsNyBAQAogIyB0aGUgY2Vy
dGlmaWNhdGUgY2FuIGJlIHVzZWQgZm9yIGFueXRoaW5nICpleGNlcHQqIG9iamVjdCBzaWdu
aW5nLgogCiAjIFRoaXMgaXMgT0sgZm9yIGFuIFNTTCBzZXJ2ZXIuCi0jIG5zQ2VydFR5cGUJ
CQk9IHNlcnZlcgorIyBuc0NlcnRUeXBlCQkJPSBjbGllbnQsIHNlcnZlciwgZW1haWwKIAog
IyBGb3IgYW4gb2JqZWN0IHNpZ25pbmcgY2VydGlmaWNhdGUgdGhpcyB3b3VsZCBiZSB1c2Vk
LgogIyBuc0NlcnRUeXBlID0gb2Jqc2lnbgpAQCAtMTgyLDcgKzE4Miw3IEBACiAjIG5zQ2Vy
dFR5cGUgPSBjbGllbnQsIGVtYWlsCiAKICMgYW5kIGZvciBldmVyeXRoaW5nIGluY2x1ZGlu
ZyBvYmplY3Qgc2lnbmluZzoKLSMgbnNDZXJ0VHlwZSA9IGNsaWVudCwgZW1haWwsIG9ianNp
Z24KKyMgbnNDZXJ0VHlwZSA9IHNlcnZlciwgY2xpZW50LCBlbWFpbCwgb2Jqc2lnbgogCiAj
IFRoaXMgaXMgdHlwaWNhbCBpbiBrZXlVc2FnZSBmb3IgYSBjbGllbnQgY2VydGlmaWNhdGUu
CiAjIGtleVVzYWdlID0gbm9uUmVwdWRpYXRpb24sIGRpZ2l0YWxTaWduYXR1cmUsIGtleUVu
Y2lwaGVybWVudApAQCAtMTkzLDggKzE5Myw5IEBACiAjIFBLSVggcmVjb21tZW5kYXRpb25z
IGhhcm1sZXNzIGlmIGluY2x1ZGVkIGluIGFsbCBjZXJ0aWZpY2F0ZXMuCiBzdWJqZWN0S2V5
SWRlbnRpZmllcj1oYXNoCiBhdXRob3JpdHlLZXlJZGVudGlmaWVyPWtleWlkLGlzc3Vlcjph
bHdheXMKLWV4dGVuZGVkS2V5VXNhZ2U9Y2xpZW50QXV0aAota2V5VXNhZ2UgPSBkaWdpdGFs
U2lnbmF0dXJlCitleHRlbmRlZEtleVVzYWdlPWNsaWVudEF1dGgsc2VydmVyQXV0aAorI2V4
dGVuZGVkS2V5VXNhZ2U9Y2xpZW50QXV0aCxzZXJ2ZXJBdXRoLGlwc2VjVXNlcixpcHNlY1R1
bm5lbCxpcHNlY0VuZFN5c3RlbQora2V5VXNhZ2UgPSBkaWdpdGFsU2lnbmF0dXJlLCBrZXlF
bmNpcGhlcm1lbnQKIAogIyBUaGlzIHN0dWZmIGlzIGZvciBzdWJqZWN0QWx0TmFtZSBhbmQg
aXNzdWVyQWx0bmFtZS4KICMgSW1wb3J0IHRoZSBlbWFpbCBhZGRyZXNzLgo=
--------------030407060507090909040504--

