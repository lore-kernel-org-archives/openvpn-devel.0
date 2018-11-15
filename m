MIME-Version: 1.0
References: <20181007215837.489-1-arne@...1227...>
 <20181031165954.6139-1-arne@...1227...>
 <CAKuzo_hHO-3sb8oXybSe--kEj4xS96PSG+LDjuUTUjByE8JRdA@...278...>
 <c1ef90b8-27e9-6580-227f-b8684b5f905f@...1227...>
 <CAKuzo_iJa-geMOH8Jy_mBSMD+CVeRjdyFc1yq9902QcO14zR_g@...278...>
 <266d4464-5bfc-1b7e-9e81-a0b7a31b42ee@...1227...>
 <CAKuzo_hpots+Xy_FHZGFnw4wm3yDbouqykG3VWJ3vjbVs03r9w@...278...>
 <813ad24e-c28a-16bb-52fd-a6a73387b61c@...1227...>
In-Reply-To: <813ad24e-c28a-16bb-52fd-a6a73387b61c@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 15 Nov 2018 08:38:16 -0500
Message-ID: <CAKuzo_h33yOpZ9i8j=aLKoM9R05Jm8ArfykwJacLnLpeRZy_SA@...278...>
Content-Type: multipart/alternative; boundary="000000000000bdd9b4057ab42a8e"
Subject: Re: [Openvpn-devel] [PATCH v5 2/2] Add support for OpenSSL TLS 1.3
 when using management-external-key
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

--000000000000bdd9b4057ab42a8e
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 15, 2018 at 2:22 AM Arne Schwabe <arne@...1227...> wrote:

>
> >> Unless I overlooked something, I don't see any situation in which we ask
> >> for an unsupported signature.
> >
> > Consider this:
> > (i) config has --management-external-key nopadding but client announces
> version
> > 2. We will not error out but send the signature request as
> > PK_SIGN <base64data>
> > without the ALG as client version is not 3 and fail
>
> We can error out on version on the management line. But this is also a
> kind of obscure misconfiguration since why would add nopadding to the
> config if you cannot support it?
>

True, but by same argument then we need not worry about backward
compatibility
of management  protocol at all, do we? We could say, why would any one use
openvpn.exe that speaks MI version 3 with a client that cannot support it.

Anyway, for backward compat its enough to check client version and then
either error out if ALG is not PKCS1 or ECDSA or add ALG to PK_SIGN.

I fail to appreciate the utility of early erroring out feature -- it was
meaningful
in v1 where you had tried to downgrade to TLS 1.2 to plough along without
causing an error. But that turned out to be not enough.


> > (ii) tls version max is set 1.2 and openssl 1.1.1 is in use both on
> > server and client.
> > PSS signing will get negotiated but we will not error out early as TLS
> > 1.3 is not in  use.
> >
> > That's why I say that this extension of management-external-key is not
> worth it.
> >
> > Am I missing something?
> >
>
> tls_version_max will still report TLS 1.3 as it not affected by the
> version set in config but really the max the library is capable of
> irrespectable tls min/max version.
>

Aha, I missed that. Still I really do not understand the need for erroring
here
instead of when prompting for PK_SIGN based on client version.
Much simpler.

Selva

--000000000000bdd9b4057ab42a8e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Thu=
, Nov 15, 2018 at 2:22 AM Arne Schwabe &lt;<a href=3D"mailto:arne@...2477...=
.">arne@...1227...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><=
br>
&gt;&gt; Unless I overlooked something, I don&#39;t see any situation in wh=
ich we ask<br>
&gt;&gt; for an unsupported signature.<br>
&gt; <br>
&gt; Consider this:<br>
&gt; (i) config has --management-external-key nopadding but client announce=
s version<br>
&gt; 2. We will not error out but send the signature request as<br>
&gt; PK_SIGN &lt;base64data&gt;<br>
&gt; without the ALG as client version is not 3 and fail<br>
<br>
We can error out on version on the management line. But this is also a<br>
kind of obscure misconfiguration since why would add nopadding to the<br>
config if you cannot support it?<br></blockquote><div><br></div><div>True, =
but by same argument then we need not worry about backward compatibility</d=
iv><div>of management =C2=A0protocol at all, do we? We could say, why would=
 any one use</div><div>openvpn.exe that speaks MI version 3 with a client t=
hat cannot support it.</div><div><br></div><div>Anyway, for backward compat=
 its enough to check client version and then</div><div>either error out if =
ALG is not PKCS1 or ECDSA or add ALG to PK_SIGN.</div><div><br></div><div>I=
 fail to appreciate the utility of early erroring out feature -- it was mea=
ningful</div><div>in v1 where you had tried to downgrade to TLS 1.2 to plou=
gh along without</div><div>causing an error. But that turned out to be not =
enough.</div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
&gt; (ii) tls version max is set 1.2 and openssl 1.1.1 is in use both on<br>
&gt; server and client.<br>
&gt; PSS signing will get negotiated but we will not error out early as TLS=
<br>
&gt; 1.3 is not in=C2=A0 use.<br>
&gt; <br>
&gt; That&#39;s why I say that this extension of management-external-key is=
 not worth it.<br>
&gt; <br>
&gt; Am I missing something?<br>
&gt; <br>
<br>
tls_version_max will still report TLS 1.3 as it not affected by the<br>
version set in config but really the max the library is capable of<br>
irrespectable tls min/max version.<br></blockquote><div><br></div><div>Aha,=
 I missed that. Still I really do not understand the need for erroring here=
</div><div>instead of when prompting for PK_SIGN based on client version.</=
div><div>Much simpler.</div><div><br></div><div>Selva</div></div></div>

--000000000000bdd9b4057ab42a8e--

