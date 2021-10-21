MIME-Version: 1.0
References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-13-arne@...1227...>
 <CAKuzo_h6zwNySb7iu=bFGduxH7jB2OT_2TopZ0gYdYPmpRTO=g@...278...>
 <5554b1a1-02ec-a0af-c045-58aa999ed66f@...1227...>
In-Reply-To: <5554b1a1-02ec-a0af-c045-58aa999ed66f@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 21 Oct 2021 12:01:52 -0400
Message-ID: <CAKuzo_i+eN4Juj70S3v25wHwJepW69MGPEONHN=D1pQbSBK7PA@...278...>
Content-Type: multipart/alternative; boundary="00000000000063b4a605cedf0463"
Subject: Re: [Openvpn-devel] [PATCH v3 12/21] [OSSL 3.0] Allow loading of
 non default providers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--00000000000063b4a605cedf0463
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 21, 2021 at 8:52 AM Arne Schwabe <arne@...1227...> wrote:

> Am 20.10.21 um 20:19 schrieb Selva Nair:
> > Hi,
> >
> > Not a code review but a general comment as this is a new option that
> > warrants some discussion.
> >
> > On Tue, Oct 19, 2021 at 2:32 PM Arne Schwabe <arne@...1227...
> > <mailto:arne@...1227...>> wrote:
> >
> >     This allows OpenVPN to load non-default providers. This is mainly
> >     useful for loading the legacy provider with --provider legacy:default
> >
> >
> > While this format looks okay, we need to consider a few things to get
> > this option right and possibly extensible in future without causing a
> > regression.
> >
> > (i) Provider name may not be a simple word like legacy -- could also be
> > the path to a shared object with possible embedded space in the path
> > name. A single option with optional quotes, picked apart using ":" as
> > separator can still work.
> >
> > Ideally I would have preferred space separated provider names with
> > each quoted if needed, but the format proposed here may be easier to
> > parse. Need clear documentation, though.
>
>
> Yeah using : was easier to parse since I need otherwise to setup an
> array or a list to store the parameter but it is doable. I was just
> hoping that nobody would use a : in the provider name.
>

Use of '.' in the name is the recommended method to have a namespace in the
provider name and reduce chances of name conflict. No one may use ':' and
filenames are unlikely to contain ':' as its not legal in some platforms.

That said, adding an array or list is easier than it looks. We have several
options that use an array or list and the code overhead is small.


>
> > (ii) We may want to attach some meaning to the order in which providers
> > are specified.
>
> That would be mostly a documentation thing to explain that the providers
> are loaded the in order specified with that option.


> Here is why:
> >
> > When multiple providers implement the same method (say, KEYEXCH), there
> > is no guarantee in OpenSSL as to which will get used. Unless a property
> > query like "?provider=my-fast-aes" is also used. Here the prefix "?" to
> > mean preferred but not exclusive. In cases like an pkcs11 token
> > provider, one would need to say the opposite like "?provider=default" to
> > ensure default is preferred and the token provider is to be used only
> > when required -- say when the key is in a token. Same would be the case
> > with our proposed built-in  "external-key provider" which should be used
> > only for certain operations that handle the external key.
> >
> > How this relates to the --provider option is like this: in some cases we
> > want to know which provider the user prefers. Instead of hard-coding the
> > preferred provider to "default" which the user may not even want to
> > load. We could state that the first provider specified will become the
> > preferred one when there are multiple choices for a method or when a
> > preferred fallback is required. In that case the option for legacy would
> be
> >
> > --provider default:legacy
> >
> > And, if this option is absent, we take it to mean that the "default"
> > provider should be loaded.
>
> I would not explicitly load the default provider then but rather inherit
> what the system gives us. If the system wide config loads fips we should
> not load default instead.
>

IMO, this idea that OpenSSL folks have that just adding a "fips=yes" plus a
few lines in the config can make the application FIPS enabled is
far-fetched. In reality OpenVPN will have to be recompiled with some
changes to make it FIPS compliant. At that point one can also change what
providers are loaded by default.

I was thinking of having a load_providers() function called early -- say in
options-post-process stage where we load

(i) default provider
(ii) providers specified in --providers option

This adds much certainty to what is available. A FIPS-enabled OpenVPN can
change this or we could have a --fips option that changes this. No
dependency on system-wide config file and those who need legacy only need
to just specify "--providers legacy"

In addition, one could automatically load "legacy" if any of the options
indicate its need -- like NTLM auth for proxy or BF-CBC in --data-ciphers
etc. In situations where it cannot be inferred from options, user will have
to use --providers legacy, though.

It may be necessary to call this load_providers() also to process options
like --show-ciphers and similar.

Selva

--00000000000063b4a605cedf0463
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 21, 2021 at 8:52 AM Arne =
Schwabe &lt;<a href=3D"mailto:arne@...1227...">arne@...1227...</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Am 20.10.21 u=
m 20:19 schrieb Selva Nair:<br>
&gt; Hi,<br>
&gt; <br>
&gt; Not a code review but a general comment as this is a new option that<b=
r>
&gt; warrants some discussion.<br>
&gt; <br>
&gt; On Tue, Oct 19, 2021 at 2:32 PM Arne Schwabe &lt;<a href=3D"mailto:arn=
e@...1227..." target=3D"_blank">arne@...1227...</a><br>
&gt; &lt;mailto:<a href=3D"mailto:arne@...1227..." target=3D"_blank">arne@...220...=
..1227...</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0This allows OpenVPN to load non-default providers. =
This is mainly<br>
&gt;=C2=A0 =C2=A0 =C2=A0useful for loading the legacy provider with --provi=
der legacy:default<br>
&gt; <br>
&gt; <br>
&gt; While this format looks okay, we need to consider a few things to get<=
br>
&gt; this option right and possibly extensible in future without causing a<=
br>
&gt; regression.<br>
&gt; <br>
&gt; (i) Provider name may not be a simple word=C2=A0like legacy -- could a=
lso be<br>
&gt; the path to a shared object with possible embedded space in the path<b=
r>
&gt; name. A single option with optional quotes, picked apart using &quot;:=
&quot; as<br>
&gt; separator=C2=A0can still work.<br>
&gt; <br>
&gt; Ideally I would have preferred space separated provider names with<br>
&gt; each=C2=A0quoted if needed, but the=C2=A0format proposed here may be e=
asier to<br>
&gt; parse. Need clear documentation, though.<br>
<br>
<br>
Yeah using : was easier to parse since I need otherwise to setup an<br>
array or a list to store the parameter but it is doable. I was just<br>
hoping that nobody would use a : in the provider name.<br></blockquote><div=
><br></div><div>Use of &#39;.&#39; in the name is the recommended method to=
 have a namespace in the provider name and reduce chances of name conflict.=
 No one may use &#39;:&#39; and filenames are unlikely to contain &#39;:&#3=
9; as its not legal in some platforms.</div><div><br></div><div>That said, =
adding an array or list is easier than it looks. We have several options th=
at use an array or list and the code overhead is small.</div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; (ii) We may want to attach some meaning to the order in which provider=
s<br>
&gt; are specified. <br>
<br>
That would be mostly a documentation thing to explain that the providers<br>
are loaded the in order specified with that option.=C2=A0</blockquote><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
<br>
Here is why:<br>
&gt; <br>
&gt; When multiple providers implement the same method (say, KEYEXCH), ther=
e<br>
&gt; is no=C2=A0guarantee in OpenSSL as to which will get used. Unless a pr=
operty<br>
&gt; query like &quot;?provider=3Dmy-fast-aes&quot; is also used. Here the =
prefix &quot;?&quot; to<br>
&gt; mean preferred but not exclusive. In cases like an pkcs11 token<br>
&gt; provider, one would need to say the opposite like &quot;?provider=3Dde=
fault&quot; to<br>
&gt; ensure default is preferred and the token provider is to be used only<=
br>
&gt; when required --=C2=A0say when the key is in a token. Same would be th=
e case<br>
&gt; with our proposed built-in=C2=A0 &quot;external-key provider&quot; whi=
ch should be used<br>
&gt; only for certain operations that=C2=A0handle the external key.<br>
&gt; <br>
&gt; How this relates to the --provider option is like this: in some cases=
=C2=A0we<br>
&gt; want to know which provider the user prefers. Instead of hard-coding t=
he<br>
&gt; preferred provider to &quot;default&quot; which the user may not even =
want to<br>
&gt; load. We could state that the first provider specified will become the=
<br>
&gt; preferred one when there are multiple choices for a method or when a<b=
r>
&gt; preferred fallback is required. In that case the option for legacy wou=
ld be<br>
&gt; <br>
&gt; --provider default:legacy<br>
&gt; <br>
&gt; And, if this option is absent, we take it to mean=C2=A0that the &quot;=
default&quot;<br>
&gt; provider should be loaded.<br>
<br>
I would not explicitly load the default provider then but rather inherit<br>
what the system gives us. If the system wide config loads fips we should<br>
not load default instead.<br></blockquote><div><br></div><div>IMO, this ide=
a that OpenSSL folks have that just adding a &quot;fips=3Dyes&quot; plus a =
few lines in the config can make the application FIPS enabled is far-fetche=
d. In reality OpenVPN will have to be recompiled with some changes to make =
it FIPS compliant. At that point one can also change what providers are loa=
ded by default.</div><div><br></div><div>I was thinking of having a load_pr=
oviders() function called early -- say in options-post-process stage where =
we load</div><div><br></div><div>(i) default provider</div><div>(ii) provid=
ers specified in --providers option</div><div><br></div><div>This adds much=
 certainty to what is available. A FIPS-enabled OpenVPN can change this or =
we could have a --fips option that changes this. No dependency on system-wi=
de config file and those who need legacy only need to just specify &quot;--=
providers legacy&quot;</div><div><br></div><div>In addition, one could auto=
matically load &quot;legacy&quot; if any=C2=A0of the options indicate its n=
eed -- like NTLM auth for proxy or BF-CBC in --data-ciphers etc. In situati=
ons where it cannot be inferred from options,=C2=A0user will have to use --=
providers legacy, though.</div><div><br></div><div>It may be necessary to c=
all this load_providers() also to process options like --show-ciphers and s=
imilar.</div><div><br></div><div>Selva</div></div></div>

--00000000000063b4a605cedf0463--

