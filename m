MIME-Version: 1.0
References: <20210922211254.7570-1-selva.nair@...277...>
 <a7c18fd1-7c90-c353-8506-e6ccb36282e6@...1227...>
In-Reply-To: <a7c18fd1-7c90-c353-8506-e6ccb36282e6@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 23 Sep 2021 18:16:05 -0400
Message-ID: <CAKuzo_jQvbGX8OEM4-c82F77gqyiCEyeVW-fVbt7EK=0p9kFZw@...278...>
Content-Type: multipart/alternative; boundary="0000000000004fc0d105ccb10530"
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

--0000000000004fc0d105ccb10530
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 23, 2021 at 4:21 PM Arne Schwabe <arne@...1227...> wrote:

> Am 22.09.21 um 23:12 schrieb selva.nair@...277...:
> > From: Selva Nair <selva.nair@...277...>
> >
> > The following series of patches implement a built-in
> > provider for interfacing OpenSSL 3.0 when external
> > keys are in use.
> >
> > Essentially, to intercept the sign operation, the SSL_CTX
> > object has to be created with properties string set to
> > prioritize our provider. In the provider we implement
> > only keymgmt and signature operations and specify the
> > property string as optional. That allows all operations
> > we do not provide to be used from the default provider.
> >
> > This patch set stops at interfacing the provider with
> > management-external-key. For pkcs11-helper, only some glue
> > code is needed and is in the works. Same with cryptoapicert
> >  aka CNG, but I want to cleanup the old code a bit before
> > hooking to the provider.
>
> I did a quick test with my Android client to see if it works and RSA
> keys look good so far. I am getting a request like:
>
>
> NC9t8IkYrjAQcCzc85zN0H5TvwfAUDwYkR4j2ga6fGw=,RSA_PKCS1_PSS_PADDING,hashalg=SHA256,saltlen=digest
>
> from the management interface. But I haven't found the right Signature
> method from java yet to actually sign it correctly:
>
> sig = Signature.getInstance(SHA256withRSA/PSS);
> sig.setParameter(new PSSParameterSpec("SHA-256", "MGF1",
> MGF1ParameterSpec.SHA256, 32, 1));
> sig.initSign(privkey);
> sig.update(data);
> signed_bytes = sig.sign();
>

I'm not sure, but  can upload my implementation of pkcs11 including PSS
though it wont work yet with pkcs11-helper.. It needs my CK_MECHANISM patch
that Alon has merged, but not released.

It may give you some clue as to what could be wrong.


>
> is what I expected to be the correct signature but the server complains
> with OpenSSL: error:0407E068:rsa routines:RSA_verify_PKCS1_PSS_mgf1:bad
> signature
>
> I will have to figure out where this goes wrong.
>
> With an EC key somewhere in that stack, EC/RSA gets confuse as there is
> rsa_keymgmt_import/rsa_keymgmt_name in the stack and then later
> ec_keymgmt_name. I haven't digged into that as it is getting late here.
>

Yes, there is a bug in ec_keymgmt_name -- we should return the name for the
op (passed as id), so when id == OSSL_OP_SIGNATURE we should return
"ECDSA", not "EC". My mistake -- I testd EC key only just now.

As we do not support any other ops like ECDH key exchange we can just
always return "ECDSA" in that function. I will do it v2, later.
Unfortunately none of this is documented it seems.

Selva

--0000000000004fc0d105ccb10530
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 23, 2021 at 4:21 PM Arne =
Schwabe &lt;<a href=3D"mailto:arne@...1227...">arne@...1227...</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Am 22.09.21 u=
m 23:12 schrieb <a href=3D"mailto:selva.nair@...277..." target=3D"_blank">s=
elva.nair@...277...</a>:<br>
&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D=
"_blank">selva.nair@...277...</a>&gt;<br>
&gt; <br>
&gt; The following series of patches implement a built-in<br>
&gt; provider for interfacing OpenSSL 3.0 when external <br>
&gt; keys are in use.<br>
&gt; <br>
&gt; Essentially, to intercept the sign operation, the SSL_CTX<br>
&gt; object has to be created with properties string set to <br>
&gt; prioritize our provider. In the provider we implement<br>
&gt; only keymgmt and signature operations and specify the<br>
&gt; property string as optional. That allows all operations<br>
&gt; we do not provide to be used from the default provider.<br>
&gt; <br>
&gt; This patch set stops at interfacing the provider with<br>
&gt; management-external-key. For pkcs11-helper, only some glue<br>
&gt; code is needed and is in the works. Same with cryptoapicert<br>
&gt;=C2=A0 aka CNG, but I want to cleanup the old code a bit before<br>
&gt; hooking to the provider.<br>
<br>
I did a quick test with my Android client to see if it works and RSA<br>
keys look good so far. I am getting a request like:<br>
<br>
NC9t8IkYrjAQcCzc85zN0H5TvwfAUDwYkR4j2ga6fGw=3D,RSA_PKCS1_PSS_PADDING,hashal=
g=3DSHA256,saltlen=3Ddigest<br>
<br>
from the management interface. But I haven&#39;t found the right Signature<=
br>
method from java yet to actually sign it correctly:<br>
<br>
sig =3D Signature.getInstance(SHA256withRSA/PSS);<br>
sig.setParameter(new PSSParameterSpec(&quot;SHA-256&quot;, &quot;MGF1&quot;=
,<br>
MGF1ParameterSpec.SHA256, 32, 1));<br>
sig.initSign(privkey);<br>
sig.update(data);<br>
signed_bytes =3D sig.sign();<br></blockquote><div><br></div><div>I&#39;m no=
t sure, but=C2=A0 can upload my implementation of pkcs11 including PSS thou=
gh it wont work yet with pkcs11-helper.. It needs my CK_MECHANISM patch tha=
t Alon has merged, but not released.</div><div><br></div><div>It may give y=
ou some clue as to what could be wrong.</div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
<br>
is what I expected to be the correct signature but the server complains<br>
with OpenSSL: error:0407E068:rsa routines:RSA_verify_PKCS1_PSS_mgf1:bad<br>
signature<br>
<br>
I will have to figure out where this goes wrong.<br>
<br>
With an EC key somewhere in that stack, EC/RSA gets confuse as there is<br>
rsa_keymgmt_import/rsa_keymgmt_name in the stack and then later<br>
ec_keymgmt_name. I haven&#39;t digged into that as it is getting late here.=
<br></blockquote><div><br></div><div>Yes, there is a bug in ec_keymgmt_name=
 -- we should return the name for the op (passed as id), so when id =3D=3D =
OSSL_OP_SIGNATURE we should return &quot;ECDSA&quot;, not &quot;EC&quot;. M=
y mistake -- I testd EC key only just now.=C2=A0</div><div><br></div><div>A=
s we do not support any other ops like ECDH key exchange we can just always=
 return &quot;ECDSA&quot; in that function. I will do it v2, later. Unfortu=
nately none of this is documented it seems.</div><div><br></div><div>Selva<=
/div></div></div>

--0000000000004fc0d105ccb10530--

