MIME-Version: 1.0
References: <f80646d4-0fc3-4e5a-bc05-22b929452d00@...1800...>
 <CAKuzo_hqwfqgSb57fwCEx6C+HBVawt-ECZuNkacVBb4y-CYwcw@...278...>
 <850037b2-36d0-4240-8c73-04dab1a90777@...1800...>
In-Reply-To: <850037b2-36d0-4240-8c73-04dab1a90777@...1800...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 28 Sep 2023 21:55:07 -0400
Message-ID: <CAKuzo_j3BEfQGOSi9rYDMamFg5G+_7CninqNwQ9-J4jk52NPLA@...278...>
Content-Type: multipart/alternative; boundary="000000000000b6caee060675b729"
Subject: Re: [Openvpn-devel] pkcs11 config changes from 2.5.4 to 2.6.6 ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mike tancsa <mike@...1800...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000b6caee060675b729
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mike

I misunderstood Arne's comment. We default to security level 1 but that
forbids SHA1 signatures in OpenSSL 3.0+.

Could you test with "tls-cert-profile Insecure" in the config file? It's
not recommended but useful to check.

Thanks,

Selva

On Thu, Sep 28, 2023 at 7:08=E2=80=AFPM mike tancsa <mike@...1800...> wrote:

> Hi Selva,
>
>     Thank you for looking!
>
> My guess is that something in the certificate or private key is not to
> OpenSSL 3.1's liking and it rejects it. Is there any way for you to check
> the
> contents of the token independently using a tool linked against OpenSSL
> 3.1 ?
>
> What am I looking for in that case ?  Taking a look at the cert just with
> openssl 3.0 on FreeBSD releng14 it seems ok with it. Same with the Windows
> version 3.1.x that comes with OpenVPN. Is it possible it doesnt like the
> sha1RSA sig ?
>
> # openssl version
> OpenSSL 3.0.10 1 Aug 2023 (Library: OpenSSL 3.0.10 1 Aug 2023)
> #
>
> Certificate:
>     Data:
>         Version: 3 (0x2)
>         Serial Number: 7109 (0x1bc5)
>         Signature Algorithm: sha1WithRSAEncryption
>         Issuer: C =3D CA, ST =3D ON, L =3D Cambridge, O =3D Sentex CA, CN=
 =3D Sentex
> private1test CA CA, emailAddress =3D mike@...2750...
>         Validity
>             Not Before: Sep 27 19:43:01 2023 GMT
>             Not After : Nov 13 19:43:01 2033 GMT
>         Subject: C =3D CA, ST =3D ON, L =3D Cambridge, O =3D Sentex CA, O=
U =3D
> win10, CN =3D test123456mdt, emailAddress =3D mike@...2750...
>         Subject Public Key Info:
>             Public Key Algorithm: rsaEncryption
>                 Public-Key: (2048 bit)
>                 Modulus:
>                     00:f5:e0:27:b5:28:0a:f8:a9:ce:13:33:a2:ca:27:
>
> ...
>
>                     ac:a8:b6:55:bb:a3:a4:43:e5:74:05:aa:c8:69:3d:
>                     ed:ef
>                 Exponent: 65537 (0x10001)
>         X509v3 extensions:
>             X509v3 Basic Constraints:
>                 CA:FALSE
>             Netscape Comment:
>                 Easy-RSA Generated Certificate
>             X509v3 Subject Key Identifier:
>                 74:72:3A:87:0D:34:7B:1E:11:C6:18:D2:41:99:C6:5E:D1:8A:81:=
95
>             X509v3 Authority Key Identifier:
>
> keyid:4F:A0:B0:94:92:6F:24:A7:D4:C6:93:A6:AA:25:63:6C:ED:1E:E3:8C
>                 DirName:/C=3DCA/ST=3DON/L=3DCambridge/O=3DSentex Parklands
> CA/CN=3DSentex Parklands CA CA/emailAddress=3Dppsupport@...2750...
>                 serial:F5:3E:37:76:69:AC:EF:EC
>             X509v3 Extended Key Usage:
>                 TLS Web Client Authentication
>             X509v3 Key Usage:
>                 Digital Signature
>     Signature Algorithm: sha1WithRSAEncryption
>     Signature Value:
>         10:72:36:db:5c:f3:f5:fb:52:82:c7:4c:72:8f:31:ae:
>

--000000000000b6caee060675b729
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SGkgTWlrZTxkaXY+PGJyPjwvZGl2PjxkaXY+SSBtaXN1bmRlcnN0b29k
IEFybmUmIzM5O3MgY29tbWVudC4gV2UgZGVmYXVsdCB0byBzZWN1cml0eSBsZXZlbCAxIGJ1dCB0
aGF0IGZvcmJpZHMgU0hBMSBzaWduYXR1cmVzIGluIE9wZW5TU0wgMy4wKy48L2Rpdj48ZGl2Pjxi
cj48ZGl2PkNvdWxkIHlvdSB0ZXN0IHdpdGggJnF1b3Q7dGxzLWNlcnQtcHJvZmlsZSBJbnNlY3Vy
ZSZxdW90OyBpbiB0aGUgY29uZmlnIGZpbGU/IEl0JiMzOTtzIG5vdCByZWNvbW1lbmRlZCBidXQg
dXNlZnVsIHRvIGNoZWNrLjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhhbmtzLDwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+U2VsdmE8L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48YnI+PGRpdiBjbGFzcz0i
Z21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5PbiBUaHUsIFNl
cCAyOCwgMjAyMyBhdCA3OjA44oCvUE0gbWlrZSB0YW5jc2EgJmx0OzxhIGhyZWY9Im1haWx0bzpt
aWtlQC4uLjE4MDAuLi4iPm1pa2VALi4uMTgwMC4uLjwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48
YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHgg
MC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0
OjFleCI+PHU+PC91Pg0KDQogIA0KICAgIA0KICANCiAgPGRpdj4NCiAgICA8cD5IaSBTZWx2YSw8
L3A+DQogICAgPHA+wqDCoMKgIFRoYW5rIHlvdSBmb3IgbG9va2luZyE8YnI+DQogICAgPC9wPg0K
ICAgIDxicj4NCiAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4NCiAgICAgIDxkaXYgZGlyPSJs
dHIiPg0KICAgICAgICA8ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+DQogICAgICAgICAgPGRpdj5N
eSBndWVzcyBpcyB0aGF0IHNvbWV0aGluZyBpbiB0aGUgY2VydGlmaWNhdGUgb3IgcHJpdmF0ZQ0K
ICAgICAgICAgICAga2V5IGlzIG5vdCB0bzwvZGl2Pg0KICAgICAgICAgIDxkaXY+T3BlblNTTCAz
LjEmIzM5O3MgbGlraW5nIGFuZCBpdCByZWplY3RzIGl0LiBJcyB0aGVyZSBhbnkgd2F5DQogICAg
ICAgICAgICBmb3IgeW91IHRvIGNoZWNrIHRoZTwvZGl2Pg0KICAgICAgICAgIDxkaXY+Y29udGVu
dHMgb2YgdGhlIHRva2VuIGluZGVwZW5kZW50bHkgdXNpbmcgYSB0b29sIGxpbmtlZA0KICAgICAg
ICAgICAgYWdhaW5zdCBPcGVuU1NMIDMuMSA/PC9kaXY+DQogICAgICAgICAgPGRpdj48YnI+DQog
ICAgICAgICAgPC9kaXY+DQogICAgICAgIDwvZGl2Pg0KICAgICAgPC9kaXY+DQogICAgPC9ibG9j
a3F1b3RlPg0KICAgIDxwPldoYXQgYW0gSSBsb29raW5nIGZvciBpbiB0aGF0IGNhc2UgP8KgIFRh
a2luZyBhIGxvb2sgYXQgdGhlIGNlcnQNCiAgICAgIGp1c3Qgd2l0aCBvcGVuc3NsIDMuMCBvbiBG
cmVlQlNEIHJlbGVuZzE0IGl0IHNlZW1zIG9rIHdpdGggaXQuDQogICAgICBTYW1lIHdpdGggdGhl
IFdpbmRvd3MgdmVyc2lvbiAzLjEueCB0aGF0IGNvbWVzIHdpdGggT3BlblZQTi4gSXMgaXQNCiAg
ICAgIHBvc3NpYmxlIGl0IGRvZXNudCBsaWtlIHRoZSBzaGExUlNBIHNpZyA/PGJyPg0KICAgIDwv
cD4NCiAgICA8cD4jIG9wZW5zc2wgdmVyc2lvbjxicj4NCiAgICAgIE9wZW5TU0wgMy4wLjEwIDEg
QXVnIDIwMjMgKExpYnJhcnk6IE9wZW5TU0wgMy4wLjEwIDEgQXVnIDIwMjMpPGJyPg0KICAgICAg
IyA8YnI+DQogICAgPC9wPg0KICAgIDxwPkNlcnRpZmljYXRlOjxicj4NCiAgICAgIMKgwqDCoCBE
YXRhOjxicj4NCiAgICAgIMKgwqDCoMKgwqDCoMKgIFZlcnNpb246IDMgKDB4Mik8YnI+DQogICAg
ICDCoMKgwqDCoMKgwqDCoCBTZXJpYWwgTnVtYmVyOiA3MTA5ICgweDFiYzUpPGJyPg0KICAgICAg
wqDCoMKgwqDCoMKgwqAgU2lnbmF0dXJlIEFsZ29yaXRobTogc2hhMVdpdGhSU0FFbmNyeXB0aW9u
PGJyPg0KICAgICAgwqDCoMKgwqDCoMKgwqAgSXNzdWVyOiBDID0gQ0EsIFNUID0gT04sIEwgPSBD
YW1icmlkZ2UsIE8gPSBTZW50ZXggQ0EsIENODQogICAgICA9IFNlbnRleCBwcml2YXRlMXRlc3Qg
Q0EgQ0EsIGVtYWlsQWRkcmVzcyA9IDxhIGhyZWY9Im1haWx0bzptaWtlQC4uLjI3NTAuLi4iIHRh
cmdldD0iX2JsYW5rIj5taWtlQC4uLjI3NTAuLi48L2E+PGJyPg0KICAgICAgwqDCoMKgwqDCoMKg
wqAgVmFsaWRpdHk8YnI+DQogICAgICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE5vdCBCZWZvcmU6
IFNlcCAyNyAxOTo0MzowMSAyMDIzIEdNVDxicj4NCiAgICAgIMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgTm90IEFmdGVyIDogTm92IDEzIDE5OjQzOjAxIDIwMzMgR01UPGJyPg0KICAgICAgwqDCoMKg
wqDCoMKgwqAgU3ViamVjdDogQyA9IENBLCBTVCA9IE9OLCBMID0gQ2FtYnJpZGdlLCBPID0gU2Vu
dGV4IENBLCBPVQ0KICAgICAgPSB3aW4xMCwgQ04gPSB0ZXN0MTIzNDU2bWR0LCBlbWFpbEFkZHJl
c3MgPSA8YSBocmVmPSJtYWlsdG86bWlrZUAuLi4yNzUwLi4uIiB0YXJnZXQ9Il9ibGFuayI+bWlr
ZUAuLi4yNzUwLi4uPC9hPjxicj4NCiAgICAgIMKgwqDCoMKgwqDCoMKgIFN1YmplY3QgUHVibGlj
IEtleSBJbmZvOjxicj4NCiAgICAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUHVibGljIEtleSBB
bGdvcml0aG06IHJzYUVuY3J5cHRpb248YnI+DQogICAgICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgUHVibGljLUtleTogKDIwNDggYml0KTxicj4NCiAgICAgIMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBNb2R1bHVzOjxicj4NCiAgICAgIMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIDAwOmY1OmUwOjI3OmI1OjI4OjBhOmY4OmE5OmNlOjEzOjMzOmEy
OmNhOjI3OjwvcD4NCiAgICA8cD4uLi48L3A+DQogICAgPHA+wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgYWM6YTg6YjY6NTU6YmI6YTM6YTQ6NDM6ZTU6NzQ6MDU6YWE6Yzg6
Njk6M2Q6PGJyPg0KICAgICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ZWQ6ZWY8YnI+DQogICAgICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRXhwb25lbnQ6
IDY1NTM3ICgweDEwMDAxKTxicj4NCiAgICAgIMKgwqDCoMKgwqDCoMKgIFg1MDl2MyBleHRlbnNp
b25zOjxicj4NCiAgICAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgWDUwOXYzIEJhc2ljIENvbnN0
cmFpbnRzOiA8YnI+DQogICAgICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQ0E6RkFM
U0U8YnI+DQogICAgICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE5ldHNjYXBlIENvbW1lbnQ6IDxi
cj4NCiAgICAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBFYXN5LVJTQSBHZW5lcmF0
ZWQgQ2VydGlmaWNhdGU8YnI+DQogICAgICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFg1MDl2MyBT
dWJqZWN0IEtleSBJZGVudGlmaWVyOiA8YnI+DQogICAgICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqANCiAgICAgIDc0OjcyOjNBOjg3OjBEOjM0OjdCOjFFOjExOkM2OjE4OkQyOjQxOjk5
OkM2OjVFOkQxOjhBOjgxOjk1PGJyPg0KICAgICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBYNTA5
djMgQXV0aG9yaXR5IEtleSBJZGVudGlmaWVyOiA8YnI+DQogICAgICDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqANCiAgICAgIGtleWlkOjRGOkEwOkIwOjk0OjkyOjZGOjI0OkE3OkQ0OkM2
OjkzOkE2OkFBOjI1OjYzOjZDOkVEOjFFOkUzOjhDPGJyPg0KICAgICAgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIERpck5hbWU6L0M9Q0EvU1Q9T04vTD1DYW1icmlkZ2UvTz1TZW50ZXgg
UGFya2xhbmRzDQogICAgICBDQS9DTj1TZW50ZXggUGFya2xhbmRzIENBIDxhIGhyZWY9Im1haWx0
bzpDQS9lbWFpbEFkZHJlc3M9cHBzdXBwb3J0QC4uLjI3NTAuLi4iIHRhcmdldD0iX2JsYW5rIj5D
QS9lbWFpbEFkZHJlc3M9cHBzdXBwb3J0QC4uLjI3NTAuLi48L2E+PGJyPg0KICAgICAgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNlcmlhbDpGNTozRTozNzo3Njo2OTpBQzpFRjpFQzxi
cj4NCiAgICAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgWDUwOXYzIEV4dGVuZGVkIEtleSBVc2Fn
ZTogPGJyPg0KICAgICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRMUyBXZWIgQ2xp
ZW50IEF1dGhlbnRpY2F0aW9uPGJyPg0KICAgICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBYNTA5
djMgS2V5IFVzYWdlOiA8YnI+DQogICAgICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
RGlnaXRhbCBTaWduYXR1cmU8YnI+DQogICAgICDCoMKgwqAgU2lnbmF0dXJlIEFsZ29yaXRobTog
c2hhMVdpdGhSU0FFbmNyeXB0aW9uPGJyPg0KICAgICAgwqDCoMKgIFNpZ25hdHVyZSBWYWx1ZTo8
YnI+DQogICAgICDCoMKgwqDCoMKgwqDCoCAxMDo3MjozNjpkYjo1YzpmMzpmNTpmYjo1Mjo4Mjpj
Nzo0Yzo3Mjo4ZjozMTphZTo8YnI+DQogICAgPC9wPg0KICA8L2Rpdj4NCg0KPC9ibG9ja3F1b3Rl
PjwvZGl2Pg0K

--000000000000b6caee060675b729--

