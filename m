MIME-Version: 1.0
References: <CAM1xzG1X-iERU2ZXFS_m_VqCKOwjt_gD8oi0F8J5h38Xx+FQ9A@...278...>
 <CAKuzo_gXgqWSLhpvMhjTS+VfbWmQ8JXnHEiOVEPyPSOMCbPKcQ@...278...>
 <63b81ed6-dce7-94b8-0dd5-8864a8314ec6@...1147...>
In-Reply-To: <63b81ed6-dce7-94b8-0dd5-8864a8314ec6@...1147...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 10 Apr 2019 13:09:28 -0400
Message-ID: <CAKuzo_iikr28FJcXNMz+xSbkoqZAyutJ3cx5J5zBvnEnEEw5bw@...278...>
Content-Type: multipart/alternative; boundary="000000000000d476eb058630224a"
Subject: Re: [Openvpn-devel] Issue with smartcard authentication for openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Francois Gelis <francois.gelis@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000d476eb058630224a
Content-Type: text/plain; charset="UTF-8"

On Wed, Apr 10, 2019 at 12:59 PM Jan Just Keijser <janjust@...1147...> wrote:

> On 10/04/19 17:58, Selva Nair wrote:
>
> Hi,
>
> This is more relevant to OpenVPN than OpenSSL, so copying to the
> openvpn-devel list.
>
> On Wed, Apr 10, 2019 at 10:11 AM Francois Gelis <francois.gelis@...277...>
> wrote:
>
>> Hi all,
>>
>> I have a working openvpn setup with client certificate and private key
>> stored on my laptop. Then, I have loaded them into a smartcard (Yubico 5
>> NFC), and modified accordingly the openvpn client config. But running the
>> openvpn client now fails with an error that seems to originate inside
>> openssl. Here is a verbose openvpn log (only the portion that seems
>> relevant for this error, but I have the full log if useful):
>>
>> Sat Apr  6 15:57:20 2019 us=467260 Incoming Ciphertext -> TLS
>> Sat Apr  6 15:57:20 2019 us=467271 SSL state (connect): SSLv3/TLS read
>> server hello
>> Sat Apr  6 15:57:20 2019 us=467468 VERIFY OK: depth=1, CN=FG-CA
>> Sat Apr  6 15:57:20 2019 us=467598 VERIFY KU OK
>> Sat Apr  6 15:57:20 2019 us=467609 Validating certificate extended key
>> usage
>> Sat Apr  6 15:57:20 2019 us=467615 ++ Certificate has EKU (str) TLS Web
>> Server Authentication, expects TLS Web Server Authentication
>> Sat Apr  6 15:57:20 2019 us=467620 VERIFY EKU OK
>> Sat Apr  6 15:57:20 2019 us=467625 VERIFY OK: depth=0, CN=tx2
>> Sat Apr  6 15:57:20 2019 us=467650 SSL state (connect): SSLv3/TLS read
>> server certificate
>> Sat Apr  6 15:57:20 2019 us=467735 SSL state (connect): SSLv3/TLS read
>> server key exchange
>> Sat Apr  6 15:57:20 2019 us=467763 SSL state (connect): SSLv3/TLS read
>> server certificate request
>> Sat Apr  6 15:57:20 2019 us=467771 SSL state (connect): SSLv3/TLS read
>> server done
>> Sat Apr  6 15:57:20 2019 us=467845 SSL state (connect): SSLv3/TLS write
>> client certificate
>> Sat Apr  6 15:57:20 2019 us=468012 SSL state (connect): SSLv3/TLS write
>> client key exchange
>> Sat Apr  6 15:57:20 2019 us=468053 PKCS#11: __pkcs11h_openssl_rsa_enc
>> entered - flen=256, from=0x559d078d6e70, to=0x559d078d6bc0,
>> rsa=0x559d078b3630, padding=3
>> Sat Apr  6 15:57:20 2019 us=468060 PKCS#11: __pkcs11h_openssl_rsa_enc -
>> return rv=112-'CKR_MECHANISM_INVALID'
>> Sat Apr  6 15:57:20 2019 us=468070 SSL alert (write): fatal: internal
>> error
>> Sat Apr  6 15:57:20 2019 us=468085 OpenSSL: error:141F0006:SSL
>> routines:tls_construct_cert_verify:EVP lib
>> Sat Apr  6 15:57:20 2019 us=468092 TLS_ERROR: BIO read tls_read_plaintext
>> error
>> Sat Apr  6 15:57:20 2019 us=468097 TLS Error: TLS object -> incoming
>> plaintext read error
>> Sat Apr  6 15:57:20 2019 us=468101 TLS Error: TLS handshake failed
>>
>> Somehow, it seems that __pkcs11h_openssl_rsa_enc was called with an
>> unexpected padding. Any ideas on what might be the cause of this?
>>
>>
> As I replied to the openssl-users list[*], pkcs11-helper only supports
> PKCS1 signatures, not raw signature needed in this case.
>
> We have to either patch pkcs11-helper or switch to something else.
>
>
> patching pkcs11-helper does not seem too difficult for this particular
> case - but how can we test it? I have access to hw tokens but I don't know
> how to trigger the "raw signature" bit.
>

If both server and client are built with OpenSSL 1.1.1 and TLS version is
>= 1.2, PSS padding will get used and trigger this. OpenSSL does PSS
padding internally and passes the padded data to the rsa_priv_enc calback
for raw signature.

This is based on my tests for our Windows cryptoapi and
management-external-key patches for the same -- never tried this using
pkcs11-helper, but I expect the same behaviour.

Selva

--000000000000d476eb058630224a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 10, 2019 at 12:59 PM Jan =
Just Keijser &lt;<a href=3D"mailto:janjust@...1147..." target=3D"_blank">ja=
njust@...1147...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
=20=20
=20=20=20=20
=20=20
  <div bgcolor=3D"#FFFFFF">
    <div class=3D"m_1964221307044804475gmail-m_1867414188553678211moz-cite-=
prefix">On 10/04/19 17:58, Selva Nair wrote:<br>
    </div>
    <blockquote type=3D"cite">
=20=20=20=20=20=20
      <div dir=3D"ltr">
        <div dir=3D"ltr">
          <div>Hi,<br>
            <br>
          </div>
          This is more relevant to OpenVPN than OpenSSL, so copying to
          the openvpn-devel list.<br>
        </div>
        <br>
        <div class=3D"gmail_quote">
          <div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 10, 2019 at
            10:11 AM Francois Gelis &lt;<a href=3D"mailto:francois.gelis@...1186...=
.277..." target=3D"_blank">francois.gelis@...277...</a>&gt;
            wrote:<br>
          </div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div dir=3D"ltr">
              <div dir=3D"ltr">
                <div dir=3D"ltr">Hi all,
                  <div><br>
                  </div>
                  <div>I have a working openvpn setup with client
                    certificate and private key stored on my laptop.
                    Then, I have loaded them into a smartcard (Yubico 5
                    NFC), and modified accordingly the openvpn client
                    config. But running the openvpn client now fails
                    with an error that seems to originate inside
                    openssl. Here is a verbose openvpn log (only the
                    portion that seems relevant for this error, but I
                    have the full log if useful):</div>
                  <div><br>
                  </div>
                  <div>
                    <div>Sat Apr=C2=A0 6 15:57:20 2019 us=3D467260 Incoming
                      Ciphertext -&gt; TLS</div>
                    <div>Sat Apr=C2=A0 6 15:57:20 2019 us=3D467271 SSL state
                      (connect): SSLv3/TLS read server hello</div>
                    <div>Sat Apr=C2=A0 6 15:57:20 2019 us=3D467468 VERIFY O=
K:
                      depth=3D1, CN=3DFG-CA</div>
                    <div>Sat Apr=C2=A0 6 15:57:20 2019 us=3D467598 VERIFY K=
U OK</div>
                    <div>Sat Apr=C2=A0 6 15:57:20 2019 us=3D467609 Validati=
ng
                      certificate extended key usage</div>
                    <div>Sat Apr=C2=A0 6 15:57:20 2019 us=3D467615 ++
                      Certificate has EKU (str) TLS Web Server
                      Authentication, expects TLS Web Server
                      Authentication</div>
                    <div>Sat Apr=C2=A0 6 15:57:20 2019 us=3D467620 VERIFY E=
KU
                      OK</div>
                    <div>Sat Apr=C2=A0 6 15:57:20 2019 us=3D467625 VERIFY O=
K:
                      depth=3D0, CN=3Dtx2</div>
                    <div>Sat Apr=C2=A0 6 15:57:20 2019 us=3D467650 SSL state
                      (connect): SSLv3/TLS read server certificate</div>
                    <div>Sat Apr=C2=A0 6 15:57:20 2019 us=3D467735 SSL state
                      (connect): SSLv3/TLS read server key exchange</div>
                    <div>Sat Apr=C2=A0 6 15:57:20 2019 us=3D467763 SSL state
                      (connect): SSLv3/TLS read server certificate
                      request</div>
                    <div>Sat Apr=C2=A0 6 15:57:20 2019 us=3D467771 SSL state
                      (connect): SSLv3/TLS read server done</div>
                    <div>Sat Apr=C2=A0 6 15:57:20 2019 us=3D467845 SSL state
                      (connect): SSLv3/TLS write client certificate</div>
                    <div>Sat Apr=C2=A0 6 15:57:20 2019 us=3D468012 SSL state
                      (connect): SSLv3/TLS write client key exchange</div>
                    <div>Sat Apr=C2=A0 6 15:57:20 2019 us=3D468053 PKCS#11:
                      __pkcs11h_openssl_rsa_enc entered - flen=3D256,
                      from=3D0x559d078d6e70, to=3D0x559d078d6bc0,
                      rsa=3D0x559d078b3630, padding=3D3</div>
                    <div>Sat Apr=C2=A0 6 15:57:20 2019 us=3D468060 PKCS#11:
                      __pkcs11h_openssl_rsa_enc - return
                      rv=3D112-&#39;CKR_MECHANISM_INVALID&#39;</div>
                    <div>Sat Apr=C2=A0 6 15:57:20 2019 us=3D468070 SSL alert
                      (write): fatal: internal error</div>
                    <div>Sat Apr=C2=A0 6 15:57:20 2019 us=3D468085 OpenSSL:
                      error:141F0006:SSL
                      routines:tls_construct_cert_verify:EVP lib</div>
                    <div>Sat Apr=C2=A0 6 15:57:20 2019 us=3D468092 TLS_ERRO=
R:
                      BIO read tls_read_plaintext error</div>
                    <div>Sat Apr=C2=A0 6 15:57:20 2019 us=3D468097 TLS Erro=
r:
                      TLS object -&gt; incoming plaintext read error</div>
                    <div>Sat Apr=C2=A0 6 15:57:20 2019 us=3D468101 TLS Erro=
r:
                      TLS handshake failed<br>
                    </div>
                  </div>
                  <div><br>
                  </div>
                  <div>Somehow, it seems that=C2=A0__pkcs11h_openssl_rsa_enc
                    was called with an unexpected padding. Any ideas on
                    what might be the cause of this?</div>
                  <div><br>
                  </div>
                </div>
              </div>
            </div>
          </blockquote>
          <div><br>
          </div>
          <div>As I replied to the openssl-users list[*], pkcs11-helper
            only supports PKCS1 signatures, not raw signature needed in
            this case.<br>
          </div>
          <div><br>
            We have to either patch pkcs11-helper or switch to something
            else.<br>
            <br>
          </div>
          <br>
        </div>
      </div>
    </blockquote>
    patching pkcs11-helper does not seem too difficult for this
    particular case - but how can we test it? I have access to hw tokens
    but I don&#39;t know how to trigger the &quot;raw signature&quot; bit.<=
br></div></blockquote><div><br></div><div>If both server and client are bui=
lt with OpenSSL 1.1.1 and TLS version is &gt;=3D 1.2, PSS padding will get =
used and trigger this. OpenSSL does PSS padding internally and passes the p=
added data to the rsa_priv_enc calback for raw signature.<br><br></div><div=
>This is based on my tests for our Windows cryptoapi and management-externa=
l-key patches for the same -- never tried this using pkcs11-helper, but I e=
xpect the same behaviour.<br><br></div><div>Selva <br></div></div></div>

--000000000000d476eb058630224a--

