References: <CAAEV3TywmcYYidTfa6oWaex-24rjeqh7iJZ28p1rQONS3Ev0ag@...278...>
 <20180606071031.GX57262@...1296...>
From: Rogier Spoor <Rogier.Spoor@...2406...>
Message-ID: <1c0c2d48-a68d-a7ab-5d5b-7975d11946b9@...2406...>
Date: Wed, 6 Jun 2018 22:14:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180606071031.GX57262@...1296...>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="------------ms050700090105010500020007"
Subject: Re: [Openvpn-devel] OpenVPN Custom Client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Rafael Herrera <rafael.herrera@...2405...>
Cc: openvpn-devel@lists.sourceforge.net

--------------ms050700090105010500020007
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi all,

> On Tue, Jun 05, 2018 at 05:54:05PM -0300, Rafael Herrera wrote:
>> We are developing a custom client for OpenVPN 2.4.x and it would be nice=
 to
>> have some support from experienced community developers.

It seems PIA has created an OpenVPN compatible client for iOS which
could save some time.
https://github.com/pia-foss/tunnel-apple

This was probably done because you can't release 'regular' OpenVPN 2.x
or 3.x in the Apple appstore due to a GPL license problem.

The PIA implementation looks pretty nice.
>> Is there anybody here available to help us with a consultancy regarding =
to
>> network protocols and its required state machines?
>=20
> David was working on an RFC to document the protocol - no idea if that
> has progressed to "readable first draft" status already, but it might
> be a good test for the document.
>=20
> Besides this, I wonder why you're not basing your work on the existing
> (2.x or 3.x) client, possibly with a new GUI wrapped on top - duplicating=
=20
> all the code and logic inside OpenVPN is a fairly big task, especially=20
> in the "this is not really very well defined, it just happens to be=20
> this way today" areas.

This would certainly be the most preferred way 2 go. Makes no sense to
have multiple implementations; this will fork the community. However for
iOS it seems 2.x and 3.x can't be used if you like to release your own
client in the appstore.

cheers,
Rogier
>=20
> Also, you'll have to end up following all developments that we do on
> the 2.x and 3.x clients - like, right now we're working on making the
> client work in an IPv6-only environment.  We test against 2.x and 3.x,
> but if we break "other implementations that we do not know about", it
> is not something we can avoid.
>=20
> gert
>=20
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>=20
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20



--------------ms050700090105010500020007
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
Ch4wggUAMIID6KADAgECAhADS+4XH7fhBjcv1HJCQL0qMA0GCSqGSIb3DQEBCwUAMGUxCzAJ
BgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2Vy
dC5jb20xJDAiBgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0xNDExMTgx
MjAwMDBaFw0yNDExMTgxMjAwMDBaMGkxCzAJBgNVBAYTAk5MMRYwFAYDVQQIEw1Ob29yZC1I
b2xsYW5kMRIwEAYDVQQHEwlBbXN0ZXJkYW0xDzANBgNVBAoTBlRFUkVOQTEdMBsGA1UEAxMU
VEVSRU5BIFBlcnNvbmFsIENBIDMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDG
pbsfVYL0pTRyFHJlm1/V6qBo2JuCiU9TYpx7jM4O2tQyDq8bjMum69vg6wM0lMGHflMgqB75
GxeKfQFmEldoXi2cLishqFUvU2cJeM3SaRsLk2BsuCgTzh9NsYgmrUX60KHOq7eYKVZxbPFW
JF2nMOBuMXNu2qBXTGSLeLXHnNvG3r7TLzGg1oA5teAxQE6Eo8ySSeIXbP7wZB76urwlh51P
IbrJZjkDjdQVELh7OlTP1WO6T/Hf6BsEfeFcpoa1e+MW/lw0VetTPPHQ15HYKYP2WYohHxzD
iC+QUwE7UZVBlp9cXIpwHuDzSibc5RG3z0n/j2SQCx0Dk5FMAUErAgMBAAGjggGmMIIBojAS
BgNVHRMBAf8ECDAGAQH/AgEAMA4GA1UdDwEB/wQEAwIBhjB5BggrBgEFBQcBAQRtMGswJAYI
KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBDBggrBgEFBQcwAoY3aHR0cDov
L2NhY2VydHMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZElEUm9vdENBLmNydDCBgQYD
VR0fBHoweDA6oDigNoY0aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJl
ZElEUm9vdENBLmNybDA6oDigNoY0aHR0cDovL2NybDQuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0
QXNzdXJlZElEUm9vdENBLmNybDA9BgNVHSAENjA0MDIGBFUdIAAwKjAoBggrBgEFBQcCARYc
aHR0cHM6Ly93d3cuZGlnaWNlcnQuY29tL0NQUzAdBgNVHQ4EFgQU8CHpSXdzn4WuGDvoUnAU
Bu1C7sowHwYDVR0jBBgwFoAUReuir/SSy4IxLVGLp6chnfNtyA8wDQYJKoZIhvcNAQELBQAD
ggEBADrCGyv+Y967YbS5R6j8fAWxJiAiUZvIPfn1xVgesF6jspwCQY8xGn/MG04d+Jh97I8I
/Xfx29JEEFq2rQmw4PxiO9RiDZ7xoDxNd4rrRDR7jrtOKQP8J+o+ah0vSOP62hnD/zPS7NRM
tIyVS2G277KAL5fIR62ngr984fmJghDv0bsjGAmeu3EP0xhUsDJT61IoAGoKBnxBPAeg3WXs
dSm4Gn7btyvakeyFtYebr2KmOBSa28PRqGSDur56aZhJoM2eMzc6prmvGwwtAzRsc5t2OsKR
uHWV6O3anP2K27jGZR2bi1VX1NQUvIbpVNTuwjm+XcZtsa/AAJF9KGkEseAwggUWMIID/qAD
AgECAhAM/mXHU8QLY4bmhzIIxM34MA0GCSqGSIb3DQEBCwUAMGkxCzAJBgNVBAYTAk5MMRYw
FAYDVQQIEw1Ob29yZC1Ib2xsYW5kMRIwEAYDVQQHEwlBbXN0ZXJkYW0xDzANBgNVBAoTBlRF
UkVOQTEdMBsGA1UEAxMUVEVSRU5BIFBlcnNvbmFsIENBIDMwHhcNMTgwMTA5MDAwMDAwWhcN
MTkwMTA5MTIwMDAwWjBLMQswCQYDVQQGEwJOTDEQMA4GA1UEBxMHVXRyZWNodDETMBEGA1UE
ChMKU1VSRm5ldCBidjEVMBMGA1UEAxMMUm9naWVyIFNwb29yMIIBIjANBgkqhkiG9w0BAQEF
AAOCAQ8AMIIBCgKCAQEAsaOcuj8XNPvXc8pUNdrRzEU0UPtaInTEz3BygK20Bk/fyKdtmiM+
QSFn5gfx4OaLeLyJAetiK85a1dtJNDCZEiLm6NXv4tsbrt5etl4lJJQcW9GO8rWLbSSAAG+N
D8AbJL54cK5QkVoUXpQiR9mItZkc0qhHXacFBQLh39xDL9X2xCT/XuzkdILLrNOnNGYmt2Xm
6llyvfFa1s9Pa2+JMofUjfvLbdTB/zwfjLBNI1AurOrbyqCcrxYxgXsAm0kJllj/GlINxDJ2
4vCvUVlSu0RRdoVGaaHKXIIs1d47/bi0gwLsaXdUVQF8iFREaxL4exkEDsbCwduI6+2rzSiv
MQIDAQABo4IB1jCCAdIwHwYDVR0jBBgwFoAU8CHpSXdzn4WuGDvoUnAUBu1C7sowHQYDVR0O
BBYEFNCHe+rcm+LXqVCIN5LkmvisiTAQMAwGA1UdEwEB/wQCMAAwIgYDVR0RBBswGYEXcm9n
aWVyLnNwb29yQHN1cmZuZXQubmwwDgYDVR0PAQH/BAQDAgWgMB0GA1UdJQQWMBQGCCsGAQUF
BwMCBggrBgEFBQcDBDBDBgNVHSAEPDA6MDgGCmCGSAGG/WwEAQIwKjAoBggrBgEFBQcCARYc
aHR0cHM6Ly93d3cuZGlnaWNlcnQuY29tL0NQUzB1BgNVHR8EbjBsMDSgMqAwhi5odHRwOi8v
Y3JsMy5kaWdpY2VydC5jb20vVEVSRU5BUGVyc29uYWxDQTMuY3JsMDSgMqAwhi5odHRwOi8v
Y3JsNC5kaWdpY2VydC5jb20vVEVSRU5BUGVyc29uYWxDQTMuY3JsMHMGCCsGAQUFBwEBBGcw
ZTAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tMD0GCCsGAQUFBzAChjFo
dHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vVEVSRU5BUGVyc29uYWxDQTMuY3J0MA0GCSqG
SIb3DQEBCwUAA4IBAQAdtcKwN5djFIOS8iYHoTIPJ0ZZ7e4CUnBOXaxM7qpJ9BiVijwI8PiI
tLQWq7QeoJtpndeOTEjrThjJL3kp+rbeDZBE711kkDUzCut08GmyHQnDrqijWBYh8XY4OJln
O6ZNV21feaXXJhx+nETdeZhdfWWjuJqeP2MSFxSbOg7y6zDJiVbBkO8OP3G3/MOIltS+Rp7X
pWJuRokmXQiR2cGvItHVWCDvQkficxCI7OMdm31CTcmdDb7KXxsFQ0J3jT5A66QWZ3PRJITi
2cpF34yvfntDg/jTsPmFLGro1xwhmWbjnB5Isya8mMLGA3DFJY4HAqNRoLK5gTbhqw9QxGQG
MYIDozCCA58CAQEwfTBpMQswCQYDVQQGEwJOTDEWMBQGA1UECBMNTm9vcmQtSG9sbGFuZDES
MBAGA1UEBxMJQW1zdGVyZGFtMQ8wDQYDVQQKEwZURVJFTkExHTAbBgNVBAMTFFRFUkVOQSBQ
ZXJzb25hbCBDQSAzAhAM/mXHU8QLY4bmhzIIxM34MA0GCWCGSAFlAwQCAQUAoIIB9zAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xODA2MDYyMDE0MTdaMC8G
CSqGSIb3DQEJBDEiBCD0PUTUFcOe6rMhuTNNL4UaWuWmmlaw09pFAgK+4bUDkDBsBgkqhkiG
9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZI
hvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGMBgkr
BgEEAYI3EAQxfzB9MGkxCzAJBgNVBAYTAk5MMRYwFAYDVQQIEw1Ob29yZC1Ib2xsYW5kMRIw
EAYDVQQHEwlBbXN0ZXJkYW0xDzANBgNVBAoTBlRFUkVOQTEdMBsGA1UEAxMUVEVSRU5BIFBl
cnNvbmFsIENBIDMCEAz+ZcdTxAtjhuaHMgjEzfgwgY4GCyqGSIb3DQEJEAILMX+gfTBpMQsw
CQYDVQQGEwJOTDEWMBQGA1UECBMNTm9vcmQtSG9sbGFuZDESMBAGA1UEBxMJQW1zdGVyZGFt
MQ8wDQYDVQQKEwZURVJFTkExHTAbBgNVBAMTFFRFUkVOQSBQZXJzb25hbCBDQSAzAhAM/mXH
U8QLY4bmhzIIxM34MA0GCSqGSIb3DQEBAQUABIIBAAjClCYM+YC2+Y/Ty5FUUd1Dcs3ezXvU
+rO7uyrq4ZYeSg3Z5kyUwfLdzlFdwhLg5QFaNIhSHUkTXZXMKe8WfgwN9DHuKloyqwvn9AnR
FFJZ59n9hPt++5nUkNleRqoV1E2Rj7DEw4azVIi6DYtLkziG9hphFPST/g42PELd/cSA+7Gr
mXHBm1myv5k5/tFTE+nYYMn3Ib82R/3C0o6XCHfKa43V3LNxuuKqsqSDysc2edtmBOKD8a+m
CK/9kYE1mFbtgUsFmF/kd8yrYO/9k1Nvw3mz/BJivgJvGgXs2XRkNUoG7M1Al6mo7syab/Kr
HWp0IQHF8Ws+FDC2hhd+xM0AAAAAAAA=
--------------ms050700090105010500020007--

