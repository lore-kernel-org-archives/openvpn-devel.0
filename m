Message-ID: <1403533437.15555.49.camel@...1865...>
From: David Woodhouse <dwmw2@...1866...>
Date: Mon, 23 Jun 2014 15:23:57 +0100
In-Reply-To: <538CA61B.9060803@...1516...>
References: <1397645317-20116-1-git-send-email-Holger.Kummert@...1516...>
	<20140418210522.GE16637@...1296...> <53525655.4010301@...1147...>
	<538CA61B.9060803@...1516...>
Content-Type: multipart/signed; micalg="sha-1";
	protocol="application/x-pkcs7-signature"; 
	boundary="=-uNMliFO5aVClfgdB0LO9"
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] Wanted: NTLM-Testers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Holger Kummert <Holger.Kummert@...1516...>
Cc: openvpn-devel@lists.sourceforge.net

--=-uNMliFO5aVClfgdB0LO9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2014-06-02 at 18:28 +0200, Holger Kummert wrote:
>=20
> Hi,
>=20
> due to the lack of a testing environment for the main developers we are
> looking for someone who is willing to test the two patches which make
> the NTLMv1 and v2-code running (again?) and offer a clearer user
> interface for the configuration of http proxy authentication.
>=20
> The developer of the patches already tested them, but a second proof
> that they really work would be very helpful.
>=20
> The patches, based on the master branch, can be found at:
>=20
> http://thread.gmane.org/gmane.network.openvpn.devel/8531

As it happens, I've just added proxy auth support to the OpenConnect VPN
client, and have a local squid instance set up to accept all of GSSAPI,
NTLM, Digest and Basic auth.

Looking over the patches first... they make the client work in OEM or
Unicode mode according to what the server asks for... but then only ever
admit to supporting Unicode mode in the 'phase 1' packet anyway. So a
sane server is *never* going to ask you to do OEM, and you might as well
ditch all the conditional code for supporting that. (Quite frankly, even
if you add the OEM flag to your phase 1 packet, a sane server in 2014 is
*still* never going to ask you to do OEM mode anyway, is it?)

Also, it is strictly correct to assume that the input strings are utf-8?
It certainly *ought* to be =E2=80=94 again, it's 2014 so who in their right=
 mind
would be using non-UTF8 locales? But some nutters insist on remaining
stuck in the 20th century...

You also don't seem to include the NTLM_NEGOTIATE_TARGET_INFO flag in
your phase 1 packet, which means I'd be surprised if you ever actually
get the target info back from a server in its challenge... which in turn
means I'd be surprised if you'd actually exercised that part of the
NTLMv2 code path. Or do some servers send it 'unsolicited'? Samba
apparently doesn't send it even if I do set the TARGET_INFO flag in the
phase_1 packet...

Yours is actually the first implementation of NTLMv2 auth that I've seen
=E2=80=94 other implementations seem to have a combination of NTLMv1 and 'N=
TLMv2
session' authentication =E2=80=94 see
http://curl.cofman.dk/rfc/ntlm.html#theNtlm2SessionResponse and=20
http://git.infradead.org/users/dwmw2/openconnect.git/commitdiff/fe5cf5fd67 =
for example. We send just the single phase1 packet, and the server either t=
akes us up on the offer of NTLMv2 session auth, or not.

All that said, these patches do seem to work for NTLMv1 and NTLMv2
authentication to my test server. Although I need to explicitly *ask*
for NTLMv2; if I just say 'ntlm' then it uses NTLMv1. That isn't what I
expected after reading the commit message on the second patch.

And if I say '--http-proxy localhost 3128 auto', it doesn't work at all.
And doesn't really tell me why, which is naughty of it:

Enter HTTP Proxy Username:dwoodhou=20
Enter HTTP Proxy Password:
Mon Jun 23 14:36:03 2014 SIGTERM[soft,init_instance] received, process exit=
ing


However, one of the things that NTLM is supposed to offer me is
single-sign-on. If I've logged in to my workstation using my domain
password (and I have), then single-sign-on ought to work by using
Samba's /usr/bin/ntlm_auth helper tool. That works for other things like
Firefox and the Evolution mail client... and for proxy auth with
OpenConnect too, of course. There's a simple implementation at
http://git.infradead.org/users/dwmw2/openconnect.git/commitdiff/583ee4b6c3 =
which you are welcome to copy into OpenVPN under GPLv2.

Of course, GSSAPI support would also give me single-sign-on. But you
don't support that either. Again, you're welcome to use my code from
OpenConnect if it's useful. RFC1928 says that SOCKS implementations MUST
support GSSAPI auth too, FWIW :)

--=20
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@...753...                              Intel Corporation

--=-uNMliFO5aVClfgdB0LO9
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIISxDCCBjQw
ggQcoAMCAQICAR4wDQYJKoZIhvcNAQEFBQAwfTELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0
Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxKTAn
BgNVBAMTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTA3MTAyNDIxMDE1NVoX
DTE3MTAyNDIxMDE1NVowgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSsw
KQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgwNgYDVQQDEy9TdGFy
dENvbSBDbGFzcyAxIFByaW1hcnkgSW50ZXJtZWRpYXRlIENsaWVudCBDQTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAMcJg8zOLdgasSmkLhOrlr6KMoOMpohBllVHrdRvEg/q6r8jR+EK
75xCGhR8ToREoqe7zM9/UnC6TS2y9UKTpT1v7RSMzR0t6ndl0TWBuUr/UXBhPk+Kmy7bI4yW4urC
+y7P3/1/X7U8ocb8VpH/Clt+4iq7nirMcNh6qJR+xjOhV+VHzQMALuGYn5KZmc1NbJQYclsGkDxD
z2UbFqE2+6vIZoL+jb9x4Pa5gNf1TwSDkOkikZB1xtB4ZqtXThaABSONdfmv/Z1pua3FYxnCFmdr
/+N2JLKutIxMYqQOJebr/f/h5t95m4JgrM3Y/w7YX9d7YAL9jvN4SydHsU6n65cCAwEAAaOCAa0w
ggGpMA8GA1UdEwEB/wQFMAMBAf8wDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBRTcu2SnODaywFc
fH6WNU7y1LhRgjAfBgNVHSMEGDAWgBROC+8apEBbpRdphzDKNGhD0EGu8jBmBggrBgEFBQcBAQRa
MFgwJwYIKwYBBQUHMAGGG2h0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbS9jYTAtBggrBgEFBQcwAoYh
aHR0cDovL3d3dy5zdGFydHNzbC5jb20vc2ZzY2EuY3J0MFsGA1UdHwRUMFIwJ6AloCOGIWh0dHA6
Ly93d3cuc3RhcnRzc2wuY29tL3Nmc2NhLmNybDAnoCWgI4YhaHR0cDovL2NybC5zdGFydHNzbC5j
b20vc2ZzY2EuY3JsMIGABgNVHSAEeTB3MHUGCysGAQQBgbU3AQIBMGYwLgYIKwYBBQUHAgEWImh0
dHA6Ly93d3cuc3RhcnRzc2wuY29tL3BvbGljeS5wZGYwNAYIKwYBBQUHAgEWKGh0dHA6Ly93d3cu
c3RhcnRzc2wuY29tL2ludGVybWVkaWF0ZS5wZGYwDQYJKoZIhvcNAQEFBQADggIBAAqDCH14qywG
XLhjjF6uHLkjd02hcdh9hrw+VUsv+q1eeQWB21jWj3kJ96AUlPCoEGZ/ynJNScWy6QMVQjbbMXlt
UfO4n4bGGdKo3awPWp61tjAFgraLJgDk+DsSvUD6EowjMTNx25GQgyYJ5RPIzKKR9tQW8gGK+2+R
HxkUCTbYFnL6kl8Ch507rUdPPipJ9CgJFws3kDS3gOS5WFMxcjO5DwKfKSETEPrHh7p5shuuNktv
sv6hxHTLhiMKX893gxdT3XLS9OKmCv87vkINQcNEcIIoFWbP9HORz9v3vQwR4e3ksLc2JZOAFK+s
sS5XMEoznzpihEP0PLc4dCBYjbvSD7kxgDwZ+Aj8Q9PkbvE9sIPP7ON0fz095HdThKjiVJe6vofq
+n6b1NBc8XdrQvBmunwxD5nvtTW4vtN6VY7mUCmxsCieuoBJ9OlqmsVWQvifIYf40dJPZkk9YgGT
zWLpXDSfLSplbY2LL9C9U0ptvjcDjefLTvqSFc7tw1sEhF0n/qpA2r0GpvkLRDmcSwVyPvmjFBGq
Up/pNy8ZuPGQmHwFi2/14+xeSUDG2bwnsYJQG2EdJCB6luQ57GEnTA/yKZSTKI8dDQa8Sd3zfXb1
9mOgSF0bBdXbuKhEpuP9wirslFe6fQ1t5j5R0xi72MZ8ikMu1RQZKCyDbMwazlHiMIIGQjCCBSqg
AwIBAgIDCdkyMA0GCSqGSIb3DQEBBQUAMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRD
b20gTHRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYG
A1UEAxMvU3RhcnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0EwHhcN
MTQwNTA0MTczMDIyWhcNMTUwNTA0MjM0MTAxWjBdMRkwFwYDVQQNExAzODNCMTVkSHFQSUR0cDZO
MRwwGgYDVQQDDBNkd213MkBpbmZyYWRlYWQub3JnMSIwIAYJKoZIhvcNAQkBFhNkd213MkBpbmZy
YWRlYWQub3JnMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAy7K+t+REIdZGFUfgR8Io
QrJ/VLZil9I00JcwqTo8BiGy1dqSIB2y923siya5SDKMh1YurtCPsX96cNzwPmmN2cs0MKeVPQWz
iQhHk3uKcB6LvvS7pzTahRWMRmTyW3CH+RphRM9plvyClY23GEeEnpBnGz4GaJJiPcJjGgzyZ/tI
q473pOlSrDPZnZk43vt/5CJN46nIZOZ2I+PzlgINI+EbiwsXVn3VohHB7nVTwGaRLk5oywGt8ZT7
tDdxn3BQ3inO1sr5MtkV1o2cHlenIC8mlU8nL/mrqqVve7Vib1YQUycW+Pj4CBYm4FTeuctAvNzK
U/daeBclOZ8ofgQe2wIDAQABo4IC2TCCAtUwCQYDVR0TBAIwADALBgNVHQ8EBAMCBLAwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMB0GA1UdDgQWBBRAjCSCV70BpLBeXge5DXi+mPhHTTAf
BgNVHSMEGDAWgBRTcu2SnODaywFcfH6WNU7y1LhRgjAeBgNVHREEFzAVgRNkd213MkBpbmZyYWRl
YWQub3JnMIIBTAYDVR0gBIIBQzCCAT8wggE7BgsrBgEEAYG1NwECAzCCASowLgYIKwYBBQUHAgEW
Imh0dHA6Ly93d3cuc3RhcnRzc2wuY29tL3BvbGljeS5wZGYwgfcGCCsGAQUFBwICMIHqMCcWIFN0
YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MAMCAQEagb5UaGlzIGNlcnRpZmljYXRlIHdh
cyBpc3N1ZWQgYWNjb3JkaW5nIHRvIHRoZSBDbGFzcyAxIFZhbGlkYXRpb24gcmVxdWlyZW1lbnRz
IG9mIHRoZSBTdGFydENvbSBDQSBwb2xpY3ksIHJlbGlhbmNlIG9ubHkgZm9yIHRoZSBpbnRlbmRl
ZCBwdXJwb3NlIGluIGNvbXBsaWFuY2Ugb2YgdGhlIHJlbHlpbmcgcGFydHkgb2JsaWdhdGlvbnMu
MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuc3RhcnRzc2wuY29tL2NydHUxLWNybC5jcmww
gY4GCCsGAQUFBwEBBIGBMH8wOQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbS9z
dWIvY2xhc3MxL2NsaWVudC9jYTBCBggrBgEFBQcwAoY2aHR0cDovL2FpYS5zdGFydHNzbC5jb20v
Y2VydHMvc3ViLmNsYXNzMS5jbGllbnQuY2EuY3J0MCMGA1UdEgQcMBqGGGh0dHA6Ly93d3cuc3Rh
cnRzc2wuY29tLzANBgkqhkiG9w0BAQUFAAOCAQEAWS2KNN7O3vZVtNHXVqgbmijeptKwt+8b6yiF
wT3kJoywInPl5U+OeKRZfQKTHghM4Ohof6lF244ZMxhir/xp7l/zkZ/BUbxLwp6kIL27Gi5pgP4D
KLnTZheQL9N5Yi/vMONxMWcpcW+ZNv5hnDCfEsfVcLXC8sNLPjx2ezfMIhSSPwBuJpmOun70te4E
P0YBqjSalPfvc5fC5KgaYtqTDFwo9Mw25X5HHDC0r6BK5aNrF1nD/xYTX7cdvZZWl7cUApr4PCrn
uI2DEn7OWQ/rY407ytV1c5pjvmuv/IT/ZUb/kXV6Q47UvrJp2Ifi2VhsBcnHHasKavjtRCmpDsGM
rTCCBkIwggUqoAMCAQICAwnZMjANBgkqhkiG9w0BAQUFADCBjDELMAkGA1UEBhMCSUwxFjAUBgNV
BAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNp
Z25pbmcxODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xp
ZW50IENBMB4XDTE0MDUwNDE3MzAyMloXDTE1MDUwNDIzNDEwMVowXTEZMBcGA1UEDRMQMzgzQjE1
ZEhxUElEdHA2TjEcMBoGA1UEAwwTZHdtdzJAaW5mcmFkZWFkLm9yZzEiMCAGCSqGSIb3DQEJARYT
ZHdtdzJAaW5mcmFkZWFkLm9yZzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMuyvrfk
RCHWRhVH4EfCKEKyf1S2YpfSNNCXMKk6PAYhstXakiAdsvdt7IsmuUgyjIdWLq7Qj7F/enDc8D5p
jdnLNDCnlT0Fs4kIR5N7inAei770u6c02oUVjEZk8ltwh/kaYUTPaZb8gpWNtxhHhJ6QZxs+BmiS
Yj3CYxoM8mf7SKuO96TpUqwz2Z2ZON77f+QiTeOpyGTmdiPj85YCDSPhG4sLF1Z91aIRwe51U8Bm
kS5OaMsBrfGU+7Q3cZ9wUN4pztbK+TLZFdaNnB5XpyAvJpVPJy/5q6qlb3u1Ym9WEFMnFvj4+AgW
JuBU3rnLQLzcylP3WngXJTmfKH4EHtsCAwEAAaOCAtkwggLVMAkGA1UdEwQCMAAwCwYDVR0PBAQD
AgSwMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDAdBgNVHQ4EFgQUQIwkgle9AaSwXl4H
uQ14vpj4R00wHwYDVR0jBBgwFoAUU3Ltkpzg2ssBXHx+ljVO8tS4UYIwHgYDVR0RBBcwFYETZHdt
dzJAaW5mcmFkZWFkLm9yZzCCAUwGA1UdIASCAUMwggE/MIIBOwYLKwYBBAGBtTcBAgMwggEqMC4G
CCsGAQUFBwIBFiJodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS9wb2xpY3kucGRmMIH3BggrBgEFBQcC
AjCB6jAnFiBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTADAgEBGoG+VGhpcyBjZXJ0
aWZpY2F0ZSB3YXMgaXNzdWVkIGFjY29yZGluZyB0byB0aGUgQ2xhc3MgMSBWYWxpZGF0aW9uIHJl
cXVpcmVtZW50cyBvZiB0aGUgU3RhcnRDb20gQ0EgcG9saWN5LCByZWxpYW5jZSBvbmx5IGZvciB0
aGUgaW50ZW5kZWQgcHVycG9zZSBpbiBjb21wbGlhbmNlIG9mIHRoZSByZWx5aW5nIHBhcnR5IG9i
bGlnYXRpb25zLjA2BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLnN0YXJ0c3NsLmNvbS9jcnR1
MS1jcmwuY3JsMIGOBggrBgEFBQcBAQSBgTB/MDkGCCsGAQUFBzABhi1odHRwOi8vb2NzcC5zdGFy
dHNzbC5jb20vc3ViL2NsYXNzMS9jbGllbnQvY2EwQgYIKwYBBQUHMAKGNmh0dHA6Ly9haWEuc3Rh
cnRzc2wuY29tL2NlcnRzL3N1Yi5jbGFzczEuY2xpZW50LmNhLmNydDAjBgNVHRIEHDAahhhodHRw
Oi8vd3d3LnN0YXJ0c3NsLmNvbS8wDQYJKoZIhvcNAQEFBQADggEBAFktijTezt72VbTR11aoG5oo
3qbSsLfvG+sohcE95CaMsCJz5eVPjnikWX0Ckx4ITODoaH+pRduOGTMYYq/8ae5f85GfwVG8S8Ke
pCC9uxouaYD+Ayi502YXkC/TeWIv7zDjcTFnKXFvmTb+YZwwnxLH1XC1wvLDSz48dns3zCIUkj8A
biaZjrp+9LXuBD9GAao0mpT373OXwuSoGmLakwxcKPTMNuV+RxwwtK+gSuWjaxdZw/8WE1+3Hb2W
Vpe3FAKa+Dwq57iNgxJ+zlkP62ONO8rVdXOaY75rr/yE/2VG/5F1ekOO1L6yadiH4tlYbAXJxx2r
Cmr47UQpqQ7BjK0xggNvMIIDawIBATCBlDCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0
Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2
BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBAgMJ
2TIwCQYFKw4DAhoFAKCCAa8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUx
DxcNMTQwNjIzMTQyMzU4WjAjBgkqhkiG9w0BCQQxFgQUhjIhZVcPSqu8JZ+gHch0ulQU0xswgaUG
CSsGAQQBgjcQBDGBlzCBlDCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4x
KzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMTL1N0
YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBAgMJ2TIwgacGCyqG
SIb3DQEJEAILMYGXoIGUMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjEr
MCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYGA1UEAxMvU3Rh
cnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0ECAwnZMjANBgkqhkiG
9w0BAQEFAASCAQAxz2qicL2MW5hZycqS8r4WkrzAPi83QIgVSsCS1vL472SczGOFUAGFmH6+T7zQ
32E+SLzcnzLu8xK67fU+ZIwB3VsQ8qUB7kuqvSJNHJDi8ufLefhl7xIZ7tRr8Cm0yR9Xv8OlwFxp
DKiRG+BAdppttjqD6ZLSWYwpdDMNTqyOvRt5M5FTNEWtxf5PKHP0xN4up5BRX2lIiNJffiHlWr8g
X1DBBd6U569fUmcZlKxcDuBHSQmoYD/bhvRURZWafB8df+iItXeYhuh14bYYfVovgo13pu/YkfYI
5WmrzlvDxmWzlL7JJ9bwD/5ZNMbmpH4FpHMo45x8e0DOTXL4D+PfAAAAAAAA


--=-uNMliFO5aVClfgdB0LO9--


