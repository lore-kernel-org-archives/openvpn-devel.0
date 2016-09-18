MIME-Version: 1.0
In-Reply-To: <CAA1AbxK+mE0mz01UwrJ=o_6HBkBBe+FUXNnmqsfMe7vQLzCTsQ@...278...>
References: <b7d9be2a-b8e1-e565-198f-a5177e11d0c2@...1435...>
	<CAA1AbxK+mE0mz01UwrJ=o_6HBkBBe+FUXNnmqsfMe7vQLzCTsQ@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 18 Sep 2016 16:07:03 -0400
Message-ID: <CAKuzo_iLEydt1py69+r1Fr+ba5JzVEPLMNq-53qxr4B-3CwVHw@...278...>
Content-Type: multipart/alternative; boundary=94eb2c12299c689a2d053ccdbe2c
Subject: Re: [Openvpn-devel] Feature proposal: tls-crypt
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--94eb2c12299c689a2d053ccdbe2c
Content-Type: text/plain; charset=UTF-8

Hi,

On Sun, Sep 18, 2016 at 8:25 AM, Steffan Karger <steffan@...1856...> wrote:

> Hi,
>
> On 27 July 2016 at 16:42, Steffan Karger <steffan.karger@...1435...>
> wrote:
> > Our customers, as well as community users, have asked for encryption of
> > control channel packets to hide their certificate (containing perhaps
> > the users' name or organisation), or to provide some basic form of
> > post-quantum security (see e.g. trac #633).
> >
> > We've been thinking about this for a while, and would like to implement
> > such a feature.  I've attached a proposal for an extension of tls-auth
> > to achieve this in OpenVPN.  Comments and/or questions are very welcome.
> >  I hope to be able to start implementing this soon.
>
> I just pushed an experimental branch with --tls-crypt support:
> https://github.com/syzzer/openvpn/tree/tls-crypt-preview
>
> Any comments and test results or very much welcome.
>

Not qualified to comment on the implementation details, but the feature
looks very useful to have. Arguably its too early to plan for a
post-quantum world, but encrypting control channel packets is nice..
.
Does this mean that --tls-crypt will imply --tls-auth with the same
key-file (or make the latter redudnant?). The man-page description in the
patch appears to imply so, but not very clear..

Selva

--94eb2c12299c689a2d053ccdbe2c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div><div class=3D"gmail_extra"><br><div class=3D"g=
mail_quote">On Sun, Sep 18, 2016 at 8:25 AM, Steffan Karger <span dir=3D"lt=
r">&lt;<a target=3D"_blank" href=3D"mailto:steffan@...1856...">steffan@...1386...=
856...</a>&gt;</span> wrote:<br><blockquote style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex" class=3D"gmail_=
quote">Hi,<br>
<span class=3D"gmail-"><br>
On 27 July 2016 at 16:42, Steffan Karger &lt;<a href=3D"mailto:steffan.karg=
er@...1435...">steffan.karger@...1435...</a>&gt; wrote:<br>
&gt; Our customers, as well as community users, have asked for encryption o=
f<br>
&gt; control channel packets to hide their certificate (containing perhaps<=
br>
&gt; the users&#39; name or organisation), or to provide some basic form of=
<br>
&gt; post-quantum security (see e.g. trac #633).<br>
&gt;<br>
&gt; We&#39;ve been thinking about this for a while, and would like to impl=
ement<br>
&gt; such a feature.=C2=A0 I&#39;ve attached a proposal for an extension of=
 tls-auth<br>
&gt; to achieve this in OpenVPN.=C2=A0 Comments and/or questions are very w=
elcome.<br>
&gt;=C2=A0 I hope to be able to start implementing this soon.<br>
<br>
</span>I just pushed an experimental branch with --tls-crypt support:<br>
<a target=3D"_blank" rel=3D"noreferrer" href=3D"https://github.com/syzzer/o=
penvpn/tree/tls-crypt-preview">https://github.com/syzzer/<wbr>openvpn/tree/=
tls-crypt-preview</a><br>
<br>
Any comments and test results or very much welcome.<br></blockquote><div><b=
r>Not qualified to comment on the implementation details, but the feature l=
ooks very useful to have.=20
Arguably its too early to plan for a post-quantum world, but encrypting con=
trol channel packets is nice..<br>.</div><div class=3D"gmail_extra">Does th=
is mean that --tls-crypt will imply --tls-auth with the same key-file (or m=
ake the latter redudnant?). The man-page description in the patch appears t=
o imply so, but not very clear..<br></div><div class=3D"gmail_extra"><br></=
div><div class=3D"gmail_extra">Selva<br></div></div></div></div></div>

--94eb2c12299c689a2d053ccdbe2c--

