From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Core dump ("unaligned access") on OpenBSD3.5
 (DS10 - Alpha arch)
In-Reply-To: <200412161651.10322.csr@...331...>
Message-ID: <Pine.LNX.4.58.0412170006590.20970@...41...>
References: <200412161458.49238.csr@...331...> <Pine.LNX.4.58.0412160745480.9763@...41...>
 <200412161651.10322.csr@...331...>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1483525869-1103267489=:20970"
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
Date: Thu Dec 16 23:12:03 2004
To: Christian =?iso-8859-1?q?R=F8snes?= <csr@...331...>
Cc: openvpn-devel@lists.sourceforge.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@...24... for more info.

--8323328-1483525869-1103267489=:20970
Content-Type: TEXT/PLAIN; charset=US-ASCII

Also, try the attached patch with a standard build, i.e. optimization 
turned on and no special flags like -fno-builtin-memcpy.

I would be curious if the cast-to-char changes the memcpy inlining 
behavior to prevent the alignment fault.

Thanks,
James
--8323328-1483525869-1103267489=:20970
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="align.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0412170011290.20970@...41...>
Content-Description: 
Content-Disposition: attachment; filename="align.patch"

LS0tIG9wZW52cG4tMi4wX3JjNS9tcm91dGUuYwkyMDA0LTEyLTAyIDE0OjEy
OjAzLjAwMDAwMDAwMCAtMDYwMA0KKysrIG1yb3V0ZS5jCTIwMDQtMTItMTcg
MDA6NTE6NTMuMjc0NDE2ODcyIC0wNjAwDQpAQCAtMTA5LDE0ICsxMDksMTQg
QEANCiAJCSAgICAgIHNyYy0+dHlwZSA9IE1SX0FERFJfSVBWNDsNCiAJCSAg
ICAgIHNyYy0+bmV0Yml0cyA9IDA7DQogCQkgICAgICBzcmMtPmxlbiA9IDQ7
DQotCQkgICAgICBtZW1jcHkgKHNyYy0+YWRkciwgJmlwLT5zYWRkciwgNCk7
DQorCQkgICAgICBtZW1jcHkgKHNyYy0+YWRkciwgKHVpbnQ4X3QqKSZpcC0+
c2FkZHIsIDQpOw0KIAkJICAgIH0NCiAJCSAgaWYgKGRlc3QpDQogCQkgICAg
ew0KIAkJICAgICAgZGVzdC0+dHlwZSA9IE1SX0FERFJfSVBWNDsNCiAJCSAg
ICAgIGRlc3QtPm5ldGJpdHMgPSAwOw0KIAkJICAgICAgZGVzdC0+bGVuID0g
NDsNCi0JCSAgICAgIG1lbWNweSAoZGVzdC0+YWRkciwgJmlwLT5kYWRkciwg
NCk7DQorCQkgICAgICBtZW1jcHkgKGRlc3QtPmFkZHIsICh1aW50OF90Kikm
aXAtPmRhZGRyLCA0KTsNCiANCiAJCSAgICAgIC8qIG1jYXN0IGFkZHJlc3M/
ICovDQogCQkgICAgICBpZiAoKCgqKGluX2FkZHJfdCopZGVzdC0+YWRkcikg
JiBodG9ubChJUF9NQ0FTVF9TVUJORVRfTUFTSykpID09IGh0b25sKElQX01D
QVNUX05FVFdPUkspKQ0KQEAgLTE0NywxNCArMTQ3LDE0IEBADQogCSAgICAg
IHNyYy0+dHlwZSA9IE1SX0FERFJfRVRIRVI7DQogCSAgICAgIHNyYy0+bmV0
Yml0cyA9IDA7DQogCSAgICAgIHNyYy0+bGVuID0gNjsNCi0JICAgICAgbWVt
Y3B5IChzcmMtPmFkZHIsIGV0aC0+c291cmNlLCA2KTsNCisJICAgICAgbWVt
Y3B5IChzcmMtPmFkZHIsICh1aW50OF90KilldGgtPnNvdXJjZSwgNik7DQog
CSAgICB9DQogCSAgaWYgKGRlc3QpDQogCSAgICB7DQogCSAgICAgIGRlc3Qt
PnR5cGUgPSBNUl9BRERSX0VUSEVSOw0KIAkgICAgICBkZXN0LT5uZXRiaXRz
ID0gMDsNCiAJICAgICAgZGVzdC0+bGVuID0gNjsNCi0JICAgICAgbWVtY3B5
IChkZXN0LT5hZGRyLCBldGgtPmRlc3QsIDYpOw0KKwkgICAgICBtZW1jcHkg
KGRlc3QtPmFkZHIsICh1aW50OF90KilldGgtPmRlc3QsIDYpOw0KIA0KIAkg
ICAgICAvKiBldGhlcm5ldCBicm9hZGNhc3QvbXVsdGljYXN0IHBhY2tldD8g
Ki8NCiAJICAgICAgaWYgKGlzX21hY19tY2FzdF9hZGRyIChldGgtPmRlc3Qp
KQ0K

--8323328-1483525869-1103267489=:20970--

