MIME-Version: 1.0
References: <20200220083825.29131-1-arne@...1227...>
 <261cca13-ca61-0fa7-7c37-f000f3d6d444@...1227...>
In-Reply-To: <261cca13-ca61-0fa7-7c37-f000f3d6d444@...1227...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 20 Feb 2020 15:01:17 +0500
Message-ID: <CAFHpkQFa-+k7dpi2GwUfnTFHtAX6BnFjr64wcmVa1QQf-y_DLg@...278...>
Content-Type: multipart/alternative; boundary="0000000000001205ac059efefd4d"
Subject: Re: [Openvpn-devel] [PATCH] Fix float comparisons of
 OPENVPN_VERSION_NUMBER
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000001205ac059efefd4d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 20 =D1=84=D0=B5=D0=B2=D1=80. 2020 =D0=B3. =D0=B2 13:44, Arne =
Schwabe <arne@...1227...>:

> Am 20.02.20 um 09:38 schrieb Arne Schwabe:
> > These checks are probably the result of copying a
> > check from the LibreSSL and modifying it to be
> > a OpenSSL check. For some arcane reason LibreSSL decided
> > that its version number should be a long float (double) rather
> > than an integer.
> >
> > Signed-off-by: Arne Schwabe <arne@...1227...>
> > ---
> >  src/openvpn/ssl_openssl.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> > index 21651a3e..bcdfb543 100644
> > --- a/src/openvpn/ssl_openssl.c
> > +++ b/src/openvpn/ssl_openssl.c
> > @@ -231,7 +231,7 @@ tls_version_max(void)
> >       * We only need to check this for OpenSSL versions that can be
> >       * upgraded to 1.1.1 without recompile (>=3D 1.1.0)
> >       */
> > -    if (OpenSSL_version_num() >=3D 0x1010100fL)
> > +    if (OpenSSL_version_num() >=3D 0x1010100L)
> >      {
> >          return TLS_VER_1_3;
> >      }
> > @@ -2104,7 +2104,7 @@ show_available_tls_ciphers_list(const char
> *cipher_list,
> >          crypto_msg(M_FATAL, "Cannot create SSL object");
> >      }
> >
> > -#if (OPENSSL_VERSION_NUMBER < 0x1010000fL)    \
> > +#if (OPENSSL_VERSION_NUMBER < 0x1010000L)    \
> >      || (defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER <=
=3D
> 0x2090000fL)
> >      STACK_OF(SSL_CIPHER) *sk =3D SSL_get_ciphers(ssl);
> >  #else
> > @@ -2134,7 +2134,7 @@ show_available_tls_ciphers_list(const char
> *cipher_list,
> >              printf("%s\n", pair->iana_name);
> >          }
> >      }
> > -#if (OPENSSL_VERSION_NUMBER >=3D 0x1010000fL)
> > +#if (OPENSSL_VERSION_NUMBER >=3D 0x1010000L)
> >      sk_SSL_CIPHER_free(sk);
> >  #endif
> >      SSL_free(ssl);
> >
>
>
> Ignore that patch. I am not awake yet. the fL is not a suffix. LibreSSL
> has has its patch version to be 0f.
>

can you also close it here https://patchwork.openvpn.net/patch/1015/ ?
to prevent someone from taking it accidently


>
> Arne
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--0000000000001205ac059efefd4d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">=D1=87=D1=82, 20 =D1=84=D0=B5=D0=B2=
=D1=80. 2020 =D0=B3. =D0=B2 13:44, Arne Schwabe &lt;<a href=3D"mailto:arne@=
...1227...">arne@...1227...</a>&gt;:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">Am 20.02.20 um 09:38 schrieb Arne Schwabe:<br>
&gt; These checks are probably the result of copying a<br>
&gt; check from the LibreSSL and modifying it to be<br>
&gt; a OpenSSL check. For some arcane reason LibreSSL decided<br>
&gt; that its version number should be a long float (double) rather<br>
&gt; than an integer.<br>
&gt; <br>
&gt; Signed-off-by: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." tar=
get=3D"_blank">arne@...1227...</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 src/openvpn/ssl_openssl.c | 6 +++---<br>
&gt;=C2=A0 1 file changed, 3 insertions(+), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c<br>
&gt; index 21651a3e..bcdfb543 100644<br>
&gt; --- a/src/openvpn/ssl_openssl.c<br>
&gt; +++ b/src/openvpn/ssl_openssl.c<br>
&gt; @@ -231,7 +231,7 @@ tls_version_max(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* We only need to check this for OpenSSL ver=
sions that can be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* upgraded to 1.1.1 without recompile (&gt;=
=3D 1.1.0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; -=C2=A0 =C2=A0 if (OpenSSL_version_num() &gt;=3D 0x1010100fL)<br>
&gt; +=C2=A0 =C2=A0 if (OpenSSL_version_num() &gt;=3D 0x1010100L)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return TLS_VER_1_3;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; @@ -2104,7 +2104,7 @@ show_available_tls_ciphers_list(const char *ciph=
er_list,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 crypto_msg(M_FATAL, &quot;Cannot cre=
ate SSL object&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -#if (OPENSSL_VERSION_NUMBER &lt; 0x1010000fL)=C2=A0 =C2=A0 \<br>
&gt; +#if (OPENSSL_VERSION_NUMBER &lt; 0x1010000L)=C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 || (defined(LIBRESSL_VERSION_NUMBER) &amp;&amp; LI=
BRESSL_VERSION_NUMBER &lt;=3D 0x2090000fL)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 STACK_OF(SSL_CIPHER) *sk =3D SSL_get_ciphers(ssl);=
<br>
&gt;=C2=A0 #else<br>
&gt; @@ -2134,7 +2134,7 @@ show_available_tls_ciphers_list(const char *ciph=
er_list,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;%s\n&quot=
;, pair-&gt;iana_name);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -#if (OPENSSL_VERSION_NUMBER &gt;=3D 0x1010000fL)<br>
&gt; +#if (OPENSSL_VERSION_NUMBER &gt;=3D 0x1010000L)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 sk_SSL_CIPHER_free(sk);<br>
&gt;=C2=A0 #endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 SSL_free(ssl);<br>
&gt; <br>
<br>
<br>
Ignore that patch. I am not awake yet. the fL is not a suffix. LibreSSL<br>
has has its patch version to be 0f.<br></blockquote><div><br></div><div>can=
 you also close it here <a href=3D"https://patchwork.openvpn.net/patch/1015=
/">https://patchwork.openvpn.net/patch/1015/</a> ?</div><div>to prevent som=
eone from taking it accidently<br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
Arne<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div></div>

--0000000000001205ac059efefd4d--

