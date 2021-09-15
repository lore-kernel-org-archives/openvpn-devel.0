MIME-Version: 1.0
References: <604d3782-646c-4f12-b789-2ae9ebbae069@...515...>
 <42e7467d-67b9-a6c3-6348-bb1d1e0ef21c@...515...>
In-Reply-To: <42e7467d-67b9-a6c3-6348-bb1d1e0ef21c@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 15 Sep 2021 10:36:51 -0400
Message-ID: <CAKuzo_hA34XJP-uz7VgC0mkDdd+48-dOURxqjfhik6fjbsNK-Q@...278...>
Content-Type: multipart/alternative; boundary="0000000000003bd11c05cc09ac87"
Subject: Re: [Openvpn-devel] Summary of the community meeting (15th
 September 2021)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000003bd11c05cc09ac87
Content-Type: text/plain; charset="UTF-8"

Hi,


> Plaisthos is preparing patches that drop support for the APIs that are
> deprecated in OpenSSL 3.0.
>
> Agreed that the OpenSSL 3.0 patches should be master only, so only 2.6
> will have full OpenSSL 3.0 support with external key support and without
> compiler warnings.


Good to see some discussion on OpenSSL 3.0 support. I'm working on
converting "cryptoapicert" to use a custom built-in provider. In fact, the
provider framework could be common for all external keys (cryptoapicert,
management-external-key and pkcs11) with only the key loading and signing
ops redirected to respective backends.

If Arne is adding a provider implementation for this, maybe I should hold
off?

Even otherwise, cryptoapicert.c needs some real cleanup -- I want to remove
support for legacy keys (one's with drivers not compatible with the new
crypto API in Windows -- CNG).

Such tokens can be still used with pkcs11-helper assuming we'll continue to
ship it with 2.6 Windows releases. The pkcs11-helper library will have to
built with deprecated API enabled.

Any thoughts?

Selva

--0000000000003bd11c05cc09ac87
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>Hi,</div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">Plaisthos is preparing pa=
tches that drop support for the APIs that are <br>
deprecated in OpenSSL 3.0.<br>
<br>
Agreed that the OpenSSL 3.0 patches should be master only, so only 2.6 <br>
will have full OpenSSL 3.0 support with external key support and without <b=
r>
compiler warnings.=C2=A0</blockquote><div>=C2=A0</div><div>Good to see some=
 discussion on OpenSSL 3.0 support. I&#39;m working on converting &quot;cry=
ptoapicert&quot; to use a custom built-in provider. In fact, the provider f=
ramework could be common for all external keys (cryptoapicert, management-e=
xternal-key and pkcs11) with only the key loading and signing ops redirecte=
d to respective backends.=C2=A0</div><div><br></div><div>If Arne is adding =
a provider implementation for this, maybe I should=C2=A0hold off?</div><div=
><br></div><div>Even otherwise, cryptoapicert.c needs some real cleanup -- =
I want to remove support for legacy keys (one&#39;s with drivers not compat=
ible with the new crypto API in Windows -- CNG).=C2=A0</div><div><br></div>=
<div>Such tokens can be still used with pkcs11-helper assuming we&#39;ll co=
ntinue to ship it with 2.6 Windows releases. The pkcs11-helper library will=
 have to built with deprecated API enabled.</div><div><br></div><div>Any th=
oughts?</div><div><br></div><div>Selva</div></div></div>

--0000000000003bd11c05cc09ac87--

