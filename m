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
In-Reply-To: <CAKuzo_i9n6aJtLo1cGsdtLGK8RZR_ngN9LYKiHOwqFFAASdB3g@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 5 Oct 2021 12:39:57 -0400
Message-ID: <CAKuzo_g6EcwatKLL_LgZSJY0PX4d+NO7W40E3D9aRpFwAc9taw@...278...>
Content-Type: multipart/alternative; boundary="00000000000068ecf805cd9db909"
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
To: openvpn-devel@lists.sourceforge.net

--00000000000068ecf805cd9db909
Content-Type: text/plain; charset="UTF-8"

Hi

Here is an update on this patch set to keep all in the loop.

Arne discovered that my patch broke ECDH key exchange in some cases.  This
turns out to be due to the way providers are handled in OpenSSL especially
when used in a TLS context. It leads to the requirement that an external
provider has to handle a wide zoo of  key operations including key exchange
and key generation, even if all it wants to do is signing with an external
key. Essentially something like: "you either export the key to me or be
ready to import and handle all operations on any asymmetric key I may come
across". We can't export as the key is in a protected storage in some
backend,  we also do not want to do all that extra work that's not in the
contract, and we are not good at it either.

I have been engaging with OpenSSL developers on this and they realize this
was unintended, and is a "bug/weakness" in their implementation. They are
working on a patch to fix it at their end (
https://github.com/openssl/openssl/pull/16725). The eventual fix is very
likely to get backported to OpenSSL 3.0, so we have to wait.

I'll submit a slightly modified v2 once their fix is finalized.

Thanks,

Selva

>

--00000000000068ecf805cd9db909
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi<br></div><div class=3D"gmail_quote"><br></div><div=
 class=3D"gmail_quote">Here is an update on this patch set to keep all in t=
he loop.=C2=A0</div><div class=3D"gmail_quote"><br></div><div class=3D"gmai=
l_quote">Arne discovered that my patch broke ECDH key exchange in some case=
s.=C2=A0 This turns out to be due to the way providers are handled in OpenS=
SL especially when used in a TLS context. It leads to the requirement that =
an external provider has to handle a wide zoo of=C2=A0 key operations inclu=
ding key exchange and key generation, even if all it wants to do is signing=
 with an external key. Essentially something like: &quot;you either export =
the key to me or be ready to import and handle all operations on any asymme=
tric key I may come across&quot;. We can&#39;t export as the key is in a pr=
otected storage in some backend,=C2=A0 we also do not want to do all that e=
xtra work that&#39;s not in the contract, and we are not good at it either.=
</div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">I hav=
e been engaging=C2=A0with OpenSSL developers on this and they realize this =
was unintended, and is a &quot;bug/weakness&quot; in their implementation. =
They are working on a patch to fix it at their end (<a href=3D"https://gith=
ub.com/openssl/openssl/pull/16725">https://github.com/openssl/openssl/pull/=
16725</a>). The eventual fix is very likely to get backported to OpenSSL 3.=
0, so we have to wait.</div><div class=3D"gmail_quote"><br></div><div class=
=3D"gmail_quote">I&#39;ll submit a slightly modified v2 once their=C2=A0fix=
 is finalized.</div><div class=3D"gmail_quote"><br></div><div class=3D"gmai=
l_quote">Thanks,</div><div class=3D"gmail_quote"><br></div><div class=3D"gm=
ail_quote">Selva</div><div class=3D"gmail_quote"><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
</blockquote></div></div>

--00000000000068ecf805cd9db909--

