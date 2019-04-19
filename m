References: <CAM1xzG1X-iERU2ZXFS_m_VqCKOwjt_gD8oi0F8J5h38Xx+FQ9A@...278...>
 <CAKuzo_gXgqWSLhpvMhjTS+VfbWmQ8JXnHEiOVEPyPSOMCbPKcQ@...278...>
 <63b81ed6-dce7-94b8-0dd5-8864a8314ec6@...1147...>
 <CAKuzo_iikr28FJcXNMz+xSbkoqZAyutJ3cx5J5zBvnEnEEw5bw@...278...>
 <d2f35ef2-dfbc-0202-2eb9-68e69051f742@...1147...>
 <CAKuzo_jn38kJm4izesNzK6fedgbc55MUYmmsyZRrZa1oaix5wg@...278...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <f120b337-53d1-b6b3-2188-db81fadc5bae@...1147...>
Date: Fri, 19 Apr 2019 15:12:49 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jn38kJm4izesNzK6fedgbc55MUYmmsyZRrZa1oaix5wg@...278...>
Content-Type: multipart/alternative;
 boundary="------------2373758E59910A8A5E9F81D3"
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
To: Selva Nair <selva.nair@...277...>, Francois Gelis <francois.gelis@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------2373758E59910A8A5E9F81D3
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Hi Selva,

On 17/04/19 17:52, Selva Nair wrote:
>
> On Wed, Apr 17, 2019 at 10:50 AM Jan Just Keijser <janjust@...1147... 
> <mailto:janjust@...1147...>> wrote:
>
>
>     On 10/04/19 19:09, Selva Nair wrote:
>>
>>
>>     On Wed, Apr 10, 2019 at 12:59 PM Jan Just Keijser
>>     <janjust@...1147... <mailto:janjust@...1147...>> wrote:
>
>
> snipped...
>
>>         patching pkcs11-helper does not seem too difficult for this
>>         particular case - but how can we test it? I have access to hw
>>         tokens but I don't know how to trigger the "raw signature" bit.
>>
>>
>>     If both server and client are built with OpenSSL 1.1.1 and TLS
>>     version is >= 1.2, PSS padding will get used and trigger this.
>>     OpenSSL does PSS padding internally and passes the padded data to
>>     the rsa_priv_enc calback for raw signature.
>>
>>     This is based on my tests for our Windows cryptoapi and
>>     management-external-key patches for the same -- never tried this
>>     using pkcs11-helper, but I expect the same behaviour.
>>
>>
>     The good news: I can reproduce this with
>     - openvpn 2.4.7
>     - openssl 1.1.1b
>     - pkcs11helper 1.25.1
>     - Safenet etoken
>     - client+server CentOS 7
>
>     The bad news: I don't have a fix yet.
>
>
> What I has in mind was a very simple patch like the one attached 
> (totally untested).
> But I guess you tried that already and it doesn't work? Is it because 
> the token
> does not support raw signature (not all do) or something else?
>
>
I had not written a patch when I wrote my earlier email, but your patch 
is exactly what I had in mind; getting it all to compile and run with 
OpenSSL 1.1.1b + OpenVPN 2.4.7 was a bit of a challenge, but I finally 
managed...

and yes, your patch works admirably - I can connect again using TLSv1.3 
+ token.  If I comment out your patch, do a rebuild of 
libpkcs11helper.so then it fails again, proving your patch works.

Can you do a pull request for your pkcs11-helper patch on the 
pkcs11helper github page?  or shall we simply patch pkcs11-helper ourselves?

cheers,

JJK


--------------2373758E59910A8A5E9F81D3
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Selva,<br>
      <br>
      On 17/04/19 17:52, Selva Nair wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAKuzo_jn38kJm4izesNzK6fedgbc55MUYmmsyZRrZa1oaix5wg@...278...">
      <meta http-equiv="content-type" content="text/html; charset=utf-8">
      <div dir="ltr"><br>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">On Wed, Apr 17, 2019 at
            10:50 AM Jan Just Keijser &lt;<a
              href="mailto:janjust@...1147..." moz-do-not-send="true">janjust@...1147...</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <div bgcolor="#FFFFFF">
              <div class="gmail-m_-4512286871544203907moz-cite-prefix"><br>
                On 10/04/19 19:09, Selva Nair wrote:<br>
              </div>
              <blockquote type="cite">
                <div dir="ltr">
                  <div dir="ltr"><br>
                  </div>
                  <br>
                  <div class="gmail_quote">
                    <div dir="ltr" class="gmail_attr">On Wed, Apr 10,
                      2019 at 12:59 PM Jan Just Keijser &lt;<a
                        href="mailto:janjust@...1147..." target="_blank"
                        moz-do-not-send="true">janjust@...1147...</a>&gt;
                      wrote:<br>
                    </div>
                  </div>
                </div>
              </blockquote>
            </div>
          </blockquote>
          <div><br>
          </div>
          <div>snipped...<br>
             <br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <div bgcolor="#FFFFFF">
              <blockquote type="cite">
                <div dir="ltr">
                  <div class="gmail_quote">
                    <div dir="ltr" class="gmail_attr"> </div>
                    <blockquote class="gmail_quote" style="margin:0px
                      0px 0px 0.8ex;border-left:1px solid
                      rgb(204,204,204);padding-left:1ex">
                      <div bgcolor="#FFFFFF">patching pkcs11-helper does
                        not seem too difficult for this particular case
                        - but how can we test it? I have access to hw
                        tokens but I don't know how to trigger the "raw
                        signature" bit.<br>
                      </div>
                    </blockquote>
                    <div><br>
                    </div>
                    <div>If both server and client are built with
                      OpenSSL 1.1.1 and TLS version is &gt;= 1.2, PSS
                      padding will get used and trigger this. OpenSSL
                      does PSS padding internally and passes the padded
                      data to the rsa_priv_enc calback for raw
                      signature.<br>
                      <br>
                    </div>
                    <div>This is based on my tests for our Windows
                      cryptoapi and management-external-key patches for
                      the same -- never tried this using pkcs11-helper,
                      but I expect the same behaviour.<br>
                      <br>
                    </div>
                    <br>
                  </div>
                </div>
              </blockquote>
              The good news: I can reproduce this with<br>
              - openvpn 2.4.7<br>
              - openssl 1.1.1b<br>
              - pkcs11helper 1.25.1<br>
              - Safenet etoken<br>
              - client+server CentOS 7<br>
              <br>
              The bad news: I don't have a fix yet.  <br>
            </div>
          </blockquote>
          <div><br>
            What I has in mind was a very simple patch like the one
            attached (totally untested).<br>
            But I guess you tried that already and it doesn't work? Is
            it because the token<br>
            does not support raw signature (not all do) or something
            else?<br>
            <br>
          </div>
          <br>
        </div>
      </div>
    </blockquote>
    I had not written a patch when I wrote my earlier email, but your
    patch is exactly what I had in mind; getting it all to compile and
    run with OpenSSL 1.1.1b + OpenVPN 2.4.7 was a bit of a challenge,
    but I finally managed...<br>
    <br>
    and yes, your patch works admirably - I can connect again using
    TLSv1.3 + token.  If I comment out your patch, do a rebuild of
    libpkcs11helper.so then it fails again, proving your patch works.<br>
    <br>
    Can you do a pull request for your pkcs11-helper patch on the
    pkcs11helper github page?  or shall we simply patch pkcs11-helper
    ourselves?<br>
    <br>
    cheers,<br>
    <br>
    JJK<br>
    <br>
  </body>
</html>

--------------2373758E59910A8A5E9F81D3--

