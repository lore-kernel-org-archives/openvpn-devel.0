MIME-Version: 1.0
References: <f80646d4-0fc3-4e5a-bc05-22b929452d00@...1800...>
 <CAKuzo_hqwfqgSb57fwCEx6C+HBVawt-ECZuNkacVBb4y-CYwcw@...278...>
 <850037b2-36d0-4240-8c73-04dab1a90777@...1800...>
 <68a68aa4-0c57-655c-e0c9-ff9f1e0bf040@...1227...>
In-Reply-To: <68a68aa4-0c57-655c-e0c9-ff9f1e0bf040@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 28 Sep 2023 21:25:03 -0400
Message-ID: <CAKuzo_iUEcp0Au0vHTfr4fwozDccxgRXCmV+C2eWc=W4ciTxog@...278...>
Content-Type: multipart/alternative; boundary="00000000000031b6ed0606754cf9"
Subject: Re: [Openvpn-devel] pkcs11 config changes from 2.5.4 to 2.6.6 ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: mike tancsa <mike@...1800...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000031b6ed0606754cf9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 8:55=E2=80=AFPM Arne Schwabe <arne@...1227...> wrot=
e:

>
> Am 29.09.2023 um 01:08 schrieb mike tancsa:
>
> Hi Selva,
>
>     Thank you for looking!
>
> My guess is that something in the certificate or private key is not to
> OpenSSL 3.1's liking and it rejects it. Is there any way for you to check
> the
> contents of the token independently using a tool linked against OpenSSL
> 3.1 ?
>
> What am I looking for in that case ?  Taking a look at the cert just with
> openssl 3.0 on FreeBSD releng14 it seems ok with it. Same with the Windows
> version 3.1.x that comes with OpenVPN. Is it possible it doesnt like the
> sha1RSA sig ?
>
> OpenSSL 3.0 has security 1 by default (OpenSSL 3.1 has 2 by default)  and
> that does not allow SHA1 signatures anymore. See
> https://www.openssl.org/docs/man3.1/man3/SSL_CTX_set_security_level.html
>

Good point. But, unless the config has "tls-cert-profile foo", we still
default to legacy and call SSL_CTX_set_security_level(ctx, 1), isn't it?
Wouldn't that allow SHA1 with 3.1.x ?

Selva

--00000000000031b6ed0606754cf9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 28, 2023 at 8:55=E2=80=AF=
PM Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=3D"_blank">ar=
ne@...1227...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
=20=20
=20=20=20=20
=20=20
  <div>
    <p><br>
    </p>
    <div>Am 29.09.2023 um 01:08 schrieb mike
      tancsa:<br>
    </div>
    <blockquote type=3D"cite">
=20=20=20=20=20=20
      <p>Hi Selva,</p>
      <p>=C2=A0=C2=A0=C2=A0 Thank you for looking!<br>
      </p>
      <br>
      <blockquote type=3D"cite">
        <div dir=3D"ltr">
          <div class=3D"gmail_quote">
            <div>My guess is that something in the certificate or
              private key is not to</div>
            <div>OpenSSL 3.1&#39;s liking and it rejects it. Is there any
              way for you to check the</div>
            <div>contents of the token independently using a tool linked
              against OpenSSL 3.1 ?</div>
            <div><br>
            </div>
          </div>
        </div>
      </blockquote>
      <p>What am I looking for in that case ?=C2=A0 Taking a look at the ce=
rt
        just with openssl 3.0 on FreeBSD releng14 it seems ok with it.
        Same with the Windows version 3.1.x that comes with OpenVPN. Is
        it possible it doesnt like the sha1RSA sig ?<br>
      </p>
      <br>
    </blockquote>
    <p>OpenSSL 3.0 has security 1 by default (OpenSSL 3.1 has 2 by
      default)=C2=A0 and that does not allow SHA1 signatures anymore. See
      <a href=3D"https://www.openssl.org/docs/man3.1/man3/SSL_CTX_set_secur=
ity_level.html" target=3D"_blank">https://www.openssl.org/docs/man3.1/man3/=
SSL_CTX_set_security_level.html</a></p></div></blockquote><div><br></div><d=
iv>Good point. But, unless the config has &quot;tls-cert-profile foo&quot;,=
 we still default to legacy and call SSL_CTX_set_security_level(ctx, 1), is=
n&#39;t it? Wouldn&#39;t that allow SHA1 with 3.1.x ?</div><div><br></div><=
div>Selva</div></div></div>

--00000000000031b6ed0606754cf9--

