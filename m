MIME-Version: 1.0
Sender: emmanueldeloget53@...277...
In-Reply-To: <CAA1AbxLqiVhodTpNzX4qdgx3w8tWaCVpJCXHQRnfzFNXiKa9TQ@...278...>
References: <CAKh=nwFOSOCugW1JWYfiQFZLTKRBc6qoi=U9ewzjOSpaGP1-Kg@...278...>
 <6a6ede658da2e35b718a9ccb733b132a955ffefe.1515792908.git.logout@...260...>
 <183bd138-e733-042e-9cc3-c66bbf6ea9bd@...1856...>
 <CAKh=nwEeSBgkbz5-_R_eU7rK9fYpDQ=1jsY+02+vMxRJ8=wZxg@...278...>
 <CAKuzo_j6Uuw8minumYHECmqtE9ocvrzGtO0_3FUcGnNy4q3Bqw@...278...>
 <CAKh=nwGDv2fKJ6STqYthwpH+1SkztkLj1=KH4MWJ58ifc_byog@...278...>
 <20180116082652.GJ69387@...1296...>
 <CAA1AbxLqiVhodTpNzX4qdgx3w8tWaCVpJCXHQRnfzFNXiKa9TQ@...278...>
From: Emmanuel Deloget <logout@...260...>
Date: Wed, 17 Jan 2018 13:58:10 +0100
Message-ID: <CAKh=nwEOYB6Ab42xZUPkaHEWDwx-ECJVn79kh-rz0Y8HvG4Dbw@...278...>
Content-Type: multipart/alternative; boundary="001a114c908e46600e0562f86615"
Subject: Re: [Openvpn-devel] [PATCH v2 2/3] OpenSSL: remove some EVP_PKEY
 type checks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--001a114c908e46600e0562f86615
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Jan 17, 2018 at 1:16 PM, Steffan Karger <steffan@...1856...> wrote:

> Hi,
>
> On 15 January 2018 at 23:33, Emmanuel Deloget <logout@...260...> wrote:
> > For the variables outside the ifs, the next C standard should allow us =
to
> > write something like:
> >
> > if ((RSA *rsa =3D EVP_PKEY_get0_RSA(pkey)) !=3D NULL) {
>
> Yeah, such a shame that this didn't make it into C11.  Scoping a
> variable to an if block is often useful.  If only for error checking
> like if(int err =3D foo()) { handle error }.  Anyway, we can't have it
> :(
>
> On 16 January 2018 at 09:26, Gert Doering <gert@...1296...> wrote:
> > On Tue, Jan 16, 2018 at 01:56:11AM +0100, Emmanuel Deloget wrote:
> >> 3) rework it as proposed in the patch
> >>
> >> RSA *rsa =3D NULL;
> >> if ((rsa =3D EVP_PKEY_get0_RSA(pkey)) !=3D NULL) { ... }
> >
> > I do not particularily like assignments in if() clauses, especially when
> > the variable is declared right above it.  So if we go for (3), my
> > favourite would be
> >
> > RSA *rsa =3D EVP_PKEY_get0_RSA(pkey);
> > if (rsa !=3D NULL) { ... }
> >
> >
> > but this is just a side remark.  The question on "1, 2 or 3" I'll defer
> > to you folks that are maintaing this code (Steffan and Selva, mostly :)
> ).
>
> This indeed looks a bit better that initializing to NULL if we're
> going to take the variables outside the scope.
>
> Seems I've been overruled by majority regarding the way to go, and
> with the suggestion from cron2 taken into account I think 3 is the way
> to go.
>
> -Steffan
>

=E2=80=8BI'm OK with this (3) variation :)

I'm respinning the patches.

BR,

-- Emmanuel Deloget=E2=80=8B

--001a114c908e46600e0562f86615
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:monospac=
e,monospace">Hello,=C2=A0</div><div class=3D"gmail_extra"><br><div class=3D=
"gmail_quote">On Wed, Jan 17, 2018 at 1:16 PM, Steffan Karger <span dir=3D"=
ltr">&lt;<a href=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...1186...=
.1856...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On 15 January 2018 at 23:33, Emmanuel Deloget &lt;<a href=3D"mailto:logout@=
...260...">logout@...260...</a>&gt; wrote:<br>
&gt; For the variables outside the ifs, the next C standard should allow us=
 to<br>
&gt; write something like:<br>
&gt;<br>
&gt; if ((RSA *rsa =3D EVP_PKEY_get0_RSA(pkey)) !=3D NULL) {<br>
<br>
</span>Yeah, such a shame that this didn&#39;t make it into C11.=C2=A0 Scop=
ing a<br>
variable to an if block is often useful.=C2=A0 If only for error checking<b=
r>
like if(int err =3D foo()) { handle error }.=C2=A0 Anyway, we can&#39;t hav=
e it<br>
:(<br>
<span class=3D""><br>
On 16 January 2018 at 09:26, Gert Doering &lt;<a href=3D"mailto:gert@...1826...=
6...">gert@...1296...</a>&gt; wrote:<br>
&gt; On Tue, Jan 16, 2018 at 01:56:11AM +0100, Emmanuel Deloget wrote:<br>
&gt;&gt; 3) rework it as proposed in the patch<br>
&gt;&gt;<br>
&gt;&gt; RSA *rsa =3D NULL;<br>
&gt;&gt; if ((rsa =3D EVP_PKEY_get0_RSA(pkey)) !=3D NULL) { ... }<br>
&gt;<br>
&gt; I do not particularily like assignments in if() clauses, especially wh=
en<br>
&gt; the variable is declared right above it.=C2=A0 So if we go for (3), my=
<br>
&gt; favourite would be<br>
&gt;<br>
&gt; RSA *rsa =3D EVP_PKEY_get0_RSA(pkey);<br>
&gt; if (rsa !=3D NULL) { ... }<br>
&gt;<br>
&gt;<br>
&gt; but this is just a side remark.=C2=A0 The question on &quot;1, 2 or 3&=
quot; I&#39;ll defer<br>
&gt; to you folks that are maintaing this code (Steffan and Selva, mostly :=
) ).<br>
<br>
</span>This indeed looks a bit better that initializing to NULL if we&#39;r=
e<br>
going to take the variables outside the scope.<br>
<br>
Seems I&#39;ve been overruled by majority regarding the way to go, and<br>
with the suggestion from cron2 taken into account I think 3 is the way<br>
to go.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
-Steffan<br>
</font></span></blockquote></div><br></div><div class=3D"gmail_extra"><div =
class=3D"gmail_default" style=3D"font-family:monospace,monospace">=E2=80=8B=
I&#39;m OK with this (3) variation :)</div><div class=3D"gmail_default" sty=
le=3D"font-family:monospace,monospace"><br></div><div class=3D"gmail_defaul=
t" style=3D"font-family:monospace,monospace">I&#39;m respinning the patches=
.=C2=A0</div><div class=3D"gmail_default" style=3D"font-family:monospace,mo=
nospace"><br></div><div class=3D"gmail_default" style=3D"font-family:monosp=
ace,monospace">BR,=C2=A0</div><div class=3D"gmail_default" style=3D"font-fa=
mily:monospace,monospace"><br></div><div class=3D"gmail_default" style=3D"f=
ont-family:monospace,monospace">-- Emmanuel Deloget=E2=80=8B</div><br></div=
></div>

--001a114c908e46600e0562f86615--

