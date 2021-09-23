MIME-Version: 1.0
References: <20210922211254.7570-1-selva.nair@...277...>
 <a7c18fd1-7c90-c353-8506-e6ccb36282e6@...1227...>
 <CAKuzo_jQvbGX8OEM4-c82F77gqyiCEyeVW-fVbt7EK=0p9kFZw@...278...>
In-Reply-To: <CAKuzo_jQvbGX8OEM4-c82F77gqyiCEyeVW-fVbt7EK=0p9kFZw@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 23 Sep 2021 18:54:46 -0400
Message-ID: <CAKuzo_iGD2MGVOBf6+pegEYA0_VdnWKZbheaizshvqbOHB=h8g@...278...>
Content-Type: multipart/alternative; boundary="000000000000b2c8e605ccb18fd4"
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

--000000000000b2c8e605ccb18fd4
Content-Type: text/plain; charset="UTF-8"

Hi,


> from the management interface. But I haven't found the right Signature
>> method from java yet to actually sign it correctly:
>>
>> sig = Signature.getInstance(SHA256withRSA/PSS);
>>
>
SHA256withRSA/PSS may be trying to first do Sha256 digest of the data and
then pad and sign. Instead try this: "NonewithRSASSA-PSS" or
"NonewithRSA/PSS"


> sig.setParameter(new PSSParameterSpec("SHA-256", "MGF1",
>> MGF1ParameterSpec.SHA256, 32, 1));
>> sig.initSign(privkey);
>> sig.update(data);
>> signed_bytes = sig.sign();
>
>
>>
You would still need SHA-256 in the PSSParameterSpec.

Selva

--000000000000b2c8e605ccb18fd4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>Hi,</div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div cla=
ss=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
from the management interface. But I haven&#39;t found the right Signature<=
br>
method from java yet to actually sign it correctly:<br>
<br>
sig =3D Signature.getInstance(SHA256withRSA/PSS);<br></blockquote></div></d=
iv></blockquote><div><br></div><div>SHA256withRSA/PSS may be trying to firs=
t do Sha256 digest of the data and then pad and sign. Instead try this: &qu=
ot;NonewithRSASSA-PSS&quot; or &quot;NonewithRSA/PSS&quot;</div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><d=
iv class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
sig.setParameter(new PSSParameterSpec(&quot;SHA-256&quot;, &quot;MGF1&quot;=
,<br>
MGF1ParameterSpec.SHA256, 32, 1));<br>
sig.initSign(privkey);<br>
sig.update(data);<br>
signed_bytes =3D sig.sign();</blockquote><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex"><br></blockquote></div></div></blockquote><div><br></div><d=
iv>You would still need SHA-256 in the PSSParameterSpec.</div><div><br></di=
v><div>Selva</div><div>=C2=A0</div></div></div>

--000000000000b2c8e605ccb18fd4--

