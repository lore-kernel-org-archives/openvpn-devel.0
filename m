Date: Sat, 8 Jun 2013 07:33:26 +0200 (CEST)
From: Tamas TEVESZ <ice@...1828...>
Message-ID: <alpine.GSO.2.03.1306080732510.23277@...1828...>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="1883114707-2133827701-1370669606=:23277"
Subject: [Openvpn-devel] support client-cert-not-required with polarssl
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1883114707-2133827701-1370669606=:23277
Content-Type: TEXT/PLAIN; charset=US-ASCII


hi,

the attached patch adds support for --client-cert-not-required with 
polarssl. please apply.

thanks,


-- 
[-]

mkdir /nonexistent
--1883114707-2133827701-1370669606=:23277
Content-Type: TEXT/x-diff;
	name=0001-Add-support-for-client-cert-not-required-for-PolarSS.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.GSO.2.03.1306080733260.23277@...1828...>
Content-Description: 
Content-Disposition: attachment;
	filename=0001-Add-support-for-client-cert-not-required-for-PolarSS.patch

RnJvbSA5NjhkZGFkMWYzMjY0MWYwMjE4ZTUzNjIwOTJhNGIyMDY2NTI5NDA1
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogVGFtYXMgVEVWRVNa
IDxpY2VAZXh0cmVtZS5odT4NCkRhdGU6IFNhdCwgOCBKdW4gMjAxMyAwNzow
MDoxNiArMDIwMA0KU3ViamVjdDogW1BBVENIXSBBZGQgc3VwcG9ydCBmb3Ig
Y2xpZW50LWNlcnQtbm90LXJlcXVpcmVkIGZvciBQb2xhclNTTC4NCg0KU2ln
bmVkLW9mZi1ieTogVGFtYXMgVEVWRVNaIDxpY2VAZXh0cmVtZS5odT4NCi0t
LQ0KIHNyYy9vcGVudnBuL3NzbF9wb2xhcnNzbC5jIHwgICAxNiArKysrKysr
KysrKysrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9zcmMvb3BlbnZwbi9z
c2xfcG9sYXJzc2wuYyBiL3NyYy9vcGVudnBuL3NzbF9wb2xhcnNzbC5jDQpp
bmRleCBhODJiMjMzLi44YTkxN2IzIDEwMDY0NA0KLS0tIGEvc3JjL29wZW52
cG4vc3NsX3BvbGFyc3NsLmMNCisrKyBiL3NyYy9vcGVudnBuL3NzbF9wb2xh
cnNzbC5jDQpAQCAtNTMzLDggKzUzMywyMCBAQCB2b2lkIGtleV9zdGF0ZV9z
c2xfaW5pdChzdHJ1Y3Qga2V5X3N0YXRlX3NzbCAqa3Nfc3NsLA0KIAlzc2xf
c2V0X293bl9jZXJ0KCBrc19zc2wtPmN0eCwgc3NsX2N0eC0+Y3J0X2NoYWlu
LCBzc2xfY3R4LT5wcml2X2tleSApOw0KIA0KICAgICAgIC8qIEluaXRpYWxp
c2UgU1NMIHZlcmlmaWNhdGlvbiAqLw0KLSAgICAgIHNzbF9zZXRfYXV0aG1v
ZGUgKGtzX3NzbC0+Y3R4LCBTU0xfVkVSSUZZX1JFUVVJUkVEKTsNCi0gICAg
ICBzc2xfc2V0X3ZlcmlmeSAoa3Nfc3NsLT5jdHgsIHZlcmlmeV9jYWxsYmFj
aywgc2Vzc2lvbik7DQorI2lmIFAyTVBfU0VSVkVSDQorICAgICAgaWYgKHNl
c3Npb24tPm9wdC0+c3NsX2ZsYWdzICYgU1NMRl9DTElFTlRfQ0VSVF9OT1Rf
UkVRVUlSRUQpDQorCXsNCisJICBtc2cgKE1fV0FSTiwgIldBUk5JTkc6IFBP
VEVOVElBTExZIERBTkdFUk9VUyBPUFRJT04gIg0KKwkgICAiLS1jbGllbnQt
Y2VydC1ub3QtcmVxdWlyZWQgbWF5IGFjY2VwdCBjbGllbnRzIHdoaWNoIGRv
IG5vdCBwcmVzZW50ICINCisJICAgImEgY2VydGlmaWNhdGUiKTsNCisJfQ0K
KyAgICAgIGVsc2UNCisjZW5kaWYNCisgICAgICB7DQorCXNzbF9zZXRfYXV0
aG1vZGUgKGtzX3NzbC0+Y3R4LCBTU0xfVkVSSUZZX1JFUVVJUkVEKTsNCisJ
c3NsX3NldF92ZXJpZnkgKGtzX3NzbC0+Y3R4LCB2ZXJpZnlfY2FsbGJhY2ss
IHNlc3Npb24pOw0KKyAgICAgIH0NCisNCiAgICAgICAvKiBUT0RPOiBQb2xh
clNTTCBkb2VzIG5vdCBjdXJyZW50bHkgc3VwcG9ydCBzZW5kaW5nIHRoZSBD
QSBjaGFpbiB0byB0aGUgY2xpZW50ICovDQogICAgICAgc3NsX3NldF9jYV9j
aGFpbiAoa3Nfc3NsLT5jdHgsIHNzbF9jdHgtPmNhX2NoYWluLCBOVUxMLCBO
VUxMICk7DQogDQotLSANCjEuNy45LjUNCg0K

--1883114707-2133827701-1370669606=:23277--

