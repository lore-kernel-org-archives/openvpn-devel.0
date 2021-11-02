MIME-Version: 1.0
References: <20210922211254.7570-1-selva.nair@...277...>
 <a7c18fd1-7c90-c353-8506-e6ccb36282e6@...1227...>
 <CAKuzo_jQvbGX8OEM4-c82F77gqyiCEyeVW-fVbt7EK=0p9kFZw@...278...>
 <CAKuzo_iGD2MGVOBf6+pegEYA0_VdnWKZbheaizshvqbOHB=h8g@...278...>
 <6a3a0ed8-5c38-a29d-bf71-a7555950e0c2@...1227...>
 <CAKuzo_gYfbtxiyW1HggYtGsFDdva_buegw0eSi=KFrQ-Yy9WXQ@...278...>
 <CAKuzo_iMTaRMNM2b_GsYDwFzMXw=Aw0UP+5e04QqGgLHQaPPEQ@...278...>
 <882f9257-9c7e-8a08-2324-76c182ac0f9d@...1227...>
 <e556418b-c5d7-49c7-e741-c8aed0a95ad8@...1227...>
 <CAKuzo_i9n6aJtLo1cGsdtLGK8RZR_ngN9LYKiHOwqFFAASdB3g@...278...>
 <CAKuzo_g6EcwatKLL_LgZSJY0PX4d+NO7W40E3D9aRpFwAc9taw@...278...>
In-Reply-To: <CAKuzo_g6EcwatKLL_LgZSJY0PX4d+NO7W40E3D9aRpFwAc9taw@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 2 Nov 2021 00:40:50 -0400
Message-ID: <CAKuzo_jejaV=PpoT3vmdJj8BcipMs7WLDuiahWYxuemi7cnBGA@...278...>
Content-Type: multipart/alternative; boundary="000000000000dc453d05cfc6e687"
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000dc453d05cfc6e687
Content-Type: text/plain; charset="UTF-8"

Hi,

OpenSSL folks have merged their "fix" in the provider interface that I was
waiting for. It will be in the 3.0.1 patch release. In the meantime, I have
opened a matching version of this patch set as a PR for OpenVPN for
comments/tests/bug-reports/nitpicks. I skipped v2 and this version is
tagged v3.

Will post the patches to the list when OpenSSL 3.0.1 is released.

On top of v1 patches this also includes handling pkcs11-id and
cryptoapicert options through the provider. Requires OpenSSL from either
the master branch (3.1.0-dev) or 3.0 branch (3.0.1-dev) post Oct. 27.

Cheers,

Selva

On Tue, Oct 5, 2021 at 12:39 PM Selva Nair <selva.nair@...277...> wrote:

> Hi
>
> Here is an update on this patch set to keep all in the loop.
>
> Arne discovered that my patch broke ECDH key exchange in some cases.  This
> turns out to be due to the way providers are handled in OpenSSL especially
> when used in a TLS context. It leads to the requirement that an external
> provider has to handle a wide zoo of  key operations including key exchange
> and key generation, even if all it wants to do is signing with an external
> key. Essentially something like: "you either export the key to me or be
> ready to import and handle all operations on any asymmetric key I may come
> across". We can't export as the key is in a protected storage in some
> backend,  we also do not want to do all that extra work that's not in the
> contract, and we are not good at it either.
>
> I have been engaging with OpenSSL developers on this and they realize this
> was unintended, and is a "bug/weakness" in their implementation. They are
> working on a patch to fix it at their end (
> https://github.com/openssl/openssl/pull/16725). The eventual fix is very
> likely to get backported to OpenSSL 3.0, so we have to wait.
>
> I'll submit a slightly modified v2 once their fix is finalized.
>
> Thanks,
>
> Selva
>
>>

--000000000000dc453d05cfc6e687
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>OpenSSL folks have merged their &qu=
ot;fix&quot; in the provider interface that I was waiting for. It will be i=
n the 3.0.1 patch release. In the meantime, I have opened a matching versio=
n of this patch set as a PR for OpenVPN for comments/tests/bug-reports/nitp=
icks. I skipped v2 and this version is tagged v3.</div><div><br></div><div>=
Will post the patches to the list when OpenSSL 3.0.1 is released.</div><div=
><br></div><div>On top of v1 patches this also includes handling pkcs11-id =
and cryptoapicert options through the provider. Requires OpenSSL from eithe=
r the master branch (3.1.0-dev) or 3.0 branch (3.0.1-dev) post Oct. 27.</di=
v><div><br></div><div>Cheers,</div><div><br></div><div>Selva</div></div><br=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, O=
ct 5, 2021 at 12:39 PM Selva Nair &lt;<a href=3D"mailto:selva.nair@...1663...=
." target=3D"_blank">selva.nair@...277...</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>Hi<br></div>=
<div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">Here is an =
update on this patch set to keep all in the loop.=C2=A0</div><div class=3D"=
gmail_quote"><br></div><div class=3D"gmail_quote">Arne discovered that my p=
atch broke ECDH key exchange in some cases.=C2=A0 This turns out to be due =
to the way providers are handled in OpenSSL especially when used in a TLS c=
ontext. It leads to the requirement that an external provider has to handle=
 a wide zoo of=C2=A0 key operations including key exchange and key generati=
on, even if all it wants to do is signing with an external key. Essentially=
 something like: &quot;you either export the key to me or be ready to impor=
t and handle all operations on any asymmetric key I may come across&quot;. =
We can&#39;t export as the key is in a protected storage in some backend,=
=C2=A0 we also do not want to do all that extra work that&#39;s not in the =
contract, and we are not good at it either.</div><div class=3D"gmail_quote"=
><br></div><div class=3D"gmail_quote">I have been engaging=C2=A0with OpenSS=
L developers on this and they realize this was unintended, and is a &quot;b=
ug/weakness&quot; in their implementation. They are working on a patch to f=
ix it at their end (<a href=3D"https://github.com/openssl/openssl/pull/1672=
5" target=3D"_blank">https://github.com/openssl/openssl/pull/16725</a>). Th=
e eventual fix is very likely to get backported to OpenSSL 3.0, so we have =
to wait.</div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quot=
e">I&#39;ll submit a slightly modified v2 once their=C2=A0fix is finalized.=
</div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">Thank=
s,</div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">Sel=
va</div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
</blockquote></div></div>
</blockquote></div>

--000000000000dc453d05cfc6e687--

