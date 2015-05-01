Message-ID: <1430523426.21119.113.camel@...1866...>
From: David Woodhouse <dwmw2@...1866...>
Date: Sat, 02 May 2015 00:37:06 +0100
In-Reply-To: <CAOazyz0KoSiUn=DA_0QBf3JXU=eQ1NJGQgtRw0z7DCo+E066Kw@...278...>
References: <1430518805.21119.82.camel@...1866...>
	<CAOazyz0KoSiUn=DA_0QBf3JXU=eQ1NJGQgtRw0z7DCo+E066Kw@...278...>
Content-Type: multipart/signed; micalg="sha-1";
	protocol="application/x-pkcs7-signature"; 
	boundary="=-IcKgw0ZcLQ/xMOLmEhm/"
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Use vfork() in openvpn_execve() instead
	of fork()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--=-IcKgw0ZcLQ/xMOLmEhm/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2015-05-02 at 01:54 +0300, Alon Bar-Lev wrote:
> PKCS#11 explicitly states that C_Initialize must be called post=20
> fork().

Hi Alon, thanks for the quick response and the citation from the spec;
I had looked briefly and not yet found that.

It's quite clear, as I had assumed, that your code in pkcs11-helper is
doing the right thing.

> > Firstly, OpenVPN is forking to spawn systemd-ask-password from
> > *within* the PIN request callback, which is expressly forbidden and
> > leads directly to a deadlock.
>=20
> This is common misconception of what smartcards are.
> 1. On startup it is not guaranteed that smartcard is even inserted into r=
eader.
> 2. A smartcard can be removed during program execution.
> 3. A smartcard can be inserted into different reader (or dynamic reader).
> 4. Wrong smartcard can be inserted, and avoid to be locked.
> 5. PIN policy of card may differ, the exact point in time in which PIN
> is required is unknown.

That's why we have callbacks. You call back from pkcs11-helper into
the application when you need a PIN. As you say, the point in time
that such is required is unknown. Which is why we can't make life easy
by asking for it in advance.

I'm aware of the misconception you mention above, but I'm not sure why
you mention it here. OpenVPN doesn't seem to be guilty of it.

> not sure what systemd-ask-password is, but the proper interaction=20
> with openvpn process in this case is via the management interface,=20
> there is an example here[1].

It's a tool which gets spawned to ask the user (sysadmin) for a
password. I've never actually seen it working in practice, but I think
it's something vaguely similar to ssh-askpass.

I think it's designed to work even during a graphical boot sequence
before any real UI is present (for example for asking for root file
system encryption passphrases).

I am unfamiliar with the general design decisions around OpenVPN's
interaction with the user =E2=80=94 I'm only trying to fix up the PKCS#11
support. But I think the management interface is *optional*.

> another issue is that most people running openvpn as root, hence
> smartcard interaction is performed using root, which is invalid, I
> recommend (and use) openvpn as non root process[2], in this method it
> is not required to run openvpn as daemon/background at all, and PIN
> entry is easier both when stdin/stdout are being used and when pin
> entry helper program is being used.

Users are seeing this particular issue even when OpenVPN is being run
in the foreground, and as non-root users. If I create a persistent tun
device and run as myself with --ifconfig-noexec, it still happens.

Perhaps one might argue this is simply a bug in OpenVPN =E2=80=94 it
*shouldn't* be spawning the systemd password request tool in that
case. And that's 100% true for the PIN request, since the pkcs11
-helper documentation explicitly forbids the application from forking
in the PIN callback.

> what we do require is to move the entire processing of remote
> connection details, certificate enumeration and private key operations
> into the management interface, removing the PKCS#11 support from
> openvpn core, and move it into the management implementation, hence
> will always run at the user context. We discussed that in the past,
> not sure if someone promoted it.

I think the management interface has been able to provide a
certificate for a while. It's recently also gained the ability to
perform the signing step too, so we really can offload it all now.

Persuading the OpenVPN developers that such should be the *only*
possible mode of operation, however, is a different prospect :0

> > Secondly, even if we work around that by disabling systemd support, we
> > find that the OpenSC PKCS#11 module doesn't cope. It ends up confusing
> > pcscd by interacting with it over two separate connections, as
> > described at http://sourceforge.net/p/opensc/mailman/message/34073754/
>=20
> this should be resolved by either OpenSC or pcscd (not sure where the
> problem is) to confirm with PKCS#11 spec.

Thanks for confirming that. I'll go back and resume that thread and
point the finger more squarely away from OpenVPN and pkcs11-helper :)

> > Third, the p11-kit-proxy.so module also doesn't cope, and suffers=20
> > an
> > internal deadlock as described at
> > https://www.mail-archive.com/p11
> > -glue@...2028.../msg00126.html
>=20
> again, if p11-kit-proxy violates the PKCS#11 spec it should be fixed.

Indeed. Thanks.

Although I do wonder how many other provider modules are going to
suffer similar issues, and it doesn't *hurt* to be defensive in
OpenVPN and use vfork() instead of fork(). I don't really see the down
-side.
=20
> NAK my side, openvpn code is ok.

Well, not quite. Even apart from the 'be liberal in what you accept'
principle as discussed above, the systemd_ask_password handling is
clearly broken. And actually further testing shows that part is *not*
fixed by my patch, since I only modified openvpn_execve(). We can't
use vfork() in openvpn_popen() because that does other things between
the fork and the execve().

So we end up with this deadlock...

#0  0x00007f26e64a52c0 in __nanosleep_nocancel () at ../sysdeps/unix/syscal=
l-template.S:81
#1  0x00007f26e64d5b14 in usleep (useconds=3D<optimized out>) at ../sysdeps=
/unix/sysv/linux/usleep.c:32
#2  0x00007f26e6ffb096 in _pkcs1h_threading_mutexLockAll () at pkcs11h-thre=
ading.c:306
#3  0x00007f26e64a5362 in __libc_fork () at ../sysdeps/nptl/fork.c:89
#4  0x00007f26e72224a5 in __fork () at pt-fork.c:25
#5  0x00007f26e8ff05e0 in openvpn_popen (a=3Da@...1851...=3D0x7ffdb20c87a0,=
 es=3Des@...1851...=3D0x0) at misc.c:373
#6  0x00007f26e8ff23fd in get_console_input_systemd (capacity=3D4096, input=
=3D0x7ffdb20c9972 "", echo=3D<optimized out>, prompt=3D0x7f26e9e95d88 "Ente=
r PIV_II (PIV Card Holder pin) token Password:") at console.c:172
#7  get_console_input (prompt=3D0x7f26e9e95d88 "Enter PIV_II (PIV Card Hold=
er pin) token Password:", echo=3Decho@...1851...=3Dfalse, input=3Dinput@...493...=
1851...=3D0x7ffdb20c9972 "", capacity=3Dcapacity@...1851...=3D4096) at cons=
ole.c:205
#8  0x00007f26e8fef7a8 in get_user_pass_cr (up=3Dup@...1851...=3D0x7ffdb20c=
8970, auth_file=3D<optimized out>, auth_file@...1851...=3D0x0, prefix=3Dpre=
fix@...1851...=3D0x7ffdb20ca980 "PIV_II (PIV Card Holder pin) token", flags=
=3Dflags@...1851...=3D21, auth_challenge=3Dauth_challenge@...1851...=3D0x0)=
 at misc.c:1146
#9  0x00007f26e8ffcfc8 in get_user_pass (flags=3D21, prefix=3D0x7ffdb20ca98=
0 "PIV_II (PIV Card Holder pin) token", auth_file=3D0x0, up=3D0x7ffdb20c897=
0) at misc.h:272
#10 _pkcs11_openvpn_pin_prompt (global_data=3D<optimized out>, user_data=3D=
<optimized out>, token=3D<optimized out>, retry=3D<optimized out>, pin=3D0x=
7ffdb20cadf0 "@\260\f\262\375\177", pin_max=3D1024) at pkcs11.c:235
#11 0x00007f26e6ffd0cb in _pkcs11h_session_login (session=3D0x7f26e9e41a30,=
 is_publicOnly=3Dis_publicOnly@...1851...=3D0, readonly=3Dreadonly@...2029...=
..=3D1, user_data=3D0x0, mask_prompt=3D<optimized out>) at pkcs11h-session.=
c:1023

--=20
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@...753...                              Intel Corporation

--=-IcKgw0ZcLQ/xMOLmEhm/
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
DxcNMTUwNTAxMjMzNzA2WjAjBgkqhkiG9w0BCQQxFgQU4A8/Ci5Ez2u0jbA1+ESkUlwl/S4wgaUG
CSsGAQQBgjcQBDGBlzCBlDCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4x
KzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMTL1N0
YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBAgMJ2TIwgacGCyqG
SIb3DQEJEAILMYGXoIGUMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjEr
MCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYGA1UEAxMvU3Rh
cnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0ECAwnZMjANBgkqhkiG
9w0BAQEFAASCAQDIi+11V4PnVoBelqmCuymY+Idc20OE7CImF3P3mIjr6fx2TyuwEZOf+7jgtiNZ
Q2Sl4YtL5+GcXYtwKlhdt9uVcvZQjioh28ksvu6YcOw22nDJK4gwemUlgM3jQ7ts989loXhOWtNX
+0efGif7w2OuFMl+mSyU3dmcYgR677G4htTUjWtrkBCEx3fd4XuvOgAZN6fPG7eIZY+ez6BBr1je
0buRSth+nLh027g7f1wM728aA8v/P3xBtrh4YuhYOZ43YIv/u1P2NS4+aOTGT46av6DQ+sLXbywf
XccOCwFp4HJrypKEvnWAnwDK7fOzAUhfvy4OirgTwoSIC5YfLl0AAAAAAAAA


--=-IcKgw0ZcLQ/xMOLmEhm/--


