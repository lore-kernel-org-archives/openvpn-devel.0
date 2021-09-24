MIME-Version: 1.0
References: <20210922211254.7570-1-selva.nair@...277...>
 <a7c18fd1-7c90-c353-8506-e6ccb36282e6@...1227...>
 <CAKuzo_jQvbGX8OEM4-c82F77gqyiCEyeVW-fVbt7EK=0p9kFZw@...278...>
 <CAKuzo_iGD2MGVOBf6+pegEYA0_VdnWKZbheaizshvqbOHB=h8g@...278...>
 <6a3a0ed8-5c38-a29d-bf71-a7555950e0c2@...1227...>
In-Reply-To: <6a3a0ed8-5c38-a29d-bf71-a7555950e0c2@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 24 Sep 2021 08:48:20 -0400
Message-ID: <CAKuzo_gYfbtxiyW1HggYtGsFDdva_buegw0eSi=KFrQ-Yy9WXQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000c71fc005ccbd3404"
Subject: Re: [Openvpn-devel] [PATCH 0/9] A built-in OpenSSL3.0 provider for
 external-keys
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

--000000000000c71fc005ccbd3404
Content-Type: text/plain; charset="UTF-8"

Hi,

On Fri, Sep 24, 2021 at 7:13 AM Arne Schwabe <arne@...1227...> wrote:

> Am 24.09.21 um 00:54 schrieb Selva Nair:
> > Hi,
> >
> >
> >         from the management interface. But I haven't found the right
> >         Signature
> >         method from java yet to actually sign it correctly:
> >
> >         sig = Signature.getInstance(SHA256withRSA/PSS);
> >
> >
> > SHA256withRSA/PSS may be trying to first do Sha256 digest of the data
> > and then pad and sign. Instead try this: "NonewithRSASSA-PSS" or
> > "NonewithRSA/PSS"
>
> Yeah, That *would* be the correct algorithm for that. Unfortunately the
> Android Keystore does not support that one
> (
> https://developer.android.com/training/articles/keystore#SupportedSignatures
> )
>

We can treat management-external key as special and optionally provide the
digest to sign. OpenSSL 3.0 with provider always seem to call DigestSign
and never Sign directly so we have the info.

I already have key->origin indication which was originally meant to
distinguish between various external libraries -- in the end I simplified
that a bit. So its easy to treat management external key differently from
other external keys. So for management it would a digest_sign callback if
"--management-external-key digest" is specified, or some such. Harder part
would be to get access to options->management_flags into xkey_helper.c -- I
have tried to keep a max separation between it and the core and would like
to keep it that way.

Or make another ifdef for ANDROID... ahem..

I'll look into it. Probably your app is the only --management-external-key
"consumer" out there. We can even change the spec of PK_SIG and no one will
notice..

Manually adding the RSA/PSS padding and then signing with
> "RSA/ECB/NoPadding" like I did in OpenSSL 1.1 days works. But I would
> like to avoid implementing RSA/PSS myself but the crypto libraries seem
> not be helpful in providing an implementation for that.
>

Yeah, that's not good.


> But on the plus side, using that workaround the external key provider
> works with EC and RSA on Android.
>

Great!

Selva

--000000000000c71fc005ccbd3404
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Fri, Sep 24, 2021 at 7:13 AM Arne Schwabe &lt;<=
a href=3D"mailto:arne@...1227..." target=3D"_blank">arne@...1227...</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Am 24.09=
.21 um 00:54 schrieb Selva Nair:<br>
&gt; Hi,<br>
&gt; =C2=A0<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from the management interface. But I =
haven&#39;t found the right<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Signature<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0method from java yet to actually sign=
 it correctly:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sig =3D Signature.getInstance(SHA256w=
ithRSA/PSS);<br>
&gt; <br>
&gt; <br>
&gt; SHA256withRSA/PSS may be trying to first do Sha256 digest of the data<=
br>
&gt; and then pad and sign. Instead try this: &quot;NonewithRSASSA-PSS&quot=
; or<br>
&gt; &quot;NonewithRSA/PSS&quot;<br>
<br>
Yeah, That *would* be the correct algorithm for that. Unfortunately the<br>
Android Keystore does not support that one<br>
(<a href=3D"https://developer.android.com/training/articles/keystore#Suppor=
tedSignatures" rel=3D"noreferrer" target=3D"_blank">https://developer.andro=
id.com/training/articles/keystore#SupportedSignatures</a>)<br></blockquote>=
<div><br></div><div>We can=C2=A0treat management-external key as special an=
d optionally provide the digest to sign. OpenSSL 3.0 with provider always s=
eem to call DigestSign and never Sign directly so we have the info.=C2=A0</=
div><div><br></div><div>I already have key-&gt;origin indication which was =
originally meant to distinguish between various external libraries -- in th=
e end I simplified that a bit. So its easy to treat=C2=A0management externa=
l key differently from other external keys. So for management it would a di=
gest_sign callback if &quot;--management-external-key digest&quot; is speci=
fied, or some such. Harder part would be to get access to options-&gt;manag=
ement_flags into xkey_helper.c -- I have tried to keep a max separation bet=
ween it and the core and would like to keep it that way.</div><div><br></di=
v><div>Or make another ifdef for ANDROID... ahem..</div><div><br></div><div=
>I&#39;ll look into it. Probably your app is the only --management-external=
-key &quot;consumer&quot; out there. We can even change the spec of PK_SIG =
and no one will notice..</div><div><br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
Manually adding the RSA/PSS padding and then signing with<br>
&quot;RSA/ECB/NoPadding&quot; like I did in OpenSSL 1.1 days works. But I w=
ould<br>
like to avoid implementing RSA/PSS myself but the crypto libraries seem<br>
not be helpful in providing an implementation for that.<br></blockquote><di=
v><br></div><div>Yeah, that&#39;s not good.</div><div><br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex"><br>
But on the plus side, using that workaround the external key provider<br>
works with EC and RSA on Android.<br></blockquote><div><br></div><div>Great=
!</div><div><br></div><div>Selva=C2=A0</div></div></div>

--000000000000c71fc005ccbd3404--

