MIME-Version: 1.0
References: <CAM1xzG1X-iERU2ZXFS_m_VqCKOwjt_gD8oi0F8J5h38Xx+FQ9A@...278...>
In-Reply-To: <CAM1xzG1X-iERU2ZXFS_m_VqCKOwjt_gD8oi0F8J5h38Xx+FQ9A@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 10 Apr 2019 11:58:14 -0400
Message-ID: <CAKuzo_gXgqWSLhpvMhjTS+VfbWmQ8JXnHEiOVEPyPSOMCbPKcQ@...278...>
Content-Type: multipart/alternative; boundary="00000000000024a05005862f24e3"
Subject: Re: [Openvpn-devel] Issue with smartcard authentication for openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Francois Gelis <francois.gelis@...277...>, antiac@...277...
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000024a05005862f24e3
Content-Type: text/plain; charset="UTF-8"

Hi,

This is more relevant to OpenVPN than OpenSSL, so copying to the
openvpn-devel list.

On Wed, Apr 10, 2019 at 10:11 AM Francois Gelis <francois.gelis@...277...>
wrote:

> Hi all,
>
> I have a working openvpn setup with client certificate and private key
> stored on my laptop. Then, I have loaded them into a smartcard (Yubico 5
> NFC), and modified accordingly the openvpn client config. But running the
> openvpn client now fails with an error that seems to originate inside
> openssl. Here is a verbose openvpn log (only the portion that seems
> relevant for this error, but I have the full log if useful):
>
> Sat Apr  6 15:57:20 2019 us=467260 Incoming Ciphertext -> TLS
> Sat Apr  6 15:57:20 2019 us=467271 SSL state (connect): SSLv3/TLS read
> server hello
> Sat Apr  6 15:57:20 2019 us=467468 VERIFY OK: depth=1, CN=FG-CA
> Sat Apr  6 15:57:20 2019 us=467598 VERIFY KU OK
> Sat Apr  6 15:57:20 2019 us=467609 Validating certificate extended key
> usage
> Sat Apr  6 15:57:20 2019 us=467615 ++ Certificate has EKU (str) TLS Web
> Server Authentication, expects TLS Web Server Authentication
> Sat Apr  6 15:57:20 2019 us=467620 VERIFY EKU OK
> Sat Apr  6 15:57:20 2019 us=467625 VERIFY OK: depth=0, CN=tx2
> Sat Apr  6 15:57:20 2019 us=467650 SSL state (connect): SSLv3/TLS read
> server certificate
> Sat Apr  6 15:57:20 2019 us=467735 SSL state (connect): SSLv3/TLS read
> server key exchange
> Sat Apr  6 15:57:20 2019 us=467763 SSL state (connect): SSLv3/TLS read
> server certificate request
> Sat Apr  6 15:57:20 2019 us=467771 SSL state (connect): SSLv3/TLS read
> server done
> Sat Apr  6 15:57:20 2019 us=467845 SSL state (connect): SSLv3/TLS write
> client certificate
> Sat Apr  6 15:57:20 2019 us=468012 SSL state (connect): SSLv3/TLS write
> client key exchange
> Sat Apr  6 15:57:20 2019 us=468053 PKCS#11: __pkcs11h_openssl_rsa_enc
> entered - flen=256, from=0x559d078d6e70, to=0x559d078d6bc0,
> rsa=0x559d078b3630, padding=3
> Sat Apr  6 15:57:20 2019 us=468060 PKCS#11: __pkcs11h_openssl_rsa_enc -
> return rv=112-'CKR_MECHANISM_INVALID'
> Sat Apr  6 15:57:20 2019 us=468070 SSL alert (write): fatal: internal error
> Sat Apr  6 15:57:20 2019 us=468085 OpenSSL: error:141F0006:SSL
> routines:tls_construct_cert_verify:EVP lib
> Sat Apr  6 15:57:20 2019 us=468092 TLS_ERROR: BIO read tls_read_plaintext
> error
> Sat Apr  6 15:57:20 2019 us=468097 TLS Error: TLS object -> incoming
> plaintext read error
> Sat Apr  6 15:57:20 2019 us=468101 TLS Error: TLS handshake failed
>
> Somehow, it seems that __pkcs11h_openssl_rsa_enc was called with an
> unexpected padding. Any ideas on what might be the cause of this?
>
>
As I replied to the openssl-users list[*], pkcs11-helper only supports
PKCS1 signatures, not raw signature needed in this case.

We have to either patch pkcs11-helper or switch to something else.

Selva

[*] https://mta.openssl.org/pipermail/openssl-users/2019-April/010266.html

--00000000000024a05005862f24e3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi,<br><br></div>This is more releva=
nt to OpenVPN than OpenSSL, so copying to the openvpn-devel list.<br></div>=
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed=
, Apr 10, 2019 at 10:11 AM Francois Gelis &lt;<a href=3D"mailto:francois.ge=
lis@...277..." target=3D"_blank">francois.gelis@...277...</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><=
div dir=3D"ltr"><div dir=3D"ltr">Hi all,<div><br></div><div>I have a workin=
g openvpn setup with client certificate and private key stored on my laptop=
. Then, I have loaded them into a smartcard (Yubico 5 NFC), and modified ac=
cordingly the openvpn client config. But running the openvpn client now fai=
ls with an error that seems to originate inside openssl. Here is a verbose =
openvpn log (only the portion that seems relevant for this error, but I hav=
e the full log if useful):</div><div><br></div><div><div>Sat Apr=C2=A0 6 15=
:57:20 2019 us=3D467260 Incoming Ciphertext -&gt; TLS</div><div>Sat Apr=C2=
=A0 6 15:57:20 2019 us=3D467271 SSL state (connect): SSLv3/TLS read server =
hello</div><div>Sat Apr=C2=A0 6 15:57:20 2019 us=3D467468 VERIFY OK: depth=
=3D1, CN=3DFG-CA</div><div>Sat Apr=C2=A0 6 15:57:20 2019 us=3D467598 VERIFY=
 KU OK</div><div>Sat Apr=C2=A0 6 15:57:20 2019 us=3D467609 Validating certi=
ficate extended key usage</div><div>Sat Apr=C2=A0 6 15:57:20 2019 us=3D4676=
15 ++ Certificate has EKU (str) TLS Web Server Authentication, expects TLS =
Web Server Authentication</div><div>Sat Apr=C2=A0 6 15:57:20 2019 us=3D4676=
20 VERIFY EKU OK</div><div>Sat Apr=C2=A0 6 15:57:20 2019 us=3D467625 VERIFY=
 OK: depth=3D0, CN=3Dtx2</div><div>Sat Apr=C2=A0 6 15:57:20 2019 us=3D46765=
0 SSL state (connect): SSLv3/TLS read server certificate</div><div>Sat Apr=
=C2=A0 6 15:57:20 2019 us=3D467735 SSL state (connect): SSLv3/TLS read serv=
er key exchange</div><div>Sat Apr=C2=A0 6 15:57:20 2019 us=3D467763 SSL sta=
te (connect): SSLv3/TLS read server certificate request</div><div>Sat Apr=
=C2=A0 6 15:57:20 2019 us=3D467771 SSL state (connect): SSLv3/TLS read serv=
er done</div><div>Sat Apr=C2=A0 6 15:57:20 2019 us=3D467845 SSL state (conn=
ect): SSLv3/TLS write client certificate</div><div>Sat Apr=C2=A0 6 15:57:20=
 2019 us=3D468012 SSL state (connect): SSLv3/TLS write client key exchange<=
/div><div>Sat Apr=C2=A0 6 15:57:20 2019 us=3D468053 PKCS#11: __pkcs11h_open=
ssl_rsa_enc entered - flen=3D256, from=3D0x559d078d6e70, to=3D0x559d078d6bc=
0, rsa=3D0x559d078b3630, padding=3D3</div><div>Sat Apr=C2=A0 6 15:57:20 201=
9 us=3D468060 PKCS#11: __pkcs11h_openssl_rsa_enc - return rv=3D112-&#39;CKR=
_MECHANISM_INVALID&#39;</div><div>Sat Apr=C2=A0 6 15:57:20 2019 us=3D468070=
 SSL alert (write): fatal: internal error</div><div>Sat Apr=C2=A0 6 15:57:2=
0 2019 us=3D468085 OpenSSL: error:141F0006:SSL routines:tls_construct_cert_=
verify:EVP lib</div><div>Sat Apr=C2=A0 6 15:57:20 2019 us=3D468092 TLS_ERRO=
R: BIO read tls_read_plaintext error</div><div>Sat Apr=C2=A0 6 15:57:20 201=
9 us=3D468097 TLS Error: TLS object -&gt; incoming plaintext read error</di=
v><div>Sat Apr=C2=A0 6 15:57:20 2019 us=3D468101 TLS Error: TLS handshake f=
ailed<br></div></div><div><br></div><div>Somehow, it seems that=C2=A0__pkcs=
11h_openssl_rsa_enc was called with an unexpected padding. Any ideas on wha=
t might be the cause of this?</div><div><br></div></div></div></div></block=
quote><div><br></div><div>As I replied to the openssl-users list[*], pkcs11=
-helper only supports PKCS1 signatures, not raw signature needed in this ca=
se.<br></div><div><br>We have to either patch pkcs11-helper or switch to so=
mething else.<br><br></div><div>Selva<br><br></div><div>[*] <a href=3D"http=
s://mta.openssl.org/pipermail/openssl-users/2019-April/010266.html">https:/=
/mta.openssl.org/pipermail/openssl-users/2019-April/010266.html</a><br></di=
v></div></div>

--00000000000024a05005862f24e3--

