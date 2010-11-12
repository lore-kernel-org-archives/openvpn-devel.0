Message-ID: <4CDD641F.30408@...515...>
Date: Fri, 12 Nov 2010 17:58:23 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030904080301010606050308"
Subject: [Openvpn-devel] [PATCH] Removed hardcoded signtool dependency from
	win/build_all.py
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------030904080301010606050308
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit



--------------030904080301010606050308
Content-Type: text/x-patch;
	name="0001-Removed-hardcoded-signtool-dependency-from-win-build.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
	filename*0="0001-Removed-hardcoded-signtool-dependency-from-win-build.pa";
	filename*1="tch"

RnJvbSA1N2I5ODNkYzJhMWY0YTMxZDNiN2MwZTJmNmRlN2Y3NzhkMjM0YjJlIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiA9P3V0Zi04P3E/U2FtdWxpPTIwU2VwcD1DMz1BNG5l
bj89IDxzYW11bGlAb3BlbnZwbi5uZXQ+CkRhdGU6IEZyaSwgMTIgTm92IDIwMTAgMTc6MzI6
MTkgKzAyMDAKU3ViamVjdDogW1BBVENIXSBSZW1vdmVkIGhhcmRjb2RlZCBzaWdudG9vbCBk
ZXBlbmRlbmN5IGZyb20gd2luL2J1aWxkX2FsbC5weQoKTW9kaWZpZWQgd2luL2J1aWxkX2Fs
bC5weSBzbyB0aGF0IGJ1aWxkIGRvZXMgbm90IGZhaWwgZXZlbiBpZiB0aGUgb3B0aW9uYWwK
c2lnbnRvb2wgcHl0aG9uIGNsYXNzIGlzIG5vdCBhdmFpbGFibGUuCi0tLQogd2luL2J1aWxk
X2FsbC5weSB8ICAgMTAgKysrKysrKystLQogMSBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvd2luL2J1aWxkX2FsbC5weSBi
L3dpbi9idWlsZF9hbGwucHkKaW5kZXggOTJkMmJmNC4uMzhjMTY0NSAxMDA2NDQKLS0tIGEv
d2luL2J1aWxkX2FsbC5weQorKysgYi93aW4vYnVpbGRfYWxsLnB5CkBAIC0xLDcgKzEsNiBA
QAogZnJvbSBjb25maWdfYWxsIGltcG9ydCBtYWluIGFzIGNvbmZpZ19hbGwNCiBmcm9tIGJ1
aWxkIGltcG9ydCBtYWluIGFzIGJ1aWxkX29wZW52cG4NCiBmcm9tIGJ1aWxkX2RkayBpbXBv
cnQgbWFpbiBhcyBidWlsZF9kZGsNCi1mcm9tIHNpZ24gaW1wb3J0IG1haW4gYXMgc2lnbg0K
IGZyb20gbWFrZV9kaXN0IGltcG9ydCBtYWluIGFzIG1ha2VfZGlzdA0KIA0KIGRlZiBtYWlu
KGNvbmZpZyk6DQpAQCAtOSw3ICs4LDE0IEBAIGRlZiBtYWluKGNvbmZpZyk6CiAgICAgYnVp
bGRfb3BlbnZwbigpDQogICAgIGJ1aWxkX2Rkayhjb25maWcsICd0YXAnLCAnYWxsJykNCiAg
ICAgYnVpbGRfZGRrKGNvbmZpZywgJ3RhcGluc3RhbGwnLCAnYWxsJykNCi0gICAgc2lnbihj
b25maWcsICdhbGwnKQ0KKw0KKyAgICAjIFNpZ24gdGhlIGRyaXZlcnMgb25seSBpZiAic2ln
biIgbW9kdWxlIGlzIGF2YWlsYWJsZQ0KKyAgICB0cnk6DQorICAgICAgIGZyb20gc2lnbiBp
bXBvcnQgbWFpbiBhcyBzaWduDQorICAgICAgIHNpZ24oY29uZmlnLCAnYWxsJykNCisgICAg
ZXhjZXB0IChJbXBvcnRFcnJvcik6DQorICAgICAgIHBhc3MNCisNCiAgICAgbWFrZV9kaXN0
KGNvbmZpZykNCiANCiAjIGlmIHdlIGFyZSBydW4gZGlyZWN0bHksIGFuZCBub3QgbG9hZGVk
IGFzIGEgbW9kdWxlDQotLSAKMS42LjMuMwoK
--------------030904080301010606050308--

