Message-ID: <4CE2A7F9.2020402@...515...>
Date: Tue, 16 Nov 2010 17:49:13 +0200
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <4CDD641F.30408@...515...>
	<20101112163620.27677.qmail@...1287...>	<4CDD704B.7080505@...1114...>	<20101112165541.29963.qmail@...1287...>	<4CDD7309.3030808@...1114...>
	<4CDD7559.5000604@...515...>	<4CDD77B9.8050606@...1114...>
	<4CDD7D32.2050401@...515...> <20101112175153.4861.qmail@...1287...>
In-Reply-To: <20101112175153.4861.qmail@...1287...>
Content-Type: multipart/mixed; boundary="------------070503070801020003040208"
Subject: Re: [Openvpn-devel] [PATCH] Removed hardcoded signtool	dependency
 from win/build_all.py
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
--------------070503070801020003040208
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


>> I agree that there should be no way one could make an unsigned build by
>> mistake. I think dazo's suggestion about having a command-line switch
>> ("force unsigned build") is a good one. The SIGNTOOL variable could then
>> be used to just locate signtool.exe and nothing else. This would make it
>> behave the same way as most other variables in "settings.in" and allow
>> making signed and unsigned builds using the same configuration file.
>>=20=20=20=20=20
>
> Acked-by: Peter Stuge <peter@...1287...>
>=20=20=20
Ok, here's the next version of the patch; see commit message for
details. Applies on top of original code, not my earlier patches. Tested
on WinXP and everything seems to work ok. No changes to files using the
SIGNTOOL variable from "settings.in" were necessary at this point.,
although "win/tap_span.py" may need fixing later.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------070503070801020003040208
Content-Type: text/x-patch;
	name="0001-Added-command-line-option-parser-and-an-unsigned-bui.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
	filename*0="0001-Added-command-line-option-parser-and-an-unsigned-bui.pa";
	filename*1="tch"

RnJvbSBhNGNhMWU4ZDc4MzM2NGNkNThmZjM3MGIyMTcwOGNjZDNkNjg3ZWZhIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiA9P3V0Zi04P3E/U2FtdWxpPTIwU2VwcD1DMz1BNG5l
bj89IDxzYW11bGlAb3BlbnZwbi5uZXQ+CkRhdGU6IFR1ZSwgMTYgTm92IDIwMTAgMTc6Mjg6
NTQgKzAyMDAKU3ViamVjdDogW1BBVENIXSBBZGRlZCBjb21tYW5kLWxpbmUgb3B0aW9uIHBh
cnNlciBhbmQgYW4gdW5zaWduZWQgYnVpbGQgb3B0aW9uIHRvIGJ1aWxkX2FsbC5weQoKTW9k
aWZpZWQgd2luL2J1aWxkX2FsbC5weSBzbyB0aGF0IGl0IHBhcnNlcyBjb21tYW5kLWxpbmUg
b3B0aW9ucyB1c2luZyBnZXRvcHQuCkFkZGVkIG9wdGlvbiAiLXUgLyAtLXVuc2lnbmVkIiB3
aGljaCBhbGxvd3MgZm9yY2luZyB1bnNpZ25lZCBidWlsZHMgYW5kIGEgIi1oIC8KLS1oZWxw
IiBvcHRpb24uIEJ5IGRlZmF1bHQgYSBzaWduZWQgYnVpbGQgaXMgZ2VuZXJhdGVkLCBwcm92
aWRlZCB0aGF0IHRoZSBQeXRob24KU2lnblRvb2wgbW9kdWxlIGlzIGluc3RhbGxlZC4gSWYg
bm90LCB0aGUgYnVpbGQgaXMgaW50ZXJydXB0ZWQuCi0tLQogd2luL2J1aWxkX2FsbC5weSB8
ICAgNDggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0t
CiAxIGZpbGVzIGNoYW5nZWQsIDQ2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvd2luL2J1aWxkX2FsbC5weSBiL3dpbi9idWlsZF9hbGwucHkKaW5kZXgg
OTJkMmJmNC4uNmQxZDk1NiAxMDA2NDQKLS0tIGEvd2luL2J1aWxkX2FsbC5weQorKysgYi93
aW4vYnVpbGRfYWxsLnB5CkBAIC0xLDE1ICsxLDU5IEBACitpbXBvcnQgZ2V0b3B0LCBzeXMN
CiBmcm9tIGNvbmZpZ19hbGwgaW1wb3J0IG1haW4gYXMgY29uZmlnX2FsbA0KIGZyb20gYnVp
bGQgaW1wb3J0IG1haW4gYXMgYnVpbGRfb3BlbnZwbg0KIGZyb20gYnVpbGRfZGRrIGltcG9y
dCBtYWluIGFzIGJ1aWxkX2Rkaw0KLWZyb20gc2lnbiBpbXBvcnQgbWFpbiBhcyBzaWduDQog
ZnJvbSBtYWtlX2Rpc3QgaW1wb3J0IG1haW4gYXMgbWFrZV9kaXN0DQogDQorZGVmIFVzYWdl
KCk6DQorICAgICcnJ1Nob3cgdXNhZ2UgaW5mb3JtYXRpb24nJycNCisgICAgcHJpbnQgIlVz
YWdlOiBidWlsZF9hbGwucHkgW09QVElPTlNdLi4uIg0KKyAgICBwcmludCAiQnVpbGQgT3Bl
blZQTiB1c2luZyBWaXN1YWwgU3R1ZGlvIHRvb2xzIg0KKyAgICBwcmludA0KKyAgICBwcmlu
dCAiIC1oLCAtLWhlbHAJCVNob3cgdGhpcyBoZWxwIg0KKyAgICBwcmludCAiIC11LCAtLXVu
c2lnbmVkCURvIG5vdCBzaWduIHRoZSBUQVAgZHJpdmVycyINCisgICAgc3lzLmV4aXQoMSkN
CisNCiBkZWYgbWFpbihjb25maWcpOg0KKw0KKyAgICAjIERvIGEgc2lnbmVkIGJ1aWxkIGJ5
IGRlZmF1bHQNCisgICAgdW5zaWduZWRCdWlsZD1GYWxzZQ0KKw0KKyAgICAjIFBhcnNlIHRo
ZSBjb21tYW5kIGxpbmUgYXJndW1lbnQocykNCisgICAgdHJ5Og0KKyAgICAgICAjIEFyZ3Vt
ZW50cyB0aGF0IGFyZSBmb2xsb3dlZCBieSBhIDogcmVxdWlyZSBhIHZhbHVlIGZyb20gdXNl
cg0KKyAgICAgICBvcHRzLCBhcmdzID0gZ2V0b3B0LmdldG9wdChzeXMuYXJndlsxOl0sICJo
dSIsIFsiaGVscCIsICJ1bnNpZ25lZCJdKQ0KKyAgICBleGNlcHQgZ2V0b3B0LkdldG9wdEVy
cm9yOg0KKyAgICAgICBVc2FnZSgpDQorICAgICAgIHN5cy5leGl0KDEpDQorDQorICAgIGZv
ciBvLCBhIGluIG9wdHM6DQorICAgICAgIGlmIG8gaW4gKCItaCIsIi0taGVscCIpOg0KKyAg
ICAgICAgICBVc2FnZSgpDQorICAgICAgIGlmIG8gaW4gKCItdSIsICItLXVuc2lnbmVkIik6
DQorICAgICAgICAgIHVuc2lnbmVkQnVpbGQ9VHJ1ZQ0KKw0KKw0KKyAgICAjIENoZWNrIGlm
IHRoZSBTaWduVG9vbCBtb2R1bGUgaXMgcHJlc2VudC4gVGhpcyBhdm9pZHMgSW1wb3J0RXJy
b3JzIHBvcHBpbmcgDQorICAgICMgdXAgYW5ub3lpbmdseSBfYWZ0ZXJfIHRoZSBidWlsZC4N
CisgICAgaWYgdW5zaWduZWRCdWlsZCA9PSBGYWxzZToNCisgICAgICAgdHJ5Og0KKyAgICAg
ICAgICBmcm9tIHNpZ250b29sIGltcG9ydCBTaWduVG9vbA0KKyAgICAgICBleGNlcHQgKElt
cG9ydEVycm9yKToNCisgICAgICAgICAgcHJpbnQgIkVSUk9SOiBTaWduVG9vbCBweXRob24g
bW9kdWxlIG5vdCBmb3VuZCEgQ2FuJ3QgZG8gYSBzaWduZWQgYnVpbGQuIg0KKyAgICAgICAg
ICBzeXMuZXhpdCgxKQ0KKw0KKyAgICBpZiB1bnNpZ25lZEJ1aWxkID09IFRydWU6DQorICAg
ICAgIHByaW50ICJEb2luZyBhbiB1bnNpZ25lZCBidWlsZCBhcyByZXF1ZXN0ZWQiDQorDQor
ICAgICMgU3RhcnQgdGhlIGJ1aWxkDQogICAgIGNvbmZpZ19hbGwoY29uZmlnKQ0KICAgICBi
dWlsZF9vcGVudnBuKCkNCiAgICAgYnVpbGRfZGRrKGNvbmZpZywgJ3RhcCcsICdhbGwnKQ0K
ICAgICBidWlsZF9kZGsoY29uZmlnLCAndGFwaW5zdGFsbCcsICdhbGwnKQ0KLSAgICBzaWdu
KGNvbmZpZywgJ2FsbCcpDQorDQorICAgIGlmIHVuc2lnbmVkQnVpbGQgPT0gRmFsc2U6DQor
ICAgICAgIHNpZ24oY29uZmlnLCAnYWxsJykNCisNCiAgICAgbWFrZV9kaXN0KGNvbmZpZykN
CiANCiAjIGlmIHdlIGFyZSBydW4gZGlyZWN0bHksIGFuZCBub3QgbG9hZGVkIGFzIGEgbW9k
dWxlDQotLSAKMS42LjMuMwoK
--------------070503070801020003040208--

