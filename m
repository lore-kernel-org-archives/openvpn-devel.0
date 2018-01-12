MIME-Version: 1.0
Sender: emmanueldeloget53@...277...
In-Reply-To: <CAKuzo_hVoa=_6yP3mmch4RUpt9Ds-wcukcDZr=pmu_q5qChfRg@...278...>
References: <cover.1515775195.git.logout@...260...>
 <3ea860bd412bbc9638cb54ade1a85ee08caf1b42.1515775195.git.logout@...260...>
 <CAKuzo_hVoa=_6yP3mmch4RUpt9Ds-wcukcDZr=pmu_q5qChfRg@...278...>
From: Emmanuel Deloget <logout@...260...>
Date: Fri, 12 Jan 2018 22:28:42 +0100
Message-ID: <CAKh=nwFOSOCugW1JWYfiQFZLTKRBc6qoi=U9ewzjOSpaGP1-Kg@...278...>
Content-Type: multipart/alternative; boundary="001a1141eb58e88fd105629af227"
Subject: Re: [Openvpn-devel] [PATCH 2/3] OpenSSL: remove some EVP_PKEY type
 checks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--001a1141eb58e88fd105629af227
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Selva,

On Fri, Jan 12, 2018 at 6:09 PM, Selva Nair <selva.nair@...277...> wrote:

> Hi,
>
> I will defer to crypto experts for a proper review, but a quick remark
>
> On Fri, Jan 12, 2018 at 11:48 AM, Emmanuel Deloget <logout@...260...> wro=
te:
> > Calling EVP_KEY_id() before EVP_PKEY_get0_*() is unnecessary as
> > the same check is also performed in the later.
> >
> >
> ...
>
> > +            RSA *rsa =3D NULL;
> > +            DSA *dsa =3D NULL;
> >  #ifndef OPENSSL_NO_EC
> > -            else if ((EVP_PKEY_id(pkey) =3D=3D EVP_PKEY_EC) &&
> (EVP_PKEY_get0_EC_KEY(pkey) !=3D NULL))
> > +            EC *ec =3D NULL;
>
> That looks wrong: do you mean EC_KEY instead of EC?
>


=E2=80=8BI definitely mean EC_KEY instead of EC. =E2=80=8B

My bad. I'm sending a new version of this patch.


>
> > +
> > +            if ((ec =3D EVP_PKEY_get0_EC_KEY(pkey)) !=3D NULL)
>
> Selva
>

=E2=80=8BBR,

-- Emmanuel Deloget=E2=80=8B

--001a1141eb58e88fd105629af227
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:monospac=
e,monospace">Hello Selva,=C2=A0</div><div class=3D"gmail_extra"><br><div cl=
ass=3D"gmail_quote">On Fri, Jan 12, 2018 at 6:09 PM, Selva Nair <span dir=
=3D"ltr">&lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_blank">selv=
a.nair@...277...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi=
,<br>
<br>
I will defer to crypto experts for a proper review, but a quick remark<br>
<span class=3D""><br>
On Fri, Jan 12, 2018 at 11:48 AM, Emmanuel Deloget &lt;<a href=3D"mailto:lo=
gout@...260...">logout@...260...</a>&gt; wrote:<br>
&gt; Calling EVP_KEY_id() before EVP_PKEY_get0_*() is unnecessary as<br>
&gt; the same check is also performed in the later.<br>
&gt;<br>
&gt;<br>
</span>...<br>
<span class=3D""><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RSA *rsa =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DSA *dsa =3D NULL;<br>
&gt;=C2=A0 #ifndef OPENSSL_NO_EC<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if ((EVP_PKEY_id(pkey)=
 =3D=3D EVP_PKEY_EC) &amp;&amp; (EVP_PKEY_get0_EC_KEY(pkey) !=3D NULL))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 EC *ec =3D NULL;<br>
<br>
</span>That looks wrong: do you mean EC_KEY instead of EC?<br></blockquote>=
<div><br></div><div><div class=3D"gmail_default" style=3D"font-family:monos=
pace,monospace"><br></div><div class=3D"gmail_default" style=3D"font-family=
:monospace,monospace">=E2=80=8BI definitely mean EC_KEY instead of EC. =E2=
=80=8B</div><div class=3D"gmail_default" style=3D"font-family:monospace,mon=
ospace"><br></div><div class=3D"gmail_default" style=3D"font-family:monospa=
ce,monospace">My bad. I&#39;m sending a new version of this patch.=C2=A0</d=
iv></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((ec =3D EVP_PKEY_get0_E=
C_KEY(pkey)) !=3D NULL)<br>
<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">Selva<br></font>=
</span></blockquote><div><br></div><div class=3D"gmail_default" style=3D"fo=
nt-family:monospace,monospace">=E2=80=8BBR,=C2=A0</div><div class=3D"gmail_=
default" style=3D"font-family:monospace,monospace"><br></div><div class=3D"=
gmail_default" style=3D"font-family:monospace,monospace">-- Emmanuel Deloge=
t=E2=80=8B</div></div><br></div></div>

--001a1141eb58e88fd105629af227--

