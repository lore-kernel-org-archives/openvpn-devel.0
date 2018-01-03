MIME-Version: 1.0
Sender: emmanueldeloget53@...277...
In-Reply-To: <a5a2341f-ff5f-0f7a-f2ca-da576bd4d76d@...1227...>
References: <CAKuzo_gJK_1jU5juC1YQzKzm=25Cm+c-3X7-pT1DW_fkkW_9dQ@...278...>
 <6fd65f21-7f90-b2a1-7cb6-67559d60d8e1@...1435...>
 <a5a2341f-ff5f-0f7a-f2ca-da576bd4d76d@...1227...>
From: Emmanuel Deloget <logout@...260...>
Date: Wed, 3 Jan 2018 12:49:09 +0100
Message-ID: <CAKh=nwE9qytajs3J=x5dgmBYRpN4iUbHELsZ4Km_od94SVN0kQ@...278...>
Content-Type: multipart/alternative; boundary="001a11408e1eb33fd30561ddcd70"
Subject: Re: [Openvpn-devel] openvpn segfaults on --management-external-key
 with ECC certificate
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Steffan Karger <steffan.karger@...1435...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11408e1eb33fd30561ddcd70
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,


On Wed, Jan 3, 2018 at 9:34 AM, Arne Schwabe <arne@...1227...> wrote:

> Am 03.01.18 um 09:19 schrieb Steffan Karger:
> > On 03-01-18 03:22, Selva Nair wrote:
> >> This is with openssl 1.0.1 and that could be the problem -- it may not
> >> have EVP_PKEY_get0_RSA() in which case the compatibility interface in
> >> use is probably not smart enough...
>

=E2=80=8BYou are fully right. =E2=80=8B=E2=80=8BIt seems I failed to see th=
at, and I don't remember
why. I guess I'm getting old... :)



> >
> > Exactly this is the case I think.  The following should solve the issue:
> >
> > --- a/src/openvpn/openssl_compat.h
> > +++ b/src/openvpn/openssl_compat.h
> > @@ -240,7 +240,7 @@ X509_OBJECT_get_type(const X509_OBJECT *obj)
> >  static inline RSA *
> >  EVP_PKEY_get0_RSA(EVP_PKEY *pkey)
> >  {
> > -    return pkey ? pkey->pkey.rsa : NULL;
> > +    return (pkey && pkey->type =3D=3D EVP_PKEY_RSA) ? pkey->pkey.rsa :=
 NULL;
> >  }
> >  #endif
> >
> > (No time to properly test and send a patch now, will look into it more
> > later if nobody else does.)
>
> You are right. This is also what OpenSSL 1.1.0  does:
>
> RSA *
> =E2=80=8B=E2=80=8B
> EVP_PKEY_get0_RSA(EVP_PKEY *pkey)
> {
>     if (pkey->type !=3D EVP_PKEY_RSA) {
>         EVPerr(EVP_F_EVP_PKEY_GET0_RSA, EVP_R_EXPECTING_AN_RSA_KEY);
>         return NULL;
>     }
>     return pkey->pkey.rsa;
> }
>
>
Normally, the code that calls EVP_PKEY_get0_*() is protected by a test
EVP_PKEY_id() =3D=3D EVP_PKEY_*. The only case where it's not is
in tls_ctx_use_external_private_key() where it executes the following code:

    pub_rsa =3D EVP_PKEY_get0_RSA(pkey);

    /* Certificate might not be RSA but DSA or EC */
    if (!pub_rsa)
    {
        crypto_msg(M_WARN, "management-external-key requires a RSA
certificate");
        goto err;
    }

But then, since pkey->pkey is an union, it will return a non-null pointer
when called on a DSA or EC key. I guess I wrongly assumed it was a struct
(BTW, the code it replaced seemed to also assume pkey->pkey was a struct;
that does not excuse my own failure).

So a better (as in: more complete) fix would be to also correct
EVP_PKEY_get0_DSA() and EVP_PKEY_get0_EC_KEY() and to remove unnecessary
calls to EVP_PKEY_id() when it makes sense. I made this while writing this
email and pushed the corresponding branch here:

https://github.com/emmanuel-deloget/openvpn/tree/fix-evp-pkey

I will send the patches on the ML as soon as I can.


Arne



=E2=80=8BBest regards,

-- Emmanuel Deloget=E2=80=8B

--001a11408e1eb33fd30561ddcd70
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:monospac=
e,monospace">Hello,=C2=A0</div><div class=3D"gmail_default" style=3D"font-f=
amily:monospace,monospace"><br></div><div class=3D"gmail_extra"><br><div cl=
ass=3D"gmail_quote">On Wed, Jan 3, 2018 at 9:34 AM, Arne Schwabe <span dir=
=3D"ltr">&lt;<a href=3D"mailto:arne@...1227..." target=3D"_blank">arne@...1386...=
227...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">Am 03.01.18 um 09:19 schrieb Steffan Karger:<br>
<span class=3D"gmail-">&gt; On 03-01-18 03:22, Selva Nair wrote:<br>
&gt;&gt; This is with openssl 1.0.1 and that could be the problem -- it may=
 not<br>
&gt;&gt; have EVP_PKEY_get0_RSA() in which case the compatibility interface=
 in<br>
&gt;&gt; use is probably not smart enough...<br></span></blockquote><div><b=
r></div><div><div class=3D"gmail_default" style=3D"font-family:monospace,mo=
nospace">=E2=80=8BYou are fully right. =E2=80=8B=E2=80=8BIt seems I failed =
to see that, and I don&#39;t remember why. I guess I&#39;m getting old... :=
)</div></div><div class=3D"gmail_default" style=3D"font-family:monospace,mo=
nospace"><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><span class=3D"gmail-">
&gt;<br>
&gt; Exactly this is the case I think.=C2=A0 The following should solve the=
 issue:<br>
&gt;<br>
&gt; --- a/src/openvpn/openssl_compat.h<br>
&gt; +++ b/src/openvpn/openssl_compat.h<br>
&gt; @@ -240,7 +240,7 @@ X509_OBJECT_get_type(const X509_OBJECT *obj)<br>
&gt;=C2=A0 static inline RSA *<br>
&gt;=C2=A0 EVP_PKEY_get0_RSA(EVP_PKEY *pkey)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 return pkey ? pkey-&gt;pkey.rsa : NULL;<br>
&gt; +=C2=A0 =C2=A0 return (pkey &amp;&amp; pkey-&gt;type =3D=3D EVP_PKEY_R=
SA) ? pkey-&gt;pkey.rsa : NULL;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 #endif<br>
&gt;<br>
&gt; (No time to properly test and send a patch now, will look into it more=
<br>
&gt; later if nobody else does.)<br>
<br>
</span>You are right. This is also what OpenSSL 1.1.0=C2=A0 does:<br>
<br>
RSA *<div class=3D"gmail_default" style=3D"font-family:monospace,monospace;=
display:inline">=E2=80=8B=E2=80=8B</div>EVP_PKEY_get0_RSA(EVP_PKEY *pkey)<b=
r>
{<br>
=C2=A0 =C2=A0 if (pkey-&gt;type !=3D EVP_PKEY_RSA) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 EVPerr(EVP_F_EVP_PKEY_GET0_<wbr>RSA, EVP_R_EXPE=
CTING_AN_RSA_KEY);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 return pkey-&gt;pkey.rsa;<br>
}<br>
<span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br></font></span></bl=
ockquote><div><br></div><div><div class=3D"gmail_default" style=3D"font-fam=
ily:monospace,monospace">Normally, the code that calls EVP_PKEY_get0_*() is=
 protected by a test EVP_PKEY_id() =3D=3D=C2=A0EVP_PKEY_*. The only case wh=
ere it&#39;s not is in=C2=A0tls_ctx_use_external_private_key() where it exe=
cutes the following code:=C2=A0</div><div class=3D"gmail_default" style=3D"=
font-family:monospace,monospace"><br></div><div class=3D"gmail_default"><di=
v class=3D"gmail_default"><font face=3D"monospace, monospace">=C2=A0 =C2=A0=
 pub_rsa =3D EVP_PKEY_get0_RSA(pkey);</font></div><div class=3D"gmail_defau=
lt"><font face=3D"monospace, monospace"><br></font></div><div class=3D"gmai=
l_default"><font face=3D"monospace, monospace">=C2=A0 =C2=A0 /* Certificate=
 might not be RSA but DSA or EC */</font></div><div class=3D"gmail_default"=
><font face=3D"monospace, monospace">=C2=A0 =C2=A0 if (!pub_rsa)</font></di=
v><div class=3D"gmail_default"><font face=3D"monospace, monospace"><div cla=
ss=3D"gmail_default">=C2=A0 =C2=A0 {</div><div class=3D"gmail_default">=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 crypto_msg(M_WARN, &quot;management-external-key r=
equires a RSA certificate&quot;);</div><div class=3D"gmail_default">=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 goto err;</div><div class=3D"gmail_default">=C2=A0 =C2=
=A0 }</div><div><br></div><div>But then, since pkey-&gt;pkey is an union, i=
t will return a non-null pointer when called on a DSA or EC key. I guess I =
wrongly assumed it was a struct (BTW, the code it replaced seemed to also a=
ssume pkey-&gt;pkey was a struct; that does not excuse my own failure).</di=
v><div><br></div><div>So a better (as in: more complete) fix would be to al=
so correct EVP_PKEY_get0_DSA() and EVP_PKEY_get0_EC_KEY() and to remove unn=
ecessary calls to EVP_PKEY_id() when it makes sense. I made this while writ=
ing this email and pushed the corresponding branch here:=C2=A0</div><div><b=
r></div><div><a href=3D"https://github.com/emmanuel-deloget/openvpn/tree/fi=
x-evp-pkey">https://github.com/emmanuel-deloget/openvpn/tree/fix-evp-pkey</=
a></div><div><br></div><div>I will send the patches on the ML as soon as I =
can.</div><div><br></div><div><br></div></font></div></div></div></div></di=
v><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><span class=3D"gmail-HOEnZb"><font color=
=3D"#888888">
Arne</font></span></blockquote><div><br></div><div>=C2=A0</div><div><div cl=
ass=3D"gmail_default" style=3D"font-family:monospace,monospace">=E2=80=8BBe=
st regards,=C2=A0</div><div class=3D"gmail_default" style=3D"font-family:mo=
nospace,monospace"><br></div><div class=3D"gmail_default" style=3D"font-fam=
ily:monospace,monospace">-- Emmanuel Deloget=E2=80=8B</div><br></div></div>=
</div></div>

--001a11408e1eb33fd30561ddcd70--

