Date: Sun, 20 Jan 2019 14:04:53 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20190120130453.GX962@...1296...>
References: <20181010192337.6984-1-simon@...2293...>
 <20181016102627.18676-1-simon@...2293...>
 <20181016102627.18676-5-simon@...2293...>
 <20190117161819.GG962@...1296...>
 <99D61A626FDA8A4B90A270669121BE109BF53B73@...2294...>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=sha-256; boundary="blyN2HtnWI+DXgcG"
Content-Disposition: inline
In-Reply-To: <99D61A626FDA8A4B90A270669121BE109BF53B73@...2294...>
Subject: Re: [Openvpn-devel] [PATCH 5/5] Detect TAP interfaces with
 root-enumerated hardware ID
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--blyN2HtnWI+DXgcG
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jan 19, 2019 at 05:38:27PM +0000, Simon Rozman wrote:
> > > The openvpnmsica.dll and tapctl.exe install TAP interfaces using root-
> > > enumerated HWIDs, and were not detected by openvpn.exe.
> >=20
> > I do not see a specific reason to *not* apply this patch, but I'm
> > wondering if you could shed some background light on the changed
> > behaviour in openvpnmsica.dll and tapctl.exe?
>=20
> The tapctl.exe and openvpnmsica.dll use a simplified interface installati=
on
> compared to devcon.exe/tapinstall.exe. They assume the driver is already
> installed and they don't require INF file to create a TAP interface.
> However, when the interface is installed this way, Windows reports its
> hardware ID as "root\\tap0901". Whereas, tapinstall.exe installed TAP
> interfaces report their HWID as "tap0901". That's about the only differen=
ce
> I noticed.

O-kay... :-) - I do not know enough about driver *installation* on Windows
to know whether this is all good or there might be dragons lurking.  We'll
have to test quite a bit, it seems :-)

> (Tested with driver versions 9.21.x and later.)
>=20
> Rather than exploring, what causes the difference and fuelled by Microsof=
t's
> recommendation to use root-enumerated HWIDs anyway, I proposed to extend =
the
> openvpn.exe's TAP interface detection to accept both: "tap0901" _and_
> "root\\tap0901" interfaces.

Works for me.  Which is why I ...

> Or even better: apply this patch to 2.4 and 2.3 branches (it's a really
> minor change) and ask them to compile and use the patched version of 2.3.=
 :)

... applied it to 2.4 as well.=20=20

If someone struggles with 2.3 on windows (beyond XP), my empathy for them
will be close to zero.  2.4 is so much better, especially on windows, that
there is no reason to stick to 2.3... (on Linux distributions, sticking
to the "distro provided package" might give people 2.3.x for years to=20
come :-( - but this is no argument on Windows).

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--blyN2HtnWI+DXgcG
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
9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDEyMDEzMDQ1M1owLwYJKoZIhvcNAQkEMSIEIFs/
kDMPwQc2z7+Q+AoNWjrEInOxvbifKdA6Qt/miljnMHkGCSqGSIb3DQEJDzFsMGowCwYJYIZI
AWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcN
AwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMA0GCSqGSIb3
DQEBAQUABIIBAG/DoXURP+ky94GQUZjAd475aKi2Mb/8hlPSHcOnpfcVTuX1OcuILbjSgEZY
fH0q2MpFhZ3NlBKAD7Z6iWH78a95oAnxu2yVKCBIVnj05JID4oOjHJMRK3GDv3Xgyx12iL+N
CCy5FmANZ27O/viNUwFF3xLWQCKBonepTdBuI/m0X1JtdRv+rivxE9jFN/3a2lK4/PAxbMh2
Ugh159ncJ3jVrndgyjwldg0TlDyFxNcQ+zjmYw8uu9LAw+EJjF9HnCAU/3+7ymWbR2bAhK8v
M3z8ivJBxplyeCqUiWcU8I7uzGKidmy/KhC8X4lZ47ELR+rYZwEg4r0PyE5LMe1vcn0=

--blyN2HtnWI+DXgcG--

