MIME-Version: 1.0
In-Reply-To: <20170207041451.GA11922@...2182...>
References: <CAOAUwZH8aRg-5XLJaYjpzw6y9yptx-ma7QJVPJT-yKFE7cmUrw@...278...>
	<20170207041451.GA11922@...2182...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 7 Feb 2017 13:45:57 +0500
Message-ID: <CAFHpkQESrLYrnVPUOeNf7kbHe27=1w5x8uc=ATynTNnPvezpkw@...278...>
Content-Type: multipart/alternative; boundary=001a11469c54d873c50547ecc6d5
Subject: Re: [Openvpn-devel] [PATCH] Fix building with LibreSSL 2.5.1 by
 cleaning a hack.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11469c54d873c50547ecc6d5
Content-Type: text/plain; charset=UTF-8

2017-02-07 9:14 GMT+05:00 Antonio Quartulli <a@...2181...>:

> On Mon, Feb 06, 2017 at 08:18:01PM +0100, Olivier W wrote:
> > Should be compatible with all versions of OpenSSL and LibreSSL.
> > Similar to what is done in curl:
> > https://github.com/curl/curl/blob/028391df5d84d9fae3433afdee9261
> d565900355/lib/vtls/openssl.c#L603-L619
> >
> > Error while compiling was:
> > "ssl_openssl.c:512:30: error: no member named 'cert' in 'struct
> ssl_ctx_st'
> > ssl.cert = ctx->ctx->cert;
> > ~ ^
> > 1 error generated.
> > *** Error code 1"
> > ---
> > diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> > index 8266595..a889332 100644
> > --- a/src/openvpn/ssl_openssl.c
> > +++ b/src/openvpn/ssl_openssl.c
> > @@ -508,10 +508,13 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx
> > *ctx, const char *curve_name
> >          const EC_GROUP *ecgrp = NULL;
> >          EVP_PKEY *pkey = NULL;
> >
> > -        /* Little hack to get private key ref from SSL_CTX, yay
> OpenSSL... */
> > -        SSL ssl;
> > -        ssl.cert = ctx->ctx->cert;
> > -        pkey = SSL_get_privatekey(&ssl);
> > +        SSL *ssl = SSL_new(ctx->ctx);
> > +        if (!ssl)
> > +        {
> > +            crypto_msg(M_FATAL, "SSL_new failed");
> > +        }
> > +        pkey = SSL_get_privatekey(ssl);
> > +        SSL_free(ssl);
>
> I have a question (sorry if I couldn't check myself): did you check that
> SSL_get_privatekey() and SSL_free() won't crash when ssl is NULL ?
>


what if we involve clang static analyzer for such things ? can we count on
it ?

it is capable of detecting "Argument with 'nonnull' attribute passed null"

and, as I can see, after applying patch it didn't find new issues

http://chipitsine.github.io/without-patch/
http://chipitsine.github.io/with-patch/


also, it might be even automated, run clang static analyzer before and
after applying patch and compare the result


>
> Cheers,
>
>
> --
> Antonio Quartulli
>
> ------------------------------------------------------------
> ------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>

--001a11469c54d873c50547ecc6d5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-02-07 9:14 GMT+05:00 Antonio Quartulli <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:a@...2181..." target=3D"_blank">a@...2181...</a>&gt;</span>:<b=
r><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex"><div class=3D"gmail-HOE=
nZb"><div class=3D"gmail-h5">On Mon, Feb 06, 2017 at 08:18:01PM +0100, Oliv=
ier W wrote:<br>
&gt; Should be compatible with all versions of OpenSSL and LibreSSL.<br>
&gt; Similar to what is done in curl:<br>
&gt; <a href=3D"https://github.com/curl/curl/blob/028391df5d84d9fae3433afde=
e9261d565900355/lib/vtls/openssl.c#L603-L619" rel=3D"noreferrer" target=3D"=
_blank">https://github.com/curl/curl/<wbr>blob/<wbr>028391df5d84d9fae3433af=
dee9261<wbr>d565900355/lib/vtls/openssl.c#<wbr>L603-L619</a><br>
&gt;<br>
&gt; Error while compiling was:<br>
&gt; &quot;ssl_openssl.c:512:30: error: no member named &#39;cert&#39; in &=
#39;struct ssl_ctx_st&#39;<br>
&gt; ssl.cert =3D ctx-&gt;ctx-&gt;cert;<br>
&gt; ~ ^<br>
&gt; 1 error generated.<br>
&gt; *** Error code 1&quot;<br>
&gt; ---<br>
&gt; diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c<br>
&gt; index 8266595..a889332 100644<br>
&gt; --- a/src/openvpn/ssl_openssl.c<br>
&gt; +++ b/src/openvpn/ssl_openssl.c<br>
&gt; @@ -508,10 +508,13 @@ tls_ctx_load_ecdh_params(<wbr>struct tls_root_ct=
x<br>
&gt; *ctx, const char *curve_name<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const EC_GROUP *ecgrp =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 EVP_PKEY *pkey =3D NULL;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Little hack to get private key ref fro=
m SSL_CTX, yay OpenSSL... */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 SSL ssl;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 ssl.cert =3D ctx-&gt;ctx-&gt;cert;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 pkey =3D SSL_get_privatekey(&amp;ssl);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 SSL *ssl =3D SSL_new(ctx-&gt;ctx);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ssl)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 crypto_msg(M_FATAL, &quot;S=
SL_new failed&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pkey =3D SSL_get_privatekey(ssl);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 SSL_free(ssl);<br>
<br>
</div></div>I have a question (sorry if I couldn&#39;t check myself): did y=
ou check that<br>
SSL_get_privatekey() and SSL_free() won&#39;t crash when ssl is NULL ?<br><=
/blockquote><div><br><br></div><div>what if we involve clang static analyze=
r for such things ? can we count on it ?<br><br></div><div>it is capable of=
 detecting &quot;Argument with &#39;nonnull&#39; attribute passed null&quot=
;<br><br></div><div>and, as I can see, after applying patch it didn&#39;t f=
ind new issues<br><br><a href=3D"http://chipitsine.github.io/without-patch/=
">http://chipitsine.github.io/without-patch/</a><br><a href=3D"http://chipi=
tsine.github.io/with-patch/">http://chipitsine.github.io/with-patch/</a><br=
><br><br></div><div>also, it might be even automated, run clang static anal=
yzer before and after applying patch and compare the result<br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Cheers,<br>
<span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br>
<br>
--<br>
Antonio Quartulli<br>
</font></span><br>------------------------------<wbr>----------------------=
--------<wbr>------------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, SlashDot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>_________=
_____________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
<br></blockquote></div><br></div></div>

--001a11469c54d873c50547ecc6d5--

