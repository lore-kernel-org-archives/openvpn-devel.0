MIME-Version: 1.0
In-Reply-To: <1509293083.3116.22.camel@...2316...>
References: <1509192147.3021.6.camel@...2316...>
 <20171029152418.GF958@...1296...>
 <1509293083.3116.22.camel@...2316...>
From: Selva <selva.nair@...277...>
Date: Sun, 29 Oct 2017 17:03:41 -0400
Message-ID: <CAKuzo_guDg74RXr1OssXSXLQk=xFoCFwjDkvSgkEvtGcVQR_DQ@...278...>
Content-Type: multipart/alternative; boundary="94eb2c05900886ea35055cb5dc30"
Subject: Re: [Openvpn-devel] [PATCH 0/1] add engine keys keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Bottomley <James.Bottomley@...2317...>
Cc: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c05900886ea35055cb5dc30
Content-Type: text/plain; charset="UTF-8"

Hi,

On Sun, Oct 29, 2017 at 12:04 PM, James Bottomley <James.Bottomley@
hansenpartnership.com> wrote:

> On Sun, 2017-10-29 at 16:24 +0100, Gert Doering wrote:
> > Hi,
> >
> > On Sat, Oct 28, 2017 at 01:02:27PM +0100, James Bottomley wrote:
> > >
> > > Engine keys are an openssl concept for a key file which can only be
> > > understood by an engine (usually because it's been wrapped by the
> > > engine itself).  We use this for TPM engine keys, so you can either
> > > generate them within your TPM or wrap them from existing private
> > > keys.  Once wrapped, the keys will only function in the TPM that
> > > generated them, so it means the VPN keys are tied to the physical
> > > platform, which is very useful.  Engine keys have to be loaded via
> > > a specific callback, so use this as a fallback in openvpn if an
> > > engine is specified and if the PEM read of the private key fails.
> >
> > How does this work in an OpenVPN context, as in, what do I have to do
> > to make TPM keys work on client and server?
>
> If you have an existing private key, you convert it to a TPM key using
> the create_tpm[2]_key binary that comes with openssl_tpm[2]_engine.
>  The key you create is then locked to the TPM of the system you create
> it on (so save an offline copy of the non-TPM private key).
>
> > Do we need a new abstraction layer here somewhere, given that this
> > seems to do something similar to using the windows crypto layer to
> > access "private keys hidden in windows" (--cryptoapicert) and/or
> > pkcs11?
>
> I don't really think so.  The engine keys are a bit of an openssl
> brainfart: there's no reason why PEM_read_bio_PrivateKey couldn't
> actually check for engine keys and have the whole thing transparent to
> all applications, except that openssl didn't want to do it that way.
>
> These keys are real files, so they're not like tokens, which is the
> pkcs11 abstraction.


That means, if one has the tpm_engine for openssl installed and
TPM-wrapped keys, this should just work, is it? And, I suppose, the
patch for openvpn is required only because openssl does not transparently
use available engines.

If so, this looks like a easy way to provide TPM support to
openssl users on some platforms. What about Windows? Is there
an openssl TPM engine and tools to convert the key to a wrapped
TSS blob on Windows?

I would like to see new features transparently supported on Windows
as well without the need for too much extra code and associated
maintenance burden. Our 'cryptoapicert' implementation is already in
need of a major re-write to support TLS 1.2 and newer.

From that point of view, instead of file-based wrapped keys, if a pkcs11
compatible API can be used to access TPM (that's possible isn't it?) TPM
could be more widely usable without the need of any additional support
in openssl or openvpn.

Selva

--94eb2c05900886ea35055cb5dc30
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Sun, Oct 29, 2017 at 12:04 PM, James <span class=3D"" id=3D":4oy.=
1" tabindex=3D"-1">Bottomley</span> <span dir=3D"ltr">&lt;<a href=3D"mailto=
:James.Bottomley@...2317..." target=3D"_blank">James.<span class=3D"" id=3D=
":4oy.2" tabindex=3D"-1">Bottomley</span>@<wbr><span class=3D"" id=3D":4oy.=
3" tabindex=3D"-1">hansenpartnership</span>.com</a>&gt;</span> wrote:<br><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex"><span>On Sun, 2017-10-29 at=
 16:24 +0100, Gert Doering wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; On Sat, Oct 28, 2017 at 01:02:27PM +0100, James Bottomley wrote:<br>
&gt; &gt;<br>
&gt; &gt; Engine keys are an openssl concept for a key file which can only =
be<br>
&gt; &gt; understood by an engine (usually because it&#39;s been wrapped by=
 the<br>
&gt; &gt; engine itself).=C2=A0 We use this for TPM engine keys, so you can=
 either<br>
&gt; &gt; generate them within your TPM or wrap them from existing private<=
br>
&gt; &gt; keys.=C2=A0 Once wrapped, the keys will only function in the TPM =
that<br>
&gt; &gt; generated them, so it means the VPN keys are tied to the physical=
<br>
&gt; &gt; platform, which is very useful.=C2=A0 Engine keys have to be load=
ed via<br>
&gt; &gt; a specific callback, so use this as a fallback in openvpn if an<b=
r>
&gt; &gt; engine is specified and if the PEM read of the private key fails.=
<br>
&gt;<br>
&gt; How does this work in an OpenVPN context, as in, what do I have to do<=
br>
&gt; to make TPM keys work on client and server?<br>
<br>
</span>If you have an existing private key, you convert it to a TPM key usi=
ng<br>
the create_tpm[2]_key binary that comes with openssl_tpm[2]_engine.<br>
=C2=A0The key you create is then locked to the TPM of the system you create=
<br>
it on (so save an offline copy of the non-TPM private key).<br>
<span><br>
&gt; Do we need a new abstraction layer here somewhere, given that this=C2=
=A0<br>
&gt; seems to do something similar to using the windows crypto layer to<br>
&gt; access &quot;private keys hidden in windows&quot; (--cryptoapicert) an=
d/or<br>
&gt; pkcs11?<br>
<br>
</span>I don&#39;t really think so.=C2=A0 The engine keys are a bit of an o=
penssl<br>
brainfart: there&#39;s no reason why PEM_read_bio_PrivateKey couldn&#39;t<b=
r>
actually check for engine keys and have the whole thing transparent to<br>
all applications, except that openssl didn&#39;t want to do it that way.<br>
<br>
These keys are real files, so they&#39;re not like tokens, which is the<br>
pkcs11 abstraction.</blockquote><div><br></div><div>That means, if one has =
the <span class=3D"" id=3D":4oy.4" tabindex=3D"-1">tpm</span>_engine for <s=
pan class=3D"" id=3D":4oy.5" tabindex=3D"-1">openssl</span> installed and</=
div><div><span class=3D"" id=3D":4oy.6" tabindex=3D"-1">TPM</span>-wrapped =
keys, this should just work, is it? And, I suppose, the</div><div>patch for=
 <span class=3D"" id=3D":4oy.7" tabindex=3D"-1">openvpn</span> is required =
only because <span class=3D"" id=3D":4oy.8" tabindex=3D"-1">openssl</span> =
does not transparently</div><div>use available engines.</div><div><br></div=
><div>If so, this looks like a easy way to provide <span class=3D"" id=3D":=
4oy.9" tabindex=3D"-1">TPM</span> support to<br></div><div><span class=3D""=
 id=3D":4oy.10" tabindex=3D"-1">openssl</span> users on some platforms. Wha=
t about Windows? Is there</div><div>an <span class=3D"" id=3D":4oy.11" tabi=
ndex=3D"-1">openssl</span> <span class=3D"" id=3D":4oy.12" tabindex=3D"-1">=
TPM</span> engine and tools to convert the key to a wrapped</div><div><span=
 class=3D"" id=3D":4oy.13" tabindex=3D"-1">TSS</span> blob on Windows?</div=
><div><br></div><div>I would like to see new features transparently support=
ed on Windows</div><div>as well without the need for too much extra code an=
d associated</div><div>maintenance burden. Our &#39;cryptoapicert&#39; impl=
ementation is already in</div><div>need of a major re-write to support <spa=
n class=3D"" id=3D":4oy.14" tabindex=3D"-1">TLS</span> 1.2 and newer.</div>=
<div><br></div><div>From that point of view, instead of file-based wrapped =
keys, if a pkcs11</div><div>compatible API can be used to access <span clas=
s=3D"" id=3D":4oy.15" tabindex=3D"-1">TPM</span> (that&#39;s possible isn&#=
39;t it?) <span class=3D"" id=3D":4oy.16" tabindex=3D"-1">TPM</span></div><=
div>could be more widely usable without the need of any additional support<=
/div><div>in <span class=3D"" id=3D":4oy.17" tabindex=3D"-1">openssl</span>=
 or <span class=3D"" id=3D":4oy.18" tabindex=3D"-1">openvpn</span>.</div><d=
iv><br></div><div><span class=3D"" id=3D":4oy.19" tabindex=3D"-1">Selva</sp=
an></div></div></div></div>

--94eb2c05900886ea35055cb5dc30--

