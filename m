Message-ID: <1418303015.31745.78.camel@...1866...>
From: David Woodhouse <dwmw2@...1866...>
Date: Thu, 11 Dec 2014 13:03:35 +0000
Content-Type: multipart/signed; micalg="sha-1";
	protocol="application/x-pkcs7-signature"; 
	boundary="=-kYIKIs+MnjxSmA8sAYIp"
Mime-Version: 1.0
Subject: [Openvpn-devel] [PATCH] pkcs11: Load p11-kit-proxy.so module by
	default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--=-kYIKIs+MnjxSmA8sAYIp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

If the user specifies --pkcs11-id or --pkcs-id-management but neglects
to explicitly provide a --pkcs11-provider argument, and if the system
has p11-kit installed, then load the p11-kit proxy module so that the
system-configured tokens are available.

Trac: 490
Signed-off-by: David Woodhouse <David.Woodhouse@...753...>
---
 configure.ac          |  7 +++++++
 doc/openvpn.8         | 10 ++++++++++
 src/openvpn/options.c |  9 +++++++++
 3 files changed, 26 insertions(+)

diff --git a/configure.ac b/configure.ac
index ddaa2b2..b549452 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1139,6 +1139,13 @@ if test "${enable_pkcs11}" =3D "yes"; then
 	OPTIONAL_PKCS11_HELPER_CFLAGS=3D"${PKCS11_HELPER_CFLAGS}"
 	OPTIONAL_PKCS11_HELPER_LIBS=3D"${PKCS11_HELPER_LIBS}"
 	AC_DEFINE([ENABLE_PKCS11], [1], [Enable PKCS11])
+	PKG_CHECK_MODULES(
+		[P11KIT],
+		[p11-kit-1],
+		[proxy_module=3D"`$PKG_CONFIG --variable=3Dproxy_module p11-kit-1`"
+		 AC_DEFINE_UNQUOTED([DEFAULT_PKCS11_MODULE], "${proxy_module}", [p11-kit=
 proxy])],
+		[]
+	)
 fi
=20
 if test "${enable_pedantic}" =3D "yes"; then
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 532eda5..0bdea1f 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4393,6 +4393,16 @@ This option can be used instead of
 .B \-\-cert, \-\-key,
 and
 .B \-\-pkcs12.
+
+If p11-kit is present on the system, its
+.B p11-kit-proxy.so
+module will be loaded by default if either the
+.B \-\-pkcs11\-id
+or
+.B \-\-pkcs11\-id\-management
+options are specified without
+.B \-\-pkcs11\-provider
+being given.
 .\"*********************************************************
 .TP
 .B \-\-pkcs11-private-mode mode...
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index f0091c2..b33eb4a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2447,6 +2447,15 @@ options_postprocess_mutate_invariant (struct options=
 *options)
 #endif
     }
 #endif
+
+#ifdef DEFAULT_PKCS11_MODULE
+  /* If p11-kit is present on the system then load its p11-kit-proxy.so
+     by default if the user asks for PKCS#11 without otherwise specifying
+     the module to use. */
+  if (!options->pkcs11_providers[0] &&
+      (options->pkcs11_id || options->pkcs11_id_management))
+    options->pkcs11_providers[0] =3D DEFAULT_PKCS11_MODULE;
+#endif
 }
=20
 static void
--=20
2.1.0


--=20
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@...753...                              Intel Corporation

--=-kYIKIs+MnjxSmA8sAYIp
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
DxcNMTQxMjExMTMwMzM1WjAjBgkqhkiG9w0BCQQxFgQUlBLxtcugcnpf6izpLJYadGGbo7gwgaUG
CSsGAQQBgjcQBDGBlzCBlDCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4x
KzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMTL1N0
YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBAgMJ2TIwgacGCyqG
SIb3DQEJEAILMYGXoIGUMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjEr
MCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYGA1UEAxMvU3Rh
cnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0ECAwnZMjANBgkqhkiG
9w0BAQEFAASCAQAJwh5ygbyMnn6LCZC5KIQHKM0pD+5VmbpzV1NYikPoXDKmGGUNl8QTsKFMQ0zX
p7QThIThElwADw2lnJSWdx0mMDHqBlN9hnOeWMNZs9isE8oO5kBs/k2pPc492D7ScgbPBb0Jgvk3
cTCD3018Jg2t5E8ryu1GOyBQsLb7w2nU7aXfbsrH8NJTF0eXPNFTr3XpOsYBuvL4vnmTwWzq1lu0
UDAoeUwS6gGx41X3vpDO3xWW48Z4wsLtJMNAHQvGkPA4TJmygWXR+c1MVEmDmokG9t1szb+GVs1F
e8BpNYg4TsqX9KBU11I4dBzfD59QnzPodpnh13OY3m/gWCAXFpn8AAAAAAAA


--=-kYIKIs+MnjxSmA8sAYIp--


