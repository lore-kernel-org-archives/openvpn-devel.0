MIME-Version: 1.0
Sender: emmanueldeloget53@...277...
In-Reply-To: <30121809-005b-983f-75e7-8c65c1dd897f@...1856...>
References: <CAA1AbxLbVut1Z8pWF78kD=vy3rx5mxDf8MyDSR4BpxfbXoQZiQ@...278...>
	<20170612134330.20971-1-logout@...260...>
	<20170612134330.20971-8-logout@...260...>
	<30121809-005b-983f-75e7-8c65c1dd897f@...1856...>
From: Emmanuel Deloget <logout@...260...>
Date: Mon, 19 Jun 2017 16:04:15 +0200
Message-ID: <CAKh=nwGUsa5YC9sejuAeQqKd9NgvfkUZAni3OPx2woB95PR57w@...278...>
Content-Type: multipart/alternative; boundary="f403043efc043d38910552509ce7"
Subject: Re: [Openvpn-devel] [PATCH 7/8] OpenSSL: don't use direct access to
 the internal of HMAC_CTX
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--f403043efc043d38910552509ce7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Steffan,

On Sun, Jun 18, 2017 at 1:38 PM, Steffan Karger <steffan@...1856...> wrote:

> Hi,
>
> On 12-06-17 15:43, logout@...260... wrote:
> > +#if !defined(HAVE_HMAC_CTX_INIT)
> > +/**
> > + * Init a HMAC context
> > + *
> > + * @param ctx                 The HMAC context
> > + *
> > + * Contrary to many functions in this file, HMAC_CTX_init() is not
> > + * an OpenSSL 1.1 function: it comes from previous versions and was
> > + * removed in v1.1. As a consequence, there is no distincting in
> > + * v1.1 between a cleanup, and init and a reset. Yet, previous OpenSSL
> > + * version need this distinction.
> > + *
> > + * In order to respect previous OpenSSL versions, we implement init
> > + * as reset for OpenSSL 1.1+.
> > + */
> > +static inline void
> > +HMAC_CTX_init(HMAC_CTX *ctx)
> > +{
> > +    HMAC_CTX_reset(ctx);
> > +}
> > +#endif
>
> Hm, shouldn't we do this the other way around then?  Implement a
> HMAC_CTX_reset() here that calls HMAC_CTX_init(), and use _reset() in
> our hmac_ctx_init() function?
>
>
I think I did it that way to enhance code reading but it's true that it
introduces a pre-1.1 artefact into an interface which is based upon OpenSSL
1.1.

I'm sending a patch to fix that.


> =E2=80=8B> <snip
> >
>
> Otherwise this looks good, and passes my tests.  I would prefer to
> change the _init()/reset() thing before applying (if you agree that this
> is better), but if this is the only thing left to get 1.1 support into
> our next release that shouldn't block applying the patch.
>
> So, basically, ACK :)
>
> -Steffan
>

=E2=80=8BBR,

-- Emmanuel Deloget=E2=80=8B

--f403043efc043d38910552509ce7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:courier =
new,monospace">Hello Steffan,=C2=A0</div><div class=3D"gmail_extra"><br><di=
v class=3D"gmail_quote">On Sun, Jun 18, 2017 at 1:38 PM, Steffan Karger <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:steffan@...1856..." target=3D"_blank">=
steffan@...1856...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
Hi,<br>
<div><div class=3D"h5"><br>
On 12-06-17 15:43, <a href=3D"mailto:logout@...260...">logout@...260...</a>=
 wrote:<br>&gt; +#if !defined(HAVE_HMAC_CTX_INIT)<br>
&gt; +/**<br>
&gt; + * Init a HMAC context<br>
&gt; + *<br>
&gt; + * @param ctx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0The HMAC context<br>
&gt; + *<br>
&gt; + * Contrary to many functions in this file, HMAC_CTX_init() is not<br>
&gt; + * an OpenSSL 1.1 function: it comes from previous versions and was<b=
r>
&gt; + * removed in v1.1. As a consequence, there is no distincting in<br>
&gt; + * v1.1 between a cleanup, and init and a reset. Yet, previous OpenSS=
L<br>
&gt; + * version need this distinction.<br>
&gt; + *<br>
&gt; + * In order to respect previous OpenSSL versions, we implement init<b=
r>
&gt; + * as reset for OpenSSL 1.1+.<br>
&gt; + */<br>
&gt; +static inline void<br>
&gt; +HMAC_CTX_init(HMAC_CTX *ctx)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 HMAC_CTX_reset(ctx);<br>
&gt; +}<br>
&gt; +#endif<br>
<br>
</div></div>Hm, shouldn&#39;t we do this the other way around then?=C2=A0 I=
mplement a<br>
HMAC_CTX_reset() here that calls HMAC_CTX_init(), and use _reset() in<br>
our hmac_ctx_init() function?<br>
<div><div class=3D"h5"><br></div></div></blockquote><div><br></div><div><di=
v class=3D"gmail_default"><font face=3D"courier new, monospace">I think I d=
id it that way to enhance code reading but it&#39;s true that it introduces=
 a pre-1.1 artefact into an interface which is based upon OpenSSL 1.1.=C2=
=A0</font></div><div class=3D"gmail_default"><font face=3D"courier new, mon=
ospace"><br></font></div><div class=3D"gmail_default"><font face=3D"courier=
 new, monospace">I&#39;m sending a patch to fix that.</font></div><div clas=
s=3D"gmail_default"><span style=3D"font-family:arial,sans-serif">=C2=A0</sp=
an><br></div></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div><=
div class=3D"h5">
<div class=3D"gmail_default" style=3D"font-family:&quot;courier new&quot;,m=
onospace;display:inline">=E2=80=8B&gt; &lt;snip</div>&gt;<br>
<br>
</div></div>Otherwise this looks good, and passes my tests.=C2=A0 I would p=
refer to<br>
change the _init()/reset() thing before applying (if you agree that this<br>
is better), but if this is the only thing left to get 1.1 support into<br>
our next release that shouldn&#39;t block applying the patch.<br>
<br>
So, basically, ACK :)<br>
<br>
-Steffan<br></blockquote><div><br></div><div class=3D"gmail_default" style=
=3D"font-family:&quot;courier new&quot;,monospace">=E2=80=8BBR,=C2=A0</div>=
<div class=3D"gmail_default" style=3D"font-family:&quot;courier new&quot;,m=
onospace"><br></div><div class=3D"gmail_default" style=3D"font-family:&quot=
;courier new&quot;,monospace">-- Emmanuel Deloget=E2=80=8B</div></div></div=
></div>

--f403043efc043d38910552509ce7--

