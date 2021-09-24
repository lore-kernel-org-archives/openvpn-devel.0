MIME-Version: 1.0
References: <20210922211254.7570-1-selva.nair@...277...>
 <a7c18fd1-7c90-c353-8506-e6ccb36282e6@...1227...>
 <CAKuzo_jQvbGX8OEM4-c82F77gqyiCEyeVW-fVbt7EK=0p9kFZw@...278...>
 <CAKuzo_iGD2MGVOBf6+pegEYA0_VdnWKZbheaizshvqbOHB=h8g@...278...>
 <6a3a0ed8-5c38-a29d-bf71-a7555950e0c2@...1227...>
 <CAKuzo_gYfbtxiyW1HggYtGsFDdva_buegw0eSi=KFrQ-Yy9WXQ@...278...>
In-Reply-To: <CAKuzo_gYfbtxiyW1HggYtGsFDdva_buegw0eSi=KFrQ-Yy9WXQ@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 24 Sep 2021 13:14:34 -0400
Message-ID: <CAKuzo_iMTaRMNM2b_GsYDwFzMXw=Aw0UP+5e04QqGgLHQaPPEQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000da3a1405ccc0eccd"
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

--000000000000da3a1405ccc0eccd
Content-Type: text/plain; charset="UTF-8"

Hi Arne,

On Fri, Sep 24, 2021 at 8:48 AM Selva Nair <selva.nair@...277...> wrote:

> Hi,
>
> On Fri, Sep 24, 2021 at 7:13 AM Arne Schwabe <arne@...1227...> wrote:
>
>> Am 24.09.21 um 00:54 schrieb Selva Nair:
>> > Hi,
>> >
>> >
>> >         from the management interface. But I haven't found the right
>> >         Signature
>> >         method from java yet to actually sign it correctly:
>> >
>> >         sig = Signature.getInstance(SHA256withRSA/PSS);
>> >
>> >
>> > SHA256withRSA/PSS may be trying to first do Sha256 digest of the data
>> > and then pad and sign. Instead try this: "NonewithRSASSA-PSS" or
>> > "NonewithRSA/PSS"
>>
>> Yeah, That *would* be the correct algorithm for that. Unfortunately the
>> Android Keystore does not support that one
>> (
>> https://developer.android.com/training/articles/keystore#SupportedSignatures
>> )
>>
>
> We can treat management-external key as special and optionally provide the
> digest to sign. OpenSSL 3.0 with provider always seem to call DigestSign
> and never Sign directly so we have the info.
>

Turns out to be easier than I thought. I have added a patch to optionally
send the undigested message to the management client. Indicate support for
digesting operation in --management-external-key and you get the message to
sign with data=message

See the commit message. It's in
https://github.com/selvanair/openvpn/tree/xkey-provider-v3   (only compile
tested).

Selva
PS. I'm supposed to be holidaying, but basking in LCD glow instead of sun..

--000000000000da3a1405ccc0eccd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Arne,</div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 24, 2021 at 8:48 AM S=
elva Nair &lt;<a href=3D"mailto:selva.nair@...277...">selva.nair@...277...<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Sep 24, 2021 at 7:13 AM Arne Schwabe &lt;<a=
 href=3D"mailto:arne@...1227..." target=3D"_blank">arne@...1227...</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Am 24.09.=
21 um 00:54 schrieb Selva Nair:<br>
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
eem to call DigestSign and never Sign directly so we have the info.=C2=A0<b=
r></div></div></div></blockquote><div><br></div><div>Turns out to be easier=
 than I thought. I have added a patch to optionally send the undigested mes=
sage to the management client. Indicate support for digesting operation in =
--management-external-key and you get the message to sign with data=3Dmessa=
ge</div><div><br></div><div>See the commit message. It&#39;s in=C2=A0=C2=A0=
<a href=3D"https://github.com/selvanair/openvpn/tree/xkey-provider-v3">http=
s://github.com/selvanair/openvpn/tree/xkey-provider-v3</a>=C2=A0 =C2=A0(onl=
y compile tested).=C2=A0</div><div><br></div><div>Selva</div><div>PS. I&#39=
;m supposed to be holidaying, but basking in LCD=C2=A0glow instead of sun..=
</div></div></div>

--000000000000da3a1405ccc0eccd--

