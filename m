Message-ID: <4CE54F2C.9040405@...515...>
Date: Thu, 18 Nov 2010 18:07:08 +0200
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <4CDD641F.30408@...515...>
	<20101112163620.27677.qmail@...1287...>	<4CDD704B.7080505@...1114...>	<20101112165541.29963.qmail@...1287...>	<4CDD7309.3030808@...1114...>
	<4CDD7559.5000604@...515...>	<4CDD77B9.8050606@...1114...>
	<4CDD7D32.2050401@...515...>	<20101112175153.4861.qmail@...1287...>
	<4CE2A7F9.2020402@...515...>
	<20101116155849.23656.qmail@...1287...>
In-Reply-To: <20101116155849.23656.qmail@...1287...>
Content-Type: multipart/mixed; boundary="------------020506000303070205090007"
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
--------------020506000303070205090007
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


> Samuli Sepp=C3=A4nen wrote:
>=20=20=20
>> here's the next version of the patch;
>>=20=20=20=20=20
>
> Functionally fine!
>
>
>=20=20=20
>>  def main(config):
>> +
>> +    # Do a signed build by default
>> +    unsignedBuild=3DFalse
>>=20=20=20=20=20
>
> Maybe name the option signedBuild instead? :)
>
>
>=20=20=20
>> +    # Check if the SignTool module is present. This avoids ImportErrors=
 popping=20
>> +    # up annoyingly _after_ the build.
>> +    if unsignedBuild =3D=3D False:
>> +       try:
>> +          from signtool import SignTool
>> +       except (ImportError):
>> +          print "ERROR: SignTool python module not found! Can't do a si=
gned build."
>> +          sys.exit(1)
>> +
>> +    if unsignedBuild =3D=3D True:
>> +       print "Doing an unsigned build as requested"
>>=20=20=20=20=20
>
> I guess the pythonic way would be simply:
>
> if signedBuild:
>   try import..
> else:
>   print as requested..
>
>
>=20=20=20
>> -    sign(config, 'all')
>> +
>> +    if unsignedBuild =3D=3D False:
>> +       sign(config, 'all')
>> +
>>=20=20=20=20=20
>
> signedBuild would be nicer, then simply:
>
> if signedBuild:
>   sign()
>
>
> //Peter
>=20=20=20

All fixes applied in this patch.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------020506000303070205090007
Content-Type: text/x-patch;
	name="0001-Added-command-line-option-parser-and-an-unsigned-bui.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
	filename*0="0001-Added-command-line-option-parser-and-an-unsigned-bui.pa";
	filename*1="tch"

RnJvbSA4MDRhYTIxYTEyZjc0ZGU0MTQyMzA1ZWQ0MTViMzNhNDNlNWZjMjc2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiA9P3V0Zi04P3E/U2FtdWxpPTIwU2VwcD1DMz1BNG5l
bj89IDxzYW11bGlAb3BlbnZwbi5uZXQ+CkRhdGU6IFRodSwgMTggTm92IDIwMTAgMTg6MDA6
NTQgKzAyMDAKU3ViamVjdDogW1BBVENIXSBBZGRlZCBjb21tYW5kLWxpbmUgb3B0aW9uIHBh
cnNlciBhbmQgYW4gdW5zaWduZWQgYnVpbGQgb3B0aW9uIHRvIGJ1aWxkX2FsbC5weQoKTW9k
aWZpZWQgd2luL2J1aWxkX2FsbC5weSBzbyB0aGF0IGl0IHBhcnNlcyBjb21tYW5kLWxpbmUg
b3B0aW9ucyB1c2luZyBnZXRvcHQuCkFkZGVkIG9wdGlvbiAiLXUgLyAtLXVuc2lnbmVkIiB3
aGljaCBhbGxvd3MgZm9yY2luZyB1bnNpZ25lZCBidWlsZHMgYW5kIGEgIi1oIC8KLS1oZWxw
IiBvcHRpb24uIEJ5IGRlZmF1bHQgYSBzaWduZWQgYnVpbGQgaXMgZ2VuZXJhdGVkLCBwcm92
aWRlZCB0aGF0IHRoZSBQeXRob24KU2lnblRvb2wgbW9kdWxlIGlzIGluc3RhbGxlZC4gSWYg
bm90LCB0aGUgYnVpbGQgaXMgaW50ZXJydXB0ZWQuCi0tLQogd2luL2J1aWxkX2FsbC5weSB8
ICAgNDUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tCiAx
IGZpbGVzIGNoYW5nZWQsIDQzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvd2luL2J1aWxkX2FsbC5weSBiL3dpbi9idWlsZF9hbGwucHkKaW5kZXggOTJk
MmJmNC4uNTYzN2I1NSAxMDA2NDQKLS0tIGEvd2luL2J1aWxkX2FsbC5weQorKysgYi93aW4v
YnVpbGRfYWxsLnB5CkBAIC0xLDE1ICsxLDU2IEBACitpbXBvcnQgZ2V0b3B0LCBzeXMNCiBm
cm9tIGNvbmZpZ19hbGwgaW1wb3J0IG1haW4gYXMgY29uZmlnX2FsbA0KIGZyb20gYnVpbGQg
aW1wb3J0IG1haW4gYXMgYnVpbGRfb3BlbnZwbg0KIGZyb20gYnVpbGRfZGRrIGltcG9ydCBt
YWluIGFzIGJ1aWxkX2Rkaw0KLWZyb20gc2lnbiBpbXBvcnQgbWFpbiBhcyBzaWduDQogZnJv
bSBtYWtlX2Rpc3QgaW1wb3J0IG1haW4gYXMgbWFrZV9kaXN0DQogDQorZGVmIFVzYWdlKCk6
DQorICAgICcnJ1Nob3cgdXNhZ2UgaW5mb3JtYXRpb24nJycNCisgICAgcHJpbnQgIlVzYWdl
OiBidWlsZF9hbGwucHkgW09QVElPTlNdLi4uIg0KKyAgICBwcmludCAiQnVpbGQgT3BlblZQ
TiB1c2luZyBWaXN1YWwgU3R1ZGlvIHRvb2xzIg0KKyAgICBwcmludA0KKyAgICBwcmludCAi
IC1oLCAtLWhlbHAJCVNob3cgdGhpcyBoZWxwIg0KKyAgICBwcmludCAiIC11LCAtLXVuc2ln
bmVkCURvIG5vdCBzaWduIHRoZSBUQVAgZHJpdmVycyINCisgICAgc3lzLmV4aXQoMSkNCisN
CiBkZWYgbWFpbihjb25maWcpOg0KKw0KKyAgICAjIERvIGEgc2lnbmVkIGJ1aWxkIGJ5IGRl
ZmF1bHQNCisgICAgc2lnbmVkQnVpbGQ9VHJ1ZQ0KKw0KKyAgICAjIFBhcnNlIHRoZSBjb21t
YW5kIGxpbmUgYXJndW1lbnQocykNCisgICAgdHJ5Og0KKyAgICAgICBvcHRzLCBhcmdzID0g
Z2V0b3B0LmdldG9wdChzeXMuYXJndlsxOl0sICJodSIsIFsiaGVscCIsICJ1bnNpZ25lZCJd
KQ0KKyAgICBleGNlcHQgZ2V0b3B0LkdldG9wdEVycm9yOg0KKyAgICAgICBVc2FnZSgpDQor
DQorICAgIGZvciBvLCBhIGluIG9wdHM6DQorICAgICAgIGlmIG8gaW4gKCItaCIsIi0taGVs
cCIpOg0KKyAgICAgICAgICBVc2FnZSgpDQorICAgICAgIGlmIG8gaW4gKCItdSIsICItLXVu
c2lnbmVkIik6DQorICAgICAgICAgIHNpZ25lZEJ1aWxkPUZhbHNlDQorDQorDQorICAgICMg
Q2hlY2sgaWYgdGhlIFNpZ25Ub29sIG1vZHVsZSBpcyBwcmVzZW50LiBUaGlzIGF2b2lkcyBJ
bXBvcnRFcnJvcnMgcG9wcGluZyANCisgICAgIyB1cCBhbm5veWluZ2x5IF9hZnRlcl8gdGhl
IGJ1aWxkLg0KKyAgICBpZiBzaWduZWRCdWlsZDoNCisgICAgICAgdHJ5Og0KKyAgICAgICAg
ICBmcm9tIHNpZ250b29sIGltcG9ydCBTaWduVG9vbA0KKyAgICAgICBleGNlcHQgKEltcG9y
dEVycm9yKToNCisgICAgICAgICAgcHJpbnQgIkVSUk9SOiBTaWduVG9vbCBweXRob24gbW9k
dWxlIG5vdCBmb3VuZCEgQ2FuJ3QgZG8gYSBzaWduZWQgYnVpbGQuIg0KKyAgICAgICAgICBz
eXMuZXhpdCgxKQ0KKyAgICBlbHNlOg0KKyAgICAgICBwcmludCAiRG9pbmcgYW4gdW5zaWdu
ZWQgYnVpbGQgYXMgcmVxdWVzdGVkIg0KKw0KKyAgICAjIFN0YXJ0IHRoZSBidWlsZA0KICAg
ICBjb25maWdfYWxsKGNvbmZpZykNCiAgICAgYnVpbGRfb3BlbnZwbigpDQogICAgIGJ1aWxk
X2Rkayhjb25maWcsICd0YXAnLCAnYWxsJykNCiAgICAgYnVpbGRfZGRrKGNvbmZpZywgJ3Rh
cGluc3RhbGwnLCAnYWxsJykNCi0gICAgc2lnbihjb25maWcsICdhbGwnKQ0KKw0KKyAgICBp
ZiBzaWduZWRCdWlsZDoNCisgICAgICAgc2lnbihjb25maWcsICdhbGwnKQ0KKw0KICAgICBt
YWtlX2Rpc3QoY29uZmlnKQ0KIA0KICMgaWYgd2UgYXJlIHJ1biBkaXJlY3RseSwgYW5kIG5v
dCBsb2FkZWQgYXMgYSBtb2R1bGUNCi0tIAoxLjYuMy4zCgo=
--------------020506000303070205090007--

