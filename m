MIME-Version: 1.0
Sender: emmanueldeloget53@...277...
In-Reply-To: <183bd138-e733-042e-9cc3-c66bbf6ea9bd@...1856...>
References: <CAKh=nwFOSOCugW1JWYfiQFZLTKRBc6qoi=U9ewzjOSpaGP1-Kg@...278...>
 <6a6ede658da2e35b718a9ccb733b132a955ffefe.1515792908.git.logout@...260...>
 <183bd138-e733-042e-9cc3-c66bbf6ea9bd@...1856...>
From: Emmanuel Deloget <logout@...260...>
Date: Mon, 15 Jan 2018 23:33:51 +0100
Message-ID: <CAKh=nwEeSBgkbz5-_R_eU7rK9fYpDQ=1jsY+02+vMxRJ8=wZxg@...278...>
Content-Type: multipart/alternative; boundary="001a1144b16e6377de0562d83554"
Subject: Re: [Openvpn-devel] [PATCH v2 2/3] OpenSSL: remove some EVP_PKEY
 type checks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--001a1144b16e6377de0562d83554
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Steffan,

On Sun, Jan 14, 2018 at 11:26 AM, Steffan Karger <steffan@...1856...> wrote:

> Hi,
>
> On 12-01-18 22:37, Emmanuel Deloget wrote:
> > Calling EVP_KEY_id() before EVP_PKEY_get0_*() is unnecessary as
> > the same check is also performed in the later.
> >
> > We also make the code a bit better by not calling the various
> > EVP_PKEY_get0_*() functions twice (this needs a bit or reordering to
> > avoid introducing yet another #ifndef OPENSSL_NO_EC in the code).
>
> Checking double is a bit silly, but we can fix that by simply removing
> the "EVP_PKEY_id() =3D=3D ... && " occurrences. (That still allows us to
> remove it from the compat wrapper.)
>
> I'm not sure that moving the variables outside the if() scope actually
> improves the code.  At least I think the original flow is easier to
> read.  Mostly due to the #ifdef noise, but still.  In a path that's not
> performance-critical, I prefer readability over performance.
>


=E2=80=8BWell, to be honest, I was definitely not trying to make any kind of
performance gain :)=E2=80=8B

The whole idea was to make code easier to read and to remove some now weird
duplication of functions (the kind of duplication that will come and bites
you later).

For the variables outside the ifs, the next C standard should allow us to
write something like:

if ((RSA *rsa =3D EVP_PKEY_get0_RSA(pkey)) !=3D NULL) {
...

That should be easier to read (but then, I'm not sure when this will be
considered as widespread ; I guess we're slated for 2025 or so :))

Anyway, moving the variables within the if means we're going to call
EVP_PKEY_get0_RSA() twice which, I feel, is not a good thing to do. But
even if I'm not very comfortable with this, I can still propose a patch
that des it (it's lighter than the currently proposed change). You tell me
:)



>
> > Signed-off-by: Emmanuel Deloget <logout@...260...>
> >
> > diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> > index 711bba11..7943fb2c 100644
> > --- a/src/openvpn/ssl_openssl.c
> > +++ b/src/openvpn/ssl_openssl.c
> > @@ -1699,22 +1699,13 @@ print_details(struct key_state_ssl *ks_ssl,
> const char *prefix)
> >          EVP_PKEY *pkey =3D X509_get_pubkey(cert);
> >          if (pkey !=3D NULL)
> >          {
> > -            if ((EVP_PKEY_id(pkey) =3D=3D EVP_PKEY_RSA) &&
> (EVP_PKEY_get0_RSA(pkey) !=3D NULL))
> > -            {
> > -                RSA *rsa =3D EVP_PKEY_get0_RSA(pkey);
> > -                openvpn_snprintf(s2, sizeof(s2), ", %d bit RSA",
> > -                                 RSA_bits(rsa));
> > -            }
> > -            else if ((EVP_PKEY_id(pkey) =3D=3D EVP_PKEY_DSA) &&
> (EVP_PKEY_get0_DSA(pkey) !=3D NULL))
> > -            {
> > -                DSA *dsa =3D EVP_PKEY_get0_DSA(pkey);
> > -                openvpn_snprintf(s2, sizeof(s2), ", %d bit DSA",
> > -                                 DSA_bits(dsa));
> > -            }
> > +            RSA *rsa =3D NULL;
> > +            DSA *dsa =3D NULL;
> >  #ifndef OPENSSL_NO_EC
> > -            else if ((EVP_PKEY_id(pkey) =3D=3D EVP_PKEY_EC) &&
> (EVP_PKEY_get0_EC_KEY(pkey) !=3D NULL))
> > +            EC_KEY *ec =3D NULL;
> > +
> > +            if ((ec =3D EVP_PKEY_get0_EC_KEY(pkey)) !=3D NULL)
> >              {
> > -                EC_KEY *ec =3D EVP_PKEY_get0_EC_KEY(pkey);
> >                  const EC_GROUP *group =3D EC_KEY_get0_group(ec);
> >                  const char* curve;
> >
> > @@ -1726,9 +1717,19 @@ print_details(struct key_state_ssl *ks_ssl, const
> char *prefix)
> >
> >                  openvpn_snprintf(s2, sizeof(s2), ", %d bit EC, curve:
> %s",
> >                                   EC_GROUP_order_bits(group), curve);
> > -
> > -            }
> > +            } else
> >  #endif
> > +            if ((rsa =3D EVP_PKEY_get0_RSA(pkey)) !=3D NULL)
> > +            {
> > +                openvpn_snprintf(s2, sizeof(s2), ", %d bit RSA",
> > +                                 RSA_bits(rsa));
> > +            }
> > +            else if ((dsa =3D EVP_PKEY_get0_DSA(pkey)) !=3D NULL)
> > +            {
> > +                openvpn_snprintf(s2, sizeof(s2), ", %d bit DSA",
> > +                                 DSA_bits(dsa));
> > +            }
> > +
> >              EVP_PKEY_free(pkey);
> >          }
> >          X509_free(cert);
> >
>
> -Steffan
>


=E2=80=8BBest regards,

-- Emmanuel Deloget=E2=80=8B

--001a1144b16e6377de0562d83554
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:monospac=
e,monospace">Hello Steffan,=C2=A0</div><div class=3D"gmail_extra"><br><div =
class=3D"gmail_quote">On Sun, Jan 14, 2018 at 11:26 AM, Steffan Karger <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:steffan@...1856..." target=3D"_blank">s=
teffan@...1856...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Hi,<br>
<span class=3D"gmail-"><br>
On 12-01-18 22:37, Emmanuel Deloget wrote:<br>
&gt; Calling EVP_KEY_id() before EVP_PKEY_get0_*() is unnecessary as<br>
&gt; the same check is also performed in the later.<br>
&gt;<br>
&gt; We also make the code a bit better by not calling the various<br>
&gt; EVP_PKEY_get0_*() functions twice (this needs a bit or reordering to<b=
r>
&gt; avoid introducing yet another #ifndef OPENSSL_NO_EC in the code).<br>
<br>
</span>Checking double is a bit silly, but we can fix that by simply removi=
ng<br>
the &quot;EVP_PKEY_id() =3D=3D ... &amp;&amp; &quot; occurrences. (That sti=
ll allows us to<br>
remove it from the compat wrapper.)<br>
<br>
I&#39;m not sure that moving the variables outside the if() scope actually<=
br>
improves the code.=C2=A0 At least I think the original flow is easier to<br>
read.=C2=A0 Mostly due to the #ifdef noise, but still.=C2=A0 In a path that=
&#39;s not<br>
performance-critical, I prefer readability over performance.<br></blockquot=
e><div><br></div><div><div class=3D"gmail_default" style=3D"font-family:mon=
ospace,monospace"><br></div><div class=3D"gmail_default" style=3D"font-fami=
ly:monospace,monospace">=E2=80=8BWell, to be honest, I was definitely not t=
rying to make any kind of performance gain :)=E2=80=8B</div><div class=3D"g=
mail_default" style=3D"font-family:monospace,monospace"><br></div><div clas=
s=3D"gmail_default" style=3D"font-family:monospace,monospace">The whole ide=
a was to make code easier to read and to remove some now weird duplication =
of functions (the kind of duplication that will come and bites you later).=
=C2=A0</div><div class=3D"gmail_default" style=3D"font-family:monospace,mon=
ospace"><br></div><div class=3D"gmail_default" style=3D"font-family:monospa=
ce,monospace">For the variables outside the ifs, the next C standard should=
 allow us to write something like:</div><div class=3D"gmail_default" style=
=3D"font-family:monospace,monospace"><br></div><div class=3D"gmail_default"=
 style=3D"font-family:monospace,monospace">if ((RSA *rsa =3D EVP_PKEY_get0_=
RSA(pkey)) !=3D NULL) {</div><div class=3D"gmail_default" style=3D"font-fam=
ily:monospace,monospace">...</div><div class=3D"gmail_default" style=3D"fon=
t-family:monospace,monospace"><br></div><div class=3D"gmail_default" style=
=3D"font-family:monospace,monospace">That should be easier to read (but the=
n, I&#39;m not sure when this will be considered as widespread ; I guess we=
&#39;re slated for 2025 or so :))</div><div class=3D"gmail_default" style=
=3D"font-family:monospace,monospace"><br></div><div class=3D"gmail_default"=
 style=3D"font-family:monospace,monospace">Anyway, moving the variables wit=
hin the if means we&#39;re going to call EVP_PKEY_get0_RSA() twice which, I=
 feel, is not a good thing to do. But even if I&#39;m not very comfortable =
with this, I can still propose a patch that des it (it&#39;s lighter than t=
he currently proposed change). You tell me :)</div><br></div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
<div><div class=3D"gmail-h5"><br>
&gt; Signed-off-by: Emmanuel Deloget &lt;<a href=3D"mailto:logout@...260...=
">logout@...260...</a>&gt;<br>
&gt;<br>
&gt; diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c<br>
&gt; index 711bba11..7943fb2c 100644<br>
&gt; --- a/src/openvpn/ssl_openssl.c<br>
&gt; +++ b/src/openvpn/ssl_openssl.c<br>
&gt; @@ -1699,22 +1699,13 @@ print_details(struct key_state_ssl *ks_ssl, co=
nst char *prefix)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 EVP_PKEY *pkey =3D X509_get_pubkey(c=
ert);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pkey !=3D NULL)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((EVP_PKEY_id(pkey) =3D=
=3D EVP_PKEY_RSA) &amp;&amp; (EVP_PKEY_get0_RSA(pkey) !=3D NULL))<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RSA *rsa =3D =
EVP_PKEY_get0_RSA(pkey);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 openvpn_snpri=
ntf(s2, sizeof(s2), &quot;, %d bit RSA&quot;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RSA_bits(rsa));<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if ((EVP_PKEY_id(pkey)=
 =3D=3D EVP_PKEY_DSA) &amp;&amp; (EVP_PKEY_get0_DSA(pkey) !=3D NULL))<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DSA *dsa =3D =
EVP_PKEY_get0_DSA(pkey);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 openvpn_snpri=
ntf(s2, sizeof(s2), &quot;, %d bit DSA&quot;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DSA_bits(dsa));<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RSA *rsa =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DSA *dsa =3D NULL;<br>
&gt;=C2=A0 #ifndef OPENSSL_NO_EC<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if ((EVP_PKEY_id(pkey)=
 =3D=3D EVP_PKEY_EC) &amp;&amp; (EVP_PKEY_get0_EC_KEY(pkey) !=3D NULL))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 EC_KEY *ec =3D NULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((ec =3D EVP_PKEY_get0_E=
C_KEY(pkey)) !=3D NULL)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 EC_KEY *ec =
=3D EVP_PKEY_get0_EC_KEY(pkey);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const EC=
_GROUP *group =3D EC_KEY_get0_group(ec);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const ch=
ar* curve;<br>
&gt;<br>
&gt; @@ -1726,9 +1717,19 @@ print_details(struct key_state_ssl *ks_ssl, con=
st char *prefix)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 openvpn_=
snprintf(s2, sizeof(s2), &quot;, %d bit EC, curve: %s&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0EC_GROUP_order_bits(=
group), curve);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else<br>
&gt;=C2=A0 #endif<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((rsa =3D EVP_PKEY_get0_=
RSA(pkey)) !=3D NULL)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 openvpn_snpri=
ntf(s2, sizeof(s2), &quot;, %d bit RSA&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RSA_bits(rsa));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if ((dsa =3D EVP_PKEY_=
get0_DSA(pkey)) !=3D NULL)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 openvpn_snpri=
ntf(s2, sizeof(s2), &quot;, %d bit DSA&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DSA_bits(dsa));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 EVP_PKEY_free(pkey);<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 X509_free(cert);<br>
&gt;<br>
<br>
</div></div>-Steffan<br></blockquote><div><br></div><div class=3D"gmail_def=
ault" style=3D"font-family:monospace,monospace"><br></div><div class=3D"gma=
il_default" style=3D"font-family:monospace,monospace">=E2=80=8BBest regards=
,=C2=A0</div><div class=3D"gmail_default" style=3D"font-family:monospace,mo=
nospace"><br></div><div class=3D"gmail_default" style=3D"font-family:monosp=
ace,monospace">-- Emmanuel Deloget=E2=80=8B</div></div></div></div>

--001a1144b16e6377de0562d83554--

