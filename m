References: <CAM1xzG1X-iERU2ZXFS_m_VqCKOwjt_gD8oi0F8J5h38Xx+FQ9A@...278...>
 <CAKuzo_gXgqWSLhpvMhjTS+VfbWmQ8JXnHEiOVEPyPSOMCbPKcQ@...278...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <63b81ed6-dce7-94b8-0dd5-8864a8314ec6@...1147...>
Date: Wed, 10 Apr 2019 18:58:40 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_gXgqWSLhpvMhjTS+VfbWmQ8JXnHEiOVEPyPSOMCbPKcQ@...278...>
Content-Type: multipart/alternative;
 boundary="------------118E23B7A5BD0C7C21910827"
Content-Language: nl-NL
Subject: Re: [Openvpn-devel] Issue with smartcard authentication for openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, Francois Gelis <francois.gelis@...277...>, antiac@...277...
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------118E23B7A5BD0C7C21910827
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

On 10/04/19 17:58, Selva Nair wrote:
> Hi,
>
> This is more relevant to OpenVPN than OpenSSL, so copying to the 
> openvpn-devel list.
>
> On Wed, Apr 10, 2019 at 10:11 AM Francois Gelis 
> <francois.gelis@...277... <mailto:francois.gelis@...277...>> wrote:
>
>     Hi all,
>
>     I have a working openvpn setup with client certificate and private
>     key stored on my laptop. Then, I have loaded them into a smartcard
>     (Yubico 5 NFC), and modified accordingly the openvpn client
>     config. But running the openvpn client now fails with an error
>     that seems to originate inside openssl. Here is a verbose openvpn
>     log (only the portion that seems relevant for this error, but I
>     have the full log if useful):
>
>     Sat Apr  6 15:57:20 2019 us=467260 Incoming Ciphertext -> TLS
>     Sat Apr  6 15:57:20 2019 us=467271 SSL state (connect): SSLv3/TLS
>     read server hello
>     Sat Apr  6 15:57:20 2019 us=467468 VERIFY OK: depth=1, CN=FG-CA
>     Sat Apr  6 15:57:20 2019 us=467598 VERIFY KU OK
>     Sat Apr  6 15:57:20 2019 us=467609 Validating certificate extended
>     key usage
>     Sat Apr  6 15:57:20 2019 us=467615 ++ Certificate has EKU (str)
>     TLS Web Server Authentication, expects TLS Web Server Authentication
>     Sat Apr  6 15:57:20 2019 us=467620 VERIFY EKU OK
>     Sat Apr  6 15:57:20 2019 us=467625 VERIFY OK: depth=0, CN=tx2
>     Sat Apr  6 15:57:20 2019 us=467650 SSL state (connect): SSLv3/TLS
>     read server certificate
>     Sat Apr  6 15:57:20 2019 us=467735 SSL state (connect): SSLv3/TLS
>     read server key exchange
>     Sat Apr  6 15:57:20 2019 us=467763 SSL state (connect): SSLv3/TLS
>     read server certificate request
>     Sat Apr  6 15:57:20 2019 us=467771 SSL state (connect): SSLv3/TLS
>     read server done
>     Sat Apr  6 15:57:20 2019 us=467845 SSL state (connect): SSLv3/TLS
>     write client certificate
>     Sat Apr  6 15:57:20 2019 us=468012 SSL state (connect): SSLv3/TLS
>     write client key exchange
>     Sat Apr  6 15:57:20 2019 us=468053 PKCS#11:
>     __pkcs11h_openssl_rsa_enc entered - flen=256, from=0x559d078d6e70,
>     to=0x559d078d6bc0, rsa=0x559d078b3630, padding=3
>     Sat Apr  6 15:57:20 2019 us=468060 PKCS#11:
>     __pkcs11h_openssl_rsa_enc - return rv=112-'CKR_MECHANISM_INVALID'
>     Sat Apr  6 15:57:20 2019 us=468070 SSL alert (write): fatal:
>     internal error
>     Sat Apr  6 15:57:20 2019 us=468085 OpenSSL: error:141F0006:SSL
>     routines:tls_construct_cert_verify:EVP lib
>     Sat Apr  6 15:57:20 2019 us=468092 TLS_ERROR: BIO read
>     tls_read_plaintext error
>     Sat Apr  6 15:57:20 2019 us=468097 TLS Error: TLS object ->
>     incoming plaintext read error
>     Sat Apr  6 15:57:20 2019 us=468101 TLS Error: TLS handshake failed
>
>     Somehow, it seems that __pkcs11h_openssl_rsa_enc was called with
>     an unexpected padding. Any ideas on what might be the cause of this?
>
>
> As I replied to the openssl-users list[*], pkcs11-helper only supports 
> PKCS1 signatures, not raw signature needed in this case.
>
> We have to either patch pkcs11-helper or switch to something else.
>
>
patching pkcs11-helper does not seem too difficult for this particular 
case - but how can we test it? I have access to hw tokens but I don't 
know how to trigger the "raw signature" bit.

JJK


--------------118E23B7A5BD0C7C21910827
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">On 10/04/19 17:58, Selva Nair wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAKuzo_gXgqWSLhpvMhjTS+VfbWmQ8JXnHEiOVEPyPSOMCbPKcQ@...278...">
      <meta http-equiv="content-type" content="text/html; charset=utf-8">
      <div dir="ltr">
        <div dir="ltr">
          <div>Hi,<br>
            <br>
          </div>
          This is more relevant to OpenVPN than OpenSSL, so copying to
          the openvpn-devel list.<br>
        </div>
        <br>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">On Wed, Apr 10, 2019 at
            10:11 AM Francois Gelis &lt;<a
              href="mailto:francois.gelis@...277..." target="_blank"
              moz-do-not-send="true">francois.gelis@...277...</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <div dir="ltr">
              <div dir="ltr">
                <div dir="ltr">Hi all,
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
                    <div>Sat Apr  6 15:57:20 2019 us=467260 Incoming
                      Ciphertext -&gt; TLS</div>
                    <div>Sat Apr  6 15:57:20 2019 us=467271 SSL state
                      (connect): SSLv3/TLS read server hello</div>
                    <div>Sat Apr  6 15:57:20 2019 us=467468 VERIFY OK:
                      depth=1, CN=FG-CA</div>
                    <div>Sat Apr  6 15:57:20 2019 us=467598 VERIFY KU OK</div>
                    <div>Sat Apr  6 15:57:20 2019 us=467609 Validating
                      certificate extended key usage</div>
                    <div>Sat Apr  6 15:57:20 2019 us=467615 ++
                      Certificate has EKU (str) TLS Web Server
                      Authentication, expects TLS Web Server
                      Authentication</div>
                    <div>Sat Apr  6 15:57:20 2019 us=467620 VERIFY EKU
                      OK</div>
                    <div>Sat Apr  6 15:57:20 2019 us=467625 VERIFY OK:
                      depth=0, CN=tx2</div>
                    <div>Sat Apr  6 15:57:20 2019 us=467650 SSL state
                      (connect): SSLv3/TLS read server certificate</div>
                    <div>Sat Apr  6 15:57:20 2019 us=467735 SSL state
                      (connect): SSLv3/TLS read server key exchange</div>
                    <div>Sat Apr  6 15:57:20 2019 us=467763 SSL state
                      (connect): SSLv3/TLS read server certificate
                      request</div>
                    <div>Sat Apr  6 15:57:20 2019 us=467771 SSL state
                      (connect): SSLv3/TLS read server done</div>
                    <div>Sat Apr  6 15:57:20 2019 us=467845 SSL state
                      (connect): SSLv3/TLS write client certificate</div>
                    <div>Sat Apr  6 15:57:20 2019 us=468012 SSL state
                      (connect): SSLv3/TLS write client key exchange</div>
                    <div>Sat Apr  6 15:57:20 2019 us=468053 PKCS#11:
                      __pkcs11h_openssl_rsa_enc entered - flen=256,
                      from=0x559d078d6e70, to=0x559d078d6bc0,
                      rsa=0x559d078b3630, padding=3</div>
                    <div>Sat Apr  6 15:57:20 2019 us=468060 PKCS#11:
                      __pkcs11h_openssl_rsa_enc - return
                      rv=112-'CKR_MECHANISM_INVALID'</div>
                    <div>Sat Apr  6 15:57:20 2019 us=468070 SSL alert
                      (write): fatal: internal error</div>
                    <div>Sat Apr  6 15:57:20 2019 us=468085 OpenSSL:
                      error:141F0006:SSL
                      routines:tls_construct_cert_verify:EVP lib</div>
                    <div>Sat Apr  6 15:57:20 2019 us=468092 TLS_ERROR:
                      BIO read tls_read_plaintext error</div>
                    <div>Sat Apr  6 15:57:20 2019 us=468097 TLS Error:
                      TLS object -&gt; incoming plaintext read error</div>
                    <div>Sat Apr  6 15:57:20 2019 us=468101 TLS Error:
                      TLS handshake failed<br>
                    </div>
                  </div>
                  <div><br>
                  </div>
                  <div>Somehow, it seems that __pkcs11h_openssl_rsa_enc
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
    but I don't know how to trigger the "raw signature" bit.<br>
    <br>
    JJK<br>
    <br>
  </body>
</html>

--------------118E23B7A5BD0C7C21910827--

