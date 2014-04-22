Message-ID: <53565DCE.2000608@...1901...>
Date: Tue, 22 Apr 2014 08:17:18 -0400
From: Timothe Litt <litt@...1901...>
MIME-Version: 1.0
References: <mailman.123335.1398139175.2178.openvpn-devel@lists.sourceforge.net>
In-Reply-To: <mailman.123335.1398139175.2178.openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
	micalg=sha1; boundary="------------ms090506060207040602020606"
Subject: Re: [Openvpn-devel] tls-version-min in Openvpn-devel Digest, Vol 95,
	Issue 27
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a cryptographically signed message in MIME format.

--------------ms090506060207040602020606
Content-Type: multipart/alternative;
	boundary="------------020007070903010904070008"

This is a multi-part message in MIME format.
--------------020007070903010904070008
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 21-Apr-14 23:59, openvpn-devel-request@lists.sourceforge.net wrote:
> Message: 4 Date: Mon, 21 Apr 2014 13:49:46 +0200 From: Gert Doering=20
> <gert@...1296...> Subject: Re: [Openvpn-devel] [PATCH 4/4] When=20
> tls-version-min is unspecified, revert to original versioning=20
> approach. To: Arne Schwabe <arne@...1227...> Cc:=20
> openvpn-devel@lists.sourceforge.net Message-ID:=20
> <20140421114946.GV16637@...1296...> Content-Type: text/plain;=20
> charset=3D"us-ascii" Hi, On Mon, Apr 21, 2014 at 01:11:05PM +0200, Arne=20
> Schwabe wrote:
>> >Yes. But with this patch it is always turned off, keeping OpenVPN in 99%
>> >of installations in TLS 1.0. Is there any other known case where it
>> >breaks aside from the Tomato OpenVPN client?
> http://community.openvpn.net/openvpn/ticket/385
>
> this is the only case I know - and I blaim the openssl library on the
> server side (ARM).  So for me, "default-on with a way to turn it off" wou=
ld
> be sufficient.  But I assume James has much more visibility...
>
> gert
>
> -- USENET is *not* the non-clickable part of WWW! //www.muc.de/~gert/=20
> Gert Doering - Munich, Germany gert@...1296... fax:=20
> +49-89-35655025 gert@...1297...
FYI, I reported this in Trac #385.

On OpenVPN users today, there was a report of (superficially) the same=20
symptom on linux x86_64; I pointed the reporter to the thread and asked=20
for some more details.  If truly the same problem, it would rule out the=20
'ARM -only' theory.

I have built the ARM OpenSSL library for my distribution (Debian - as=20
patched by them) from source, and when I get a chance will see if I can=20
get any closer to root cause with GDB.  I'm not an OpenSSL internals=20
expert, but it's just code.  We'll see.

Note that my work-around (in #385) is a lot less intrusive than the=20
disabling patches that have been posted here recently; at least in my=20
case all that's required is to change the SSL_CTX_new init method to TLSv1.

Also, the server is trying to send a plaintext error message, but the=20
length is apparently wrong as seen by the client.  It would be helpful=20
if we could get the server to log the actual error..

Here is my current work-around (same as posted on trac)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 0b63e26..0785ce4 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -98,10 +98,10 @@ tls_ctx_server_new(struct tls_root_ctx *ctx)
  {
    ASSERT(NULL !=3D ctx);

-  ctx->ctx =3D SSL_CTX_new (SSLv23_server_method ());
+  ctx->ctx =3D SSL_CTX_new (TLSv1_server_method ());

    if (ctx->ctx =3D=3D NULL)
-    msg (M_SSLERR, "SSL_CTX_new SSLv23_server_method");
+    msg (M_SSLERR, "SSL_CTX_new TLSv1_server_method");
  }

  void
@@ -109,10 +109,10 @@ tls_ctx_client_new(struct tls_root_ctx *ctx)
  {
    ASSERT(NULL !=3D ctx);

-  ctx->ctx =3D SSL_CTX_new (SSLv23_client_method ());
+  ctx->ctx =3D SSL_CTX_new (TLSv1_client_method ());

    if (ctx->ctx =3D=3D NULL)
-    msg (M_SSLERR, "SSL_CTX_new SSLv23_client_method");
+    msg (M_SSLERR, "SSL_CTX_new TLSv1_client_method");
  }

  void



Timothe Litt
ACM Distinguished Engineer
--------------------------
This communication may not represent the ACM or my employer's views,
if any, on the matters discussed.

This communication may not represent my employer's views,
if any, on the matters discussed.



--------------020007070903010904070008
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3DISO-8859-1"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <div class=3D"moz-cite-prefix">On 21-Apr-14 23:59,
      <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:openvpn-devel-re=
quest@lists.sourceforge.net">openvpn-devel-request@lists.sourceforge.net</a=
> wrote:<br>
    </div>
    <blockquote
cite=3D"mid:mailman.123335.1398139175.2178.openvpn-devel@...290...=
net"
      type=3D"cite">
      <pre wrap=3D""><div class=3D"moz-txt-sig">Message: 4
Date: Mon, 21 Apr 2014 13:49:46 +0200
From: Gert Doering <a moz-do-not-send=3D"true" class=3D"moz-txt-link-rfc239=
6E" href=3D"mailto:gert@...1296...">&lt;gert@...1296...&gt;</a>
Subject: Re: [Openvpn-devel] [PATCH 4/4] When tls-version-min is
	unspecified,	revert to original versioning approach.
To: Arne Schwabe <a moz-do-not-send=3D"true" class=3D"moz-txt-link-rfc2396E=
" href=3D"mailto:arne@...1227...">&lt;arne@...1227...&gt;</a>
Cc: <a moz-do-not-send=3D"true" class=3D"moz-txt-link-abbreviated" href=3D"=
mailto:openvpn-devel@lists.sourceforge.net">openvpn-devel@...282...=
.net</a>
Message-ID: <a moz-do-not-send=3D"true" class=3D"moz-txt-link-rfc2396E" hre=
f=3D"mailto:20140421114946.GV16637@...1296...">&lt;20140421114946.GV16637@...220...=
..1296...&gt;</a>
Content-Type: text/plain; charset=3D"us-ascii"

Hi,

On Mon, Apr 21, 2014 at 01:11:05PM +0200, Arne Schwabe wrote:
</div></pre>
      <blockquote type=3D"cite" style=3D"color: #000000;">
        <pre wrap=3D""><span class=3D"moz-txt-citetags">&gt; </span>Yes. Bu=
t with this patch it is always turned off, keeping OpenVPN in 99%=20
<span class=3D"moz-txt-citetags">&gt; </span>of installations in TLS 1.0. I=
s there any other known case where it=20
<span class=3D"moz-txt-citetags">&gt; </span>breaks aside from the Tomato O=
penVPN client?
</pre>
      </blockquote>
      <pre wrap=3D""><a moz-do-not-send=3D"true" class=3D"moz-txt-link-free=
text" href=3D"http://community.openvpn.net/openvpn/ticket/385">http://commu=
nity.openvpn.net/openvpn/ticket/385</a>

this is the only case I know - and I blaim the openssl library on the
server side (ARM).  So for me, "default-on with a way to turn it off" would
be sufficient.  But I assume James has much more visibility...

gert

<div class=3D"moz-txt-sig">--=20
USENET is <b class=3D"moz-txt-star"><span class=3D"moz-txt-tag">*</span>not=
<span class=3D"moz-txt-tag">*</span></b> the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             <a moz-do-not-se=
nd=3D"true" class=3D"moz-txt-link-abbreviated" href=3D"mailto:gert@...1725...=
..">gert@...1296...</a>
fax: +49-89-35655025                        <a moz-do-not-send=3D"true" cla=
ss=3D"moz-txt-link-abbreviated" href=3D"mailto:gert@...1297...">gert@...1826...=
7...</a>
</div></pre>
    </blockquote>
    FYI, I reported this in Trac #385.&nbsp; <br>
    <br>
    On OpenVPN users today, there was a report of (superficially) the
    same symptom on linux x86_64; I pointed the reporter to the thread
    and asked for some more details.&nbsp; If truly the same problem, it
    would rule out the 'ARM -only' theory.<br>
    <br>
    I have built the ARM OpenSSL library for my distribution (Debian -
    as patched by them) from source, and when I get a chance will see if
    I can get any closer to root cause with GDB.&nbsp; I'm not an OpenSSL
    internals expert, but it's just code.&nbsp; We'll see.<br>
    <br>
    Note that my work-around (in #385) is a lot less intrusive than the
    disabling patches that have been posted here recently; at least in
    my case all that's required is to change the SSL_CTX_new init method
    to TLSv1.<br>
    <br>
    Also, the server is trying to send a plaintext error message, but
    the length is apparently wrong as seen by the client.&nbsp; It would be
    helpful if we could get the server to log the actual error..<br>
    <br>
    Here is my current work-around (same as posted on trac)<br>
    <br>
    <pre class=3D"wiki">diff --git a/src/openvpn/ssl_openssl.c b/src/openvp=
n/ssl_openssl.c
index 0b63e26..0785ce4 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -98,10 +98,10 @@ tls_ctx_server_new(struct tls_root_ctx *ctx)
 {
   ASSERT(NULL !=3D ctx);

-  ctx-&gt;ctx =3D SSL_CTX_new (SSLv23_server_method ());
+  ctx-&gt;ctx =3D SSL_CTX_new (TLSv1_server_method ());

   if (ctx-&gt;ctx =3D=3D NULL)
-    msg (M_SSLERR, "SSL_CTX_new SSLv23_server_method");
+    msg (M_SSLERR, "SSL_CTX_new TLSv1_server_method");
 }

 void
@@ -109,10 +109,10 @@ tls_ctx_client_new(struct tls_root_ctx *ctx)
 {
   ASSERT(NULL !=3D ctx);

-  ctx-&gt;ctx =3D SSL_CTX_new (SSLv23_client_method ());
+  ctx-&gt;ctx =3D SSL_CTX_new (TLSv1_client_method ());

   if (ctx-&gt;ctx =3D=3D NULL)
-    msg (M_SSLERR, "SSL_CTX_new SSLv23_client_method");
+    msg (M_SSLERR, "SSL_CTX_new TLSv1_client_method");
 }

 void
</pre>
    <br>
    <br>
    <pre class=3D"moz-signature" cols=3D"72">Timothe Litt
ACM Distinguished Engineer
--------------------------
This communication may not represent the ACM or my employer's views,
if any, on the matters discussed.=20
</pre>
    <pre class=3D"moz-signature" cols=3D"72">This communication may not rep=
resent my employer's views,
if any, on the matters discussed. </pre>
    <br>
  </body>
</html>

--------------020007070903010904070008--

--------------ms090506060207040602020606
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIPDzCC
BjQwggQcoAMCAQICASAwDQYJKoZIhvcNAQEFBQAwfTELMAkGA1UEBhMCSUwxFjAUBgNVBAoT
DVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNp
Z25pbmcxKTAnBgNVBAMTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTA3
MTAyNDIxMDI1NVoXDTE3MTAyNDIxMDI1NVowgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1T
dGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWdu
aW5nMTgwNgYDVQQDEy9TdGFydENvbSBDbGFzcyAyIFByaW1hcnkgSW50ZXJtZWRpYXRlIENs
aWVudCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMsohUWcASz7GfKrpTOM
KqANy9BV7V0igWdGxA8IU77L3aTxErQ+fcxtDYZ36Z6GH0YFn7fq5RADteP0AYzrCA+EQTfi
8q1+kA3m0nwtwXG94M5sIqsvs7lRP1aycBke/s5g9hJHryZ2acScnzczjBCAo7X1v5G3yw8M
DP2m2RCye0KfgZ4nODerZJVzhAlOD9YejvAXZqHksw56HzElVIoYSZ3q4+RJuPXXfIoyby+Y
2m1E+YzX5iCZXBx05gk6MKAW1vaw4/v2OOLy6FZH3XHHtOkzUreG//CsFnB9+uaYSlR65cdG
zTsmoIK8WH1ygoXhRBm98SD7Hf/r3FELNvUCAwEAAaOCAa0wggGpMA8GA1UdEwEB/wQFMAMB
Af8wDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBSuVYNv7DHKufcd+q9rMfPIHeOsuzAfBgNV
HSMEGDAWgBROC+8apEBbpRdphzDKNGhD0EGu8jBmBggrBgEFBQcBAQRaMFgwJwYIKwYBBQUH
MAGGG2h0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbS9jYTAtBggrBgEFBQcwAoYhaHR0cDovL3d3
dy5zdGFydHNzbC5jb20vc2ZzY2EuY3J0MFsGA1UdHwRUMFIwJ6AloCOGIWh0dHA6Ly93d3cu
c3RhcnRzc2wuY29tL3Nmc2NhLmNybDAnoCWgI4YhaHR0cDovL2NybC5zdGFydHNzbC5jb20v
c2ZzY2EuY3JsMIGABgNVHSAEeTB3MHUGCysGAQQBgbU3AQIBMGYwLgYIKwYBBQUHAgEWImh0
dHA6Ly93d3cuc3RhcnRzc2wuY29tL3BvbGljeS5wZGYwNAYIKwYBBQUHAgEWKGh0dHA6Ly93
d3cuc3RhcnRzc2wuY29tL2ludGVybWVkaWF0ZS5wZGYwDQYJKoZIhvcNAQEFBQADggIBADqp
Jw3I07QWke9plNBpxUxcffc7nUrIQpJHDci91DFG7fVhHRkMZ1J+BKg5UNUxIFJ2Z9B90Mic
c/NXcs7kPBRdn6XGO/vPc87Y6R+cWS9Nc9+fp3Enmsm94OxOwI9wn8qnr/6o3mD4noP9Jphw
UPTXwHovjavRnhUQHLfo/i2NG0XXgTHXS2Xm0kVUozXqpYpAdumMiB/vezj1QHQJDmUdPYMc
p+reg9901zkyT3fDW/ivJVv6pWtkh6Pw2ytZT7mvg7YhX3V50Nv860cV11mocUVcqBLv0gcT
+HBDYtbuvexNftwNQKD5193A7zN4vG7CTYkXxytSjKuXrpEatEiFPxWgb84nVj25SU5q/r1X
hwby6mLhkbaXslkVtwEWT3Van49rKjlK4XrUKYYWtnfzq6aSak5u0Vpxd1rY79tWhD3EdCvO
hNz/QplNa+VkIsrcp7+8ZhP1l1b2U6MaxIVteuVMD3X0vziIwr7jxYae9FZjbxlpUemqXjcC
0QaFfN7qI0JsQMALL7iGRBg7K0CoOBzECdD3fuZil5kU/LP9cr1BK31U0Uy651bFnAMMMkqh
AChIbn0ei72VnbpSsrrSdF0BAGYQ8vyHae5aCg+H75dVCV33K6FuxZrf09yTz+Vx/PkdRUYk
XmZz/OTfyJXsUOUXrym6KvI2rYpccSk5MIII0zCCB7ugAwIBAgICJtUwDQYJKoZIhvcNAQEF
BQAwgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJT
ZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgwNgYDVQQDEy9TdGFydENvbSBD
bGFzcyAyIFByaW1hcnkgSW50ZXJtZWRpYXRlIENsaWVudCBDQTAeFw0xMjA5MjUxODQyMTha
Fw0xNDA5MjcxOTIyNDJaMIGQMRkwFwYDVQQNExBPZ3RBNVhZZXZheGFkbGtKMQswCQYDVQQG
EwJVUzEWMBQGA1UECBMNTWFzc2FjaHVzZXR0czEVMBMGA1UEBxMMU291dGhib3JvdWdoMRUw
EwYDVQQDEwxUaW1vdGhlIExpdHQxIDAeBgkqhkiG9w0BCQEWEXRpbW90aGVAbGl0dHMubmV0
MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA38JrSHJ7GVdQiTppuafIBrhphuLL
HAmpeAFNvUBuUUh4X8Nx4Ag03hrC/B7OWYpUJI1HgWCK/eMtKEWF7UMwFhkMeqWSdrZyb4uk
EqTf46SyyAghF6BGuuVTiptED63FwzQY2PTXCmAJviuRXoJMzlhAwzUFpsWTFhswigFLrMCn
kJ9nndqnxQmMFpD7pjJ6kFkxKz/5k1CEzAfSerWHkIOBuXFyYpDDgDFXN1+qF25HsVVw+4xT
1/tNvCEVQ9WAleUznLvWgT5sV8tTewsUiYOgSqyoHiuJCOc9YJF2pUHGZVV+WzS8YIb95ax5
5yoS+C3D3FFzl6CbcI3nc6csqkP4bNBqm96Z/WdfTV4ouoycI4N9AJ86l6/Ygjz3/juFI9ni
as8nE051hksnyCon87fyP3/NezZ9NcUYVUnki1cVhfh2cN+s79fGWbUJePjT0fmso0FVcSRp
ddLyeZladbifFG+TiQO9BFt97e16OwyFpXRIzZWnfEiG2ss51Vpv9au8RrLgBD07aKE3mzZp
xZzoZ8c/jgb1YcUyAyaVmdOk4A3eGe7c8Loa+eYIRwkbjoE6H/PKcoRNIqnYQ44zvOOONRDI
S3vBpzofVK5Ndx0NVDIvsbWEPb9ntR32taUUZ334SPN447UO3sjvItFg1oOuC1i6kL6l1vRM
GNouPvECAwEAAaOCBDcwggQzMAkGA1UdEwQCMAAwCwYDVR0PBAQDAgSwMB0GA1UdJQQWMBQG
CCsGAQUFBwMCBggrBgEFBQcDBDAdBgNVHQ4EFgQUJZNwH8x9MtxbZmI9AK6Jj+IELcowHwYD
VR0jBBgwFoAUrlWDb+wxyrn3HfqvazHzyB3jrLswgaYGA1UdEQSBnjCBm4ERdGltb3RoZUBs
aXR0cy5uZXSBEXRpbW90aGVAbGl0dHMubmV0gQxsaXR0QGFjbS5vcmeBDWxpdHRAaWVlZS5v
cmeBFGhvc3RtYXN0ZXJAbGl0dHMubmV0gRdsaXR0c25ldGFkbWluQGxpdHRzLm5ldIETd2lr
aWFkbWluQGxpdHRzLm5ldIESc2VjdXJpdHlAbGl0dHMubmV0MIICIQYDVR0gBIICGDCCAhQw
ggIQBgsrBgEEAYG1NwECAjCCAf8wLgYIKwYBBQUHAgEWImh0dHA6Ly93d3cuc3RhcnRzc2wu
Y29tL3BvbGljeS5wZGYwNAYIKwYBBQUHAgEWKGh0dHA6Ly93d3cuc3RhcnRzc2wuY29tL2lu
dGVybWVkaWF0ZS5wZGYwgfcGCCsGAQUFBwICMIHqMCcWIFN0YXJ0Q29tIENlcnRpZmljYXRp
b24gQXV0aG9yaXR5MAMCAQEagb5UaGlzIGNlcnRpZmljYXRlIHdhcyBpc3N1ZWQgYWNjb3Jk
aW5nIHRvIHRoZSBDbGFzcyAyIFZhbGlkYXRpb24gcmVxdWlyZW1lbnRzIG9mIHRoZSBTdGFy
dENvbSBDQSBwb2xpY3ksIHJlbGlhbmNlIG9ubHkgZm9yIHRoZSBpbnRlbmRlZCBwdXJwb3Nl
IGluIGNvbXBsaWFuY2Ugb2YgdGhlIHJlbHlpbmcgcGFydHkgb2JsaWdhdGlvbnMuMIGcBggr
BgEFBQcCAjCBjzAnFiBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTADAgECGmRM
aWFiaWxpdHkgYW5kIHdhcnJhbnRpZXMgYXJlIGxpbWl0ZWQhIFNlZSBzZWN0aW9uICJMZWdh
bCBhbmQgTGltaXRhdGlvbnMiIG9mIHRoZSBTdGFydENvbSBDQSBwb2xpY3kuMDYGA1UdHwQv
MC0wK6ApoCeGJWh0dHA6Ly9jcmwuc3RhcnRzc2wuY29tL2NydHUyLWNybC5jcmwwgY4GCCsG
AQUFBwEBBIGBMH8wOQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbS9zdWIv
Y2xhc3MyL2NsaWVudC9jYTBCBggrBgEFBQcwAoY2aHR0cDovL2FpYS5zdGFydHNzbC5jb20v
Y2VydHMvc3ViLmNsYXNzMi5jbGllbnQuY2EuY3J0MCMGA1UdEgQcMBqGGGh0dHA6Ly93d3cu
c3RhcnRzc2wuY29tLzANBgkqhkiG9w0BAQUFAAOCAQEAXJ5dj2hKDwAh3aPsYWSJdC6PE7O2
u4pZz4H1mucRf3ZLoLjrAMhtINAqrWkvfiOTWQruNpQAXL+Gb6pk5sDoSXwISbPraVMb4uCS
g++F/XTCvqfsCitXd6Jhl5dyV0pi2MwmHyrBsjsER1EwA+39av+cfoL0gKuJy5y92wRt0It8
Eu77N5HaMlDlxEXXTQWP5Q2g7IZy+/ZeeG8FjrUM/bmwyvdb3mBreKgL2mZHnG+mf09IDACG
9ogoV2xJNQ0lRHxH5NJ/XGSztQACboxl3wK/t86Vhh6i1JeaLMcJ5oaemxdATK0NZVk/hIK0
hXGzTMVw1xoP/9LSYyoRD6yypzGCBNowggTWAgEBMIGTMIGMMQswCQYDVQQGEwJJTDEWMBQG
A1UEChMNU3RhcnRDb20gTHRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNh
dGUgU2lnbmluZzE4MDYGA1UEAxMvU3RhcnRDb20gQ2xhc3MgMiBQcmltYXJ5IEludGVybWVk
aWF0ZSBDbGllbnQgQ0ECAibVMAkGBSsOAwIaBQCgggIbMBgGCSqGSIb3DQEJAzELBgkqhkiG
9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE0MDQyMjEyMTcxOFowIwYJKoZIhvcNAQkEMRYEFCMs
+reMgzOkMWlOwFnwfuh6GeQ8MGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYF
Kw4DAgcwDQYIKoZIhvcNAwICASgwgaQGCSsGAQQBgjcQBDGBljCBkzCBjDELMAkGA1UEBhMC
SUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENl
cnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDIgUHJpbWFyeSBJ
bnRlcm1lZGlhdGUgQ2xpZW50IENBAgIm1TCBpgYLKoZIhvcNAQkQAgsxgZaggZMwgYwxCzAJ
BgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGln
aXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgwNgYDVQQDEy9TdGFydENvbSBDbGFzcyAyIFBy
aW1hcnkgSW50ZXJtZWRpYXRlIENsaWVudCBDQQICJtUwDQYJKoZIhvcNAQEBBQAEggIAsry7
HD/r+2ehJqS8fxHH0+nZ8l1DQn3Bqhpb65ACDod2xtyvZ12K7rc8lVXWsz5h69Hsa/bDkpU2
DXXOOpvXRguO5MGlpqHifAvBhffFADvnrNeajl5eMCmULU9FInIUD0DURasY9SOvon0tAbdZ
zjZSsDUpD4gCzZJ1I1I7LcEKVWESSniZoxrhA5sbezZlK9LQg5vyFZHRv+Elyftm86igasM7
8uhVfnasbICcpw2Y8VFwAjOIu9IWZ7jEqosBJzUfkM2BFNDWy2BscKXDgnrz2Yx0V/c4Shfl
2bVVLlDzEEdAGqGItW0eKP7cA85zlvdfyN5Ry287NAEHV/xJt3WT/0v5vwqxAY4PI+gf1n5x
b/tgYKDaq1dZYFSaRq/bu8qYVkAmlhUWpHEeMf59sk+mwaa7o76CrP/HqOlUHdNOukMC69EE
ZBqPmX9oUVvAbfNm0lyiL+GU8XF88lmr/Et/eJLMoUhO7m75I6LKB6QyoSkhfj9rDMT862xu
CvpHths2AXMoKskdPktIsZ6Abo55K4hWzPIZ2ePxGMTqzu0fKASF3qjMIqEdMbLo6ojxGdXp
P9zWhFkmNq5cIBwzPqkS7FeUnuLGrorT/onkyFYSt6YZVoifBrrkfcMfR1Ow7GEa23y0a+Tg
uLBwBVbNQiCQu+iwGqEz0R/NAm1zyKUAAAAAAAA=
--------------ms090506060207040602020606--

