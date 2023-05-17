MIME-Version: 1.0
References: <20230517200143.216-1-chipitsine@...277...>
 <02835E0F-FA73-4722-83EB-17A33A3A8DA5@...1376...>
In-Reply-To: <02835E0F-FA73-4722-83EB-17A33A3A8DA5@...1376...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 17 May 2023 22:58:52 +0200
Message-ID: <CAFHpkQER6g7MPu07_0TbKnnvc6poGsD2nZqLyATFXQN4JwiseQ@...278...>
Content-Type: multipart/alternative; boundary="00000000000032ff6305fbe9f5cd"
Subject: Re: [Openvpn-devel] [PATCH] src/openvpn/dco_freebsd.c: handle
 malloc failure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Kristof Provost <kp@...1249...>
Cc: openvpn-devel@lists.sourceforge.net

--00000000000032ff6305fbe9f5cd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 17 =D0=BC=D0=B0=D1=8F 2023=E2=80=AF=D0=B3. =D0=B2 22:43, Kris=
tof Provost <kp@...1249...>:

> On 17 May 2023, at 16:01, Ilya Shipitsin wrote:
> > malloc was not checked against NULL, I was able
> > to get core dump in case of failure
> >
> > Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
> > ---
> >  src/openvpn/dco_freebsd.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
> > index 1111abeb..adbd1120 100644
> > --- a/src/openvpn/dco_freebsd.c
> > +++ b/src/openvpn/dco_freebsd.c
> > @@ -594,6 +594,11 @@ dco_available(int msglevel)
> >      }
> >
> >      buf =3D malloc(ifcr.ifcr_total * IFNAMSIZ);
> > +    if (buf =3D=3D NULL)
> > +    {
>
> I=E2=80=99d =E2=80=98goto out;=E2=80=99 instead, because that=E2=80=99s h=
ow we handle other errors in this
> function.
> (free(NULL) is guaranteed to be safe, so we can just do that.)
>

on "goto out" we'll end with "return available;"


>
> Fwiw: I usually don=E2=80=99t bother handling malloc failure in userspace=
, because
> modern systems all overallocate anyway, so the first thing you know about
> lack of memory is the out-of-memory killer terminating you. It=E2=80=99s =
a policy
> choice for the project, so I don=E2=80=99t object to handling it either.
>

I agree it's a highly unlikely condition.


>
> Best regards,
> Kristof
>

--00000000000032ff6305fbe9f5cd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">=D1=81=D1=80, 17 =D0=BC=D0=B0=D1=8F 2=
023=E2=80=AF=D0=B3. =D0=B2 22:43, Kristof Provost &lt;<a href=3D"mailto:kp@=
...1249...">kp@...1249...</a>&gt;:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">On 17 May 2023, at 16:01, Ilya Shipitsin wrote:<br>
&gt; malloc was not checked against NULL, I was able<br>
&gt; to get core dump in case of failure<br>
&gt;<br>
&gt; Signed-off-by: Ilya Shipitsin &lt;<a href=3D"mailto:chipitsine@...1354...=
.." target=3D"_blank">chipitsine@...277...</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 src/openvpn/dco_freebsd.c | 5 +++++<br>
&gt;=C2=A0 1 file changed, 5 insertions(+)<br>
&gt;<br>
&gt; diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c<br>
&gt; index 1111abeb..adbd1120 100644<br>
&gt; --- a/src/openvpn/dco_freebsd.c<br>
&gt; +++ b/src/openvpn/dco_freebsd.c<br>
&gt; @@ -594,6 +594,11 @@ dco_available(int msglevel)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 buf =3D malloc(ifcr.ifcr_total * IFNAMSIZ);<br>
&gt; +=C2=A0 =C2=A0 if (buf =3D=3D NULL)<br>
&gt; +=C2=A0 =C2=A0 {<br>
<br>
I=E2=80=99d =E2=80=98goto out;=E2=80=99 instead, because that=E2=80=99s how=
 we handle other errors in this function.<br>
(free(NULL) is guaranteed to be safe, so we can just do that.)<br></blockqu=
ote><div><br></div><div>on &quot;goto out&quot; we&#39;ll end with &quot;re=
turn available;&quot;</div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
<br>
Fwiw: I usually don=E2=80=99t bother handling malloc failure in userspace, =
because modern systems all overallocate anyway, so the first thing you know=
 about lack of memory is the out-of-memory killer terminating you. It=E2=80=
=99s a policy choice for the project, so I don=E2=80=99t object to handling=
 it either.<br></blockquote><div><br></div><div>I agree it&#39;s a highly u=
nlikely condition.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
<br>
Best regards,<br>
Kristof<br>
</blockquote></div></div>

--00000000000032ff6305fbe9f5cd--

