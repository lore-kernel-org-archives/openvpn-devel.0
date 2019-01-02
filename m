From: Simon Rozman <simon@...2293...>
Date: Wed, 2 Jan 2019 16:37:33 +0000
Message-ID: <10B663D4-5299-4299-A6F7-D3DFEBD1FA44@...2293...>
References: <99D61A626FDA8A4B90A270669121BE109BE8AA4C@...2294...>
 <76addf9c-a14e-0e59-bb01-dace07b56a03@...277...>
 <775f6ca7-227f-6ae9-2206-1fa3d11b6376@...277...>
 <5aa26403-9948-df7a-6eaa-a6c1d0ba0a29@...277...>
 <99D61A626FDA8A4B90A270669121BE109BE8D349@...2294...>
 <CC83ED38-544A-4750-8AD0-6E5B60141864@...2293...>
 <a9509aa8-559c-9abc-db30-b3588bb2b6e1@...277...>
 <b3c46f54-fc61-80c8-a8c8-328e2bb1f9af@...277...>
In-Reply-To: <b3c46f54-fc61-80c8-a8c8-328e2bb1f9af@...277...>
Content-Language: en-US
Content-Type: multipart/signed;
 boundary="Apple-Mail=_3065EA79-4F7B-4DF3-B195-F06664856AFC";
 protocol="application/pkcs7-signature"; micalg=sha-256
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [Help required] Testing MSI installations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: tincanteksup <tincanteksup@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Apple-Mail=_3065EA79-4F7B-4DF3-B195-F06664856AFC
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_316A69FC-432D-4896-B2AD-58B27FA523CB"

--Apple-Mail=_316A69FC-432D-4896-B2AD-58B27FA523CB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

> However, there appears to be a problem ..
>=20
> https://paste.fedoraproject.org/paste/Ih2LYl0cR8YoKnI2lNwhcQ
>=20
> Part 1 is the client log *with* errors using the binary from your
> installer 2.4.6-m4 dated 1/Jan/2019

The 2.4.6-m4 version is based on the current release/2.4 <https://github.co=
m/OpenVPN/openvpn/commits/release/2.4> branch (with my MSI-specific patches=
 applied). You should consider the 2.4.6-m4 more like a 2.4.7-alpha than a =
2.4.6.

> Part 2 is the routing before and after part 1
>=20
> Part 3 is the client log *without* errors using the binary from
> the official installer 2.4.6 dated 26/Apr/2018
>=20
> Both logs are for the same config file on the same machine
> Windows 7 32bit VM -- Fully upto date with MS.
>=20
> Even though there are errors reported the VPN still works for both
> IPv4 and 6 with both versions of the binary.

Probably a patch between 2.4.6 from 26/Apr/2018 and 2.4.6-m4 from 1/Jan/201=
9 introduced an error-level check after the netsh.exe interface ipv6 add ro=
ute call.

Take this as a bonus: you are testing MSI setup and the 2.4.7 prerelease at=
 the same time. :)

I am thinking of rebasing the 2.4.6-mX on the original 2.4.6 release from 2=
6/Apr/2018 to avoid confusion. Maybe package an even older release to allow=
 MSI with MSI update testing.

Regards,
Simon=

--Apple-Mail=_316A69FC-432D-4896-B2AD-58B27FA523CB
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3Dus-ascii"></head><body style=3D"word-wrap: break-word; -webkit-nbsp-mode=
: space; line-break: after-white-space;" class=3D"">Hi,<br class=3D""><div>=
<br class=3D""><blockquote type=3D"cite" class=3D""><div class=3D"">However=
, there appears to be a problem ..</div><div class=3D""><div class=3D""><br=
 class=3D""><a href=3D"https://paste.fedoraproject.org/paste/Ih2LYl0cR8YoKn=
I2lNwhcQ" class=3D"">https://paste.fedoraproject.org/paste/Ih2LYl0cR8YoKnI2=
lNwhcQ</a><br class=3D""><br class=3D"">Part 1 is the client log *with* err=
ors using the binary from your<br class=3D"">installer 2.4.6-m4 dated 1/Jan=
/2019<br class=3D""></div></div></blockquote><div><br class=3D""></div><div=
>The 2.4.6-m4 version is based on the current&nbsp;<a href=3D"https://githu=
b.com/OpenVPN/openvpn/commits/release/2.4" class=3D"">release/2.4</a>&nbsp;=
branch (with my MSI-specific patches applied). You should consider the 2.4.=
6-m4 more like a 2.4.7-alpha than a 2.4.6.</div><br class=3D""><blockquote =
type=3D"cite" class=3D""><div class=3D""><div class=3D"">Part 2 is the rout=
ing before and after part 1<br class=3D""><br class=3D"">Part 3 is the clie=
nt log *without* errors using the binary from<br class=3D"">the official in=
staller 2.4.6 dated 26/Apr/2018<br class=3D""><br class=3D"">Both logs are =
for the same config file on the same machine<br class=3D"">Windows 7 32bit =
VM -- Fully upto date with MS.<br class=3D""><br class=3D"">Even though the=
re are errors reported the VPN still works for both<br class=3D"">IPv4 and =
6 with both versions of the binary.<br class=3D""></div></div></blockquote>=
</div><br class=3D""><div class=3D"">Probably a patch between 2.4.6 from 26=
/Apr/2018 and 2.4.6-m4 from 1/Jan/2019 introduced an error-level check afte=
r the <font face=3D"Courier New" class=3D"">netsh.exe interface ipv6 add ro=
ute</font> call.</div><div class=3D""><br class=3D""></div><div class=3D"">=
Take this as a bonus: you are testing MSI setup <i class=3D"">and</i> the 2=
.4.7 prerelease at the same time. :)</div><div class=3D""><br class=3D""></=
div><div class=3D"">I am thinking of rebasing the 2.4.6-mX on the original =
2.4.6 release from 26/Apr/2018 to avoid confusion. Maybe package an even ol=
der release to allow MSI with MSI update testing.</div><div class=3D""><br =
class=3D""></div><div class=3D"">Regards,</div><div class=3D"">Simon</div><=
/body></html>=

--Apple-Mail=_316A69FC-432D-4896-B2AD-58B27FA523CB--

--Apple-Mail=_3065EA79-4F7B-4DF3-B195-F06664856AFC
Content-Disposition: attachment; filename="smime.p7s"
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

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
HR8EgeYwgeMwVqBUoFKkUDBOMQswCQYDVQQGEwJzaTEbMBkGA1UEChMSc3RhdGUtaW5zdGl0dXRp
b25zMREwDwYDVQQLEwhzaWdlbi1jYTEPMA0GA1UEAxMGQ1JMNDU1MIGIoIGFoIGChldsZGFwOi8v
eDUwMC5nb3Yuc2kvb3U9c2lnZW4tY2Esbz1zdGF0ZS1pbnN0aXR1dGlvbnMsYz1zaT9jZXJ0aWZp
Y2F0ZVJldm9jYXRpb25MaXN0P2Jhc2WGJ2h0dHA6Ly93d3cuc2lnZW4tY2Euc2kvY3JsL3NpZ2Vu
LWNhLmNybDArBgNVHRAEJDAigA8yMDE2MDIxOTE3NTQ0MVqBDzIwMjEwMjE5MjEzODE1WjAfBgNV
HSMEGDAWgBRxe4oGHzEFVatgEndHIB4DiBjsiTAdBgNVHQ4EFgQUu/+wB8kGCNHvBjj5sE3NWUzc
OZcwCQYDVR0TBAIwADAZBgkqhkiG9n0HQQAEDDAKGwRWOC4xAwIDqDANBgkqhkiG9w0BAQUFAAOC
AQEAQVC+ChtWdaASCHSiGbPcicZyYPy3xD1b8zR/PggqnoKtA+pOPA6KO9qFRIrJI6oIHW1Bo99L
gB/D4wg+ZCxlaA8IeWtmrUN6kM2mAP5Y9ibNn+H3VzZ+tL0ae182xrEHcGGHnCKyszucel1QCEW/
kx2TY1y91V+rzqM8AUL//ncdT/R/6zFJ+3fHIu7+D3qkoW1m1sIuns9fXGb0ikpM/5Vn+LY/EGwN
J1nlAZZNwcev00XWu5MF83BRMbfkThrdGCY22Qjd5He7MHEb0U+oBIvS+p9Vy4IcD0mIc2Y2i+X1
7yNdSbkqEAstd11gZKt+TKKOImNfcGp0tVulDPGKtDCCBeUwggRNoAMCAQICDQCmaL1RAAAAAFcd
0OgwDQYJKoZIhvcNAQELBQAwXDELMAkGA1UEBhMCU0kxHDAaBgNVBAoTE1JlcHVibGlrYSBTbG92
ZW5pamExFzAVBgNVBGETDlZBVFNJLTE3NjU5OTU3MRYwFAYDVQQDEw1TSS1UUlVTVCBSb290MB4X
DTE2MDUyNDExNTgyN1oXDTIxMDYyNzIyMDAwMFowPTELMAkGA1UEBhMCc2kxGzAZBgNVBAoTEnN0
YXRlLWluc3RpdHV0aW9uczERMA8GA1UECxMIc2lnZW4tY2EwggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQCw5WWywKxklvKIG7PtnuQCxk8riM4uilGAda8QW/LLOGabog5tNEeWpZIRr/Y1
R6J3IgzOFohiqtNJbhi8LkTYvsaewhoZrEGO/DAHAvLGatRbIwDvQTTYpHNj3yKSM4QBpY3zg1z6
uNR6Nd/s+G0P4EztrZw6fYbWpQiUvn16ER/+hT9UWohjh5ylsadOzbdEc6/PiklrH+PN10lNWisX
5lx2s7tyuW8n0puJFYjfEF92IQFqxxUxCtGcWPgoFgVt2U7ZodcHIMtLJolNkrKnupbo41iPIpwB
llrE9zFNC0m14Xhh4lQYBrueVDR+DD7r7rWAH90WhB1oOGZnc/iRAgMBAAGjggJDMIICPzASBgNV
HRMBAf8ECDAGAQH/AgEAMA4GA1UdDwEB/wQEAwIBBjA6BgNVHSAEMzAxMC8GBFUdIAAwJzAlBggr
BgEFBQcCARYZaHR0cDovL3d3dy5jYS5nb3Yuc2kvY3BzLzBpBggrBgEFBQcBAQRdMFswNgYIKwYB
BQUHMAKGKmh0dHA6Ly93d3cuY2EuZ292LnNpL2NydC9zaS10cnVzdC1yb290LmNydDAhBggrBgEF
BQcwAYYVaHR0cDovL29jc3AuY2EuZ292LnNpMB0GA1UdDgQWBBRxe4oGHzEFVatgEndHIB4DiBjs
iTCCATwGA1UdHwSCATMwggEvMIG3oIG0oIGxhipodHRwOi8vd3d3LmNhLmdvdi5zaS9jcmwvc2kt
dHJ1c3Qtcm9vdC5jcmyGgYJsZGFwOi8veDUwMC5nb3Yuc2kvY249U0ktVFJVU1QlMjBSb290LG9y
Z2FuaXphdGlvbklkZW50aWZpZXI9VkFUU0ktMTc2NTk5NTcsbz1SZXB1Ymxpa2ElMjBTbG92ZW5p
amEsYz1TST9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0MHOgcaBvpG0wazELMAkGA1UEBhMCU0kx
HDAaBgNVBAoTE1JlcHVibGlrYSBTbG92ZW5pamExFzAVBgNVBGETDlZBVFNJLTE3NjU5OTU3MRYw
FAYDVQQDEw1TSS1UUlVTVCBSb290MQ0wCwYDVQQDEwRDUkwxMBMGA1UdIwQMMAqACEyjw2heCAJj
MA0GCSqGSIb3DQEBCwUAA4IBgQB7rzUj4WOKnIq1iZE8JKmjj6jkldOif2XqRUH1BCfO05axo6eF
0eRS5LUwBGP+0eEoHm9ivDlhJfyqHNQWx+vrsmWL32vlp5yRFnljpsj8v76KDu3mcjlb2jkcbq1j
iwglQ1tsAZG7VKCmWlMs4D/mTzxkVfBhZW2SwsxpgKzBlyV3vLf1zYiQy3oRqklk+PTWI8mEHSIC
PqovVvgOgUlEPY7DHWCaioV0HKLHx+dbHOoGVcUyjK9z7CLbGvFxYjWsxAgABa9JrOxwes2/ELx0
RXgRpPwi61uFZGRATfybbsob4JLUNgb7hrWrhLx2UAGKTEod+Q+6cLWr0TKZoWgLEG+Mj6oSDHM7
cEarCjwYVqGhRFWflZ98MWqeYf6AIaHInzc5FiUzVo8Z6DzNnjc9rlhSbILDYZcLXlL56u/mykzb
Xkiliq+qSPhlLGYZgoeVEaVJ6lGp6dFIntDA/X97Yjizqe9dbDW9McIvlXQ7gwd+yHXTiLH4TwaK
HcKaBa0xggKLMIIChwIBATBFMD0xCzAJBgNVBAYTAnNpMRswGQYDVQQKExJzdGF0ZS1pbnN0aXR1
dGlvbnMxETAPBgNVBAsTCHNpZ2VuLWNhAgQ7Sg0uMA0GCWCGSAFlAwQCAQUAoIIBFzAYBgkqhkiG
9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xOTAxMDIxNjM3MzNaMC8GCSqGSIb3
DQEJBDEiBCBEIpkiUVgG9hlKx0pLlaeUqte0+jNNM/QvI6X1V1BLkjBUBgkrBgEEAYI3EAQxRzBF
MD0xCzAJBgNVBAYTAnNpMRswGQYDVQQKExJzdGF0ZS1pbnN0aXR1dGlvbnMxETAPBgNVBAsTCHNp
Z2VuLWNhAgQ7Sg0uMFYGCyqGSIb3DQEJEAILMUegRTA9MQswCQYDVQQGEwJzaTEbMBkGA1UEChMS
c3RhdGUtaW5zdGl0dXRpb25zMREwDwYDVQQLEwhzaWdlbi1jYQIEO0oNLjANBgkqhkiG9w0BAQEF
AASCAQBUnmnPNfw1GVe45QU5HzBzoST27S5bSLU5bRB4NFRJtI2PXJ2VJGo1NxRLiK37Wd/JRhwm
W06mlomMQLvg7FD7tdYlP6DNv9edPy0p1LOUSkPtzxN+Jpvm0e9/Qq4qCO/F6jZm2J7EKW5e/3AK
q+hl6advO+a6Gg9rAZc6plIUSF2wHWS9K7rCNhjCXsK3zcW6Rbsf9c8tpFD93QyQ+23MC736LQB3
wrOZ8HeR1f5FwWA0UyC6YaJiH7st1cyc/Bvoo/7OfsoHsKztGDoG/QFCrLeT3iypEge/yFR0ATAB
C4Xw/f4gkBEKX93Fc4J3BuXyP6WnCHk/wcVpDxGRYUzOAAAAAAAA

--Apple-Mail=_3065EA79-4F7B-4DF3-B195-F06664856AFC--

