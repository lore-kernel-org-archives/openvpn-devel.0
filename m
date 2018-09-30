Date: Sun, 30 Sep 2018 14:30:22 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180930123022.GR962@...1296...>
References: <1538141209-32330-1-git-send-email-lstipakov@...277...>
 <99D61A626FDA8A4B90A270669121BE10991F46BA@...2294...>
 <CAGyAFMXddqfZAHu-_aaue49zu_TCaFz4yMBpo6kV9XbZBPqgoQ@...278...>
 <99D61A626FDA8A4B90A270669121BE10991F4C23@...2294...>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=sha-256; boundary="8Nc+Tfv1AudcG31Y"
Content-Disposition: inline
In-Reply-To: <99D61A626FDA8A4B90A270669121BE10991F4C23@...2294...>
Subject: Re: [Openvpn-devel] [PATCH] win: support for Visual Studio 2017
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: Lev Stipakov <lstipakov@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--8Nc+Tfv1AudcG31Y
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Sep 30, 2018 at 05:32:55AM +0000, Simon Rozman wrote:
> Now, that's more like it. Thanks for the directions. Will try it again an=
d=20
> report.
>=20
> Yes, TAP driver can be build for ARM64. See:
>=20
> https://github.com/OpenVPN/tap-windows6/pull/57
>=20
> https://github.com/OpenVPN/tap-windows6/pull/56
>=20
> https://github.com/OpenVPN/tap-windows6/pull/55

When we finally manage to solve the signing part, the resulting TAP
installer will have i386, amd64 and arm64 binaries.

gert


--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--8Nc+Tfv1AudcG31Y
Content-Type: application/x-pkcs7-signature
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIIOGgYJKoZIhvcNAQcCoIIOCzCCDgcCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0B
BwGgggsfMIIF5jCCA86gAwIBAgIQapvhODv/K2ufAdXZuKdSVjANBgkqhkiG9w0BAQwFADCB
hTELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMH
U2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxKzApBgNVBAMTIkNPTU9ETyBS
U0EgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkwHhcNMTMwMTEwMDAwMDAwWhcNMjgwMTA5MjM1
OTU5WjCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4G
A1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENP
TU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwggEi
MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC+s55XrCh2dUAWxzgDmNPGGHYhUPMleQtM
taDRfTpYPpynMS6n9jR22YRq2tA9NEjk6vW7rN/5sYFLIP1of3l0NKZ6fLWfF2VgJ5cijKYy
/qlAckY1wgOkUMgzKlWlVJGyK+UlNEQ1/5ErCsHq9x9aU/x1KwTdF/LCrT03Rl/FwFrf1XTC
wa2QZYL55AqLPikFlgqOtzk06kb2qvGlnHJvijjI03BOrNpo+kZGpcHsgyO1/u1OZTaOo8wv
EU17VVeP1cHWse9tGKTDyUGg2hJZjrqck39UIm/nKbpDSZ0JsMoIw/JtOOg0JC56VzQgBo7i
ctReTQE5LFLG3yQK+xS1AgMBAAGjggE8MIIBODAfBgNVHSMEGDAWgBS7r34CPfqm8TyEjq3u
OJjs2TIy1DAdBgNVHQ4EFgQUgq9sjPjF/pZhfOgfPStxSF7Ei8AwDgYDVR0PAQH/BAQDAgGG
MBIGA1UdEwEB/wQIMAYBAf8CAQAwEQYDVR0gBAowCDAGBgRVHSAAMEwGA1UdHwRFMEMwQaA/
oD2GO2h0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNlcnRpZmljYXRpb25BdXRo
b3JpdHkuY3JsMHEGCCsGAQUFBwEBBGUwYzA7BggrBgEFBQcwAoYvaHR0cDovL2NydC5jb21v
ZG9jYS5jb20vQ09NT0RPUlNBQWRkVHJ1c3RDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9v
Y3NwLmNvbW9kb2NhLmNvbTANBgkqhkiG9w0BAQwFAAOCAgEAeFyygSg0TzzuX1bOn5dW7I+i
axf28/ZJCAbU2C81zd9A/tNx4+jsQgwRGiHjZrAYayZrrm78hOx7aEpkfNPQIHGG6Fvq3EzW
f/Lvx7/hk6zSPwIal9v5IkDcZoFD7f3iT7PdkHJY9B51csvU50rxpEg1OyOT8fk2zvvPBuM4
qQNqbGWlnhMpIMwpWZT89RY0wpJO+2V6eXEGGHsROs3njeP9DqqqAJaBa4wBeKOdGCWn1/Jp
2oY6dyNmNppI4ZNMUH4Tam85S1j6E95u4+1Nuru84OrMIzqvISE2HN/56ebTOWlcrurffade
2022O/tUU1gb4jfWCcyvB8czm12FgX/y/lRjmDbEA08QJNB2729Y+io1IYO3ztveBdvUCIYZ
ojTq/OCR6MvnzS6X72HP0PRLRTiOSEmIDsS5N5w/8IW1Hva5hEFy6fDAfd9yI+O+IMMAj1Kc
L/Zo9jzJ16HO5m60ttl1Enk8MQkz/W3JlHaeI5iKFn4UJu1/cP2YHXYPiWf2JyBzsLBrGk1I
I+3yL8aorYew6CQvdVifC3HtwlSam9V1niiCfOBe2C12TdKGu05LWIA3ZkFcWJGaNXOZ6Ggy
h/TqvXG5v7zmEVDNXFnHn9tFpMpOUvxhcsjycBtH0dZ0WrNw6gH+HF8TIhCnH3+zzWuDN0Rk
6h9KVkfKehIwggUxMIIEGaADAgECAhBoKGrilYL+DkBaaHjtexKaMA0GCSqGSIb3DQEBCwUA
MIGXMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQH
EwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RP
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTAeFw0xODA4
MDYwMDAwMDBaFw0xOTA4MDYyMzU5NTlaMCQxIjAgBgkqhkiG9w0BCQEWE2dlcnRAZ3JlZW5p
ZS5tdWMuZGUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC/rjWbYvcc/uWCRkcT
MKbIJr4+mp2vJ7hS5iesOTfDb/BslZgSV9eK7k2QAVETO4w//HxmOzEWVSvoHHxE7blHw+QA
cECqc+O23z6BSHWi2WUe71IfljudN/aViJ1NAYvJy7Wa+3jinfy5fl8yl74o5L0L0Y8TJPOy
DZkCtzuGx6iG6ge0NC0wc+gzA0oXDmfPktmcE/YQhI+U+hoZHrKy/QyYXRHfi80wtdVJe6Zb
b226rg1Q2qLSgJ+OAQPhvzIo7qMYM3dzHJeZSoAW12t7TvKg8WlmgiVXdTk1Cs/WcCA7GS4l
V9NRAlznqgNHIQJHJe0jCqMxzOp9T7DgtZuxAgMBAAGjggHpMIIB5TAfBgNVHSMEGDAWgBSC
r2yM+MX+lmF86B89K3FIXsSLwDAdBgNVHQ4EFgQU1XAEqUTyLyKp+6Tm4jnm5ioJ+dUwDgYD
VR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwIAYDVR0lBBkwFwYIKwYBBQUHAwQGCysGAQQB
sjEBAwUCMBEGCWCGSAGG+EIBAQQEAwIFIDBGBgNVHSAEPzA9MDsGDCsGAQQBsjEBAgEBATAr
MCkGCCsGAQUFBwIBFh1odHRwczovL3NlY3VyZS5jb21vZG8ubmV0L0NQUzBaBgNVHR8EUzBR
ME+gTaBLhklodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50
aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3JsMIGLBggrBgEFBQcBAQR/MH0wVQYIKwYBBQUH
MAKGSWh0dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNsaWVudEF1dGhlbnRpY2F0
aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9k
b2NhLmNvbTAeBgNVHREEFzAVgRNnZXJ0QGdyZWVuaWUubXVjLmRlMA0GCSqGSIb3DQEBCwUA
A4IBAQA/8e5BhoX7/1uR8xJIU9Bgr1kRHHYS0pwDwBb2qmVqwCVDj2wuV6YdN20xl3p23Fad
3e/Hf1riXhma9wnQKon/qhDjgVEKUcbXINtYTeuaF8v6zgEyo0VQqiEMQDwCTrxfZqZejjiB
0CO+TOtdTknb4EMYREHw+D8GZLa9/+6JyagLJLNUsganHfAl6d50iQMifqzyXSN0BFLXcdnp
0+99Ulo6k1aiAy8+83tK6Ludd5DY94bFCIdFub6z6nuqQIeWML5LPatzakdMFZLy1L9a9ePq
QEyhed3KH2jk23+2elJPGr/vs5ASGNtgBTbgM7n9aQR9xPAt0kLNwLI5byujMYICvzCCArsC
AQEwgawwgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAO
BgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRD
T01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhBo
KGrilYL+DkBaaHjtexKaMA0GCWCGSAFlAwQCAQUAoIHkMBgGCSqGSIb3DQEJAzELBgkqhkiG
9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDkzMDEyMzAyMlowLwYJKoZIhvcNAQkEMSIEIAjH
818sz7XByxh1wzOs7WhxI+uRjRBf+8xexuO6tUzaMHkGCSqGSIb3DQEJDzFsMGowCwYJYIZI
AWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcN
AwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMA0GCSqGSIb3
DQEBAQUABIIBAGNAxNcfVjIXOBsu+/rskNnGgWxDX2AK2b3+Ysn4viNMvekB65fLkMYbslBE
v45+kWvlQFXQXS2eTUbXBYkWYPfn3atAVMpQxW/6RwhqhmdIswyV4b5eu9qJE3JimxGQAobf
36nw4nVBW9gjY7NqcfclD0x2dm7YfaPK19Klg4YQD9t9ibSnZYMSX07ydmK8c3A7Nw+eWf4h
YOOOXFFEbcZgU3Mt2WOXFA/0G2z7P+bFnXJOQVcPHCPDVw5/ht94SM9xHE9HdHdQaYgxmVJM
FcQfm+MFzn53o97gq/FGrD7i8HF6Vjwnp0x3e6LEOhHNKBuHxTe7MYYNw+JZBiXnPws=

--8Nc+Tfv1AudcG31Y--

