MIME-Version: 1.0
References: <20230517200143.216-1-chipitsine@...277...>
 <02835E0F-FA73-4722-83EB-17A33A3A8DA5@...1376...>
 <CAFHpkQER6g7MPu07_0TbKnnvc6poGsD2nZqLyATFXQN4JwiseQ@...278...>
 <DEA80ADA-574E-431E-A61E-89F4840AD9AF@...1376...>
In-Reply-To: <DEA80ADA-574E-431E-A61E-89F4840AD9AF@...1376...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 17 May 2023 23:06:34 +0200
Message-ID: <CAFHpkQFUYAbi=XPer39VshqN=Qcbcatcg1FGLpLHmxcKYKKDRA@...278...>
Content-Type: multipart/alternative; boundary="000000000000b3b78e05fbea10c3"
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

--000000000000b3b78e05fbea10c3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 17 =D0=BC=D0=B0=D1=8F 2023=E2=80=AF=D0=B3. =D0=B2 23:04, Kris=
tof Provost <kp@...1249...>:

> On 17 May 2023, at 16:58, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=
=B8=D1=86=D0=B8=D0=BD wrote:
> > =D1=81=D1=80, 17 =D0=BC=D0=B0=D1=8F 2023=E2=80=AF=D0=B3. =D0=B2 22:43, =
Kristof Provost <kp@...1249...>:
> >
> >> On 17 May 2023, at 16:01, Ilya Shipitsin wrote:
> >>> malloc was not checked against NULL, I was able
> >>> to get core dump in case of failure
> >>>
> >>> Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
> >>> ---
> >>>  src/openvpn/dco_freebsd.c | 5 +++++
> >>>  1 file changed, 5 insertions(+)
> >>>
> >>> diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
> >>> index 1111abeb..adbd1120 100644
> >>> --- a/src/openvpn/dco_freebsd.c
> >>> +++ b/src/openvpn/dco_freebsd.c
> >>> @@ -594,6 +594,11 @@ dco_available(int msglevel)
> >>>      }
> >>>
> >>>      buf =3D malloc(ifcr.ifcr_total * IFNAMSIZ);
> >>> +    if (buf =3D=3D NULL)
> >>> +    {
> >>
> >> I=E2=80=99d =E2=80=98goto out;=E2=80=99 instead, because that=E2=80=99=
s how we handle other errors in
> this
> >> function.
> >> (free(NULL) is guaranteed to be safe, so we can just do that.)
> >>
> >
> > on "goto out" we'll end with "return available;"
> >
> =E2=80=98available=E2=80=99 defaults to =E2=80=98false=E2=80=99, so that =
seems fine to me.
>

looks fragile :)

I do not see benefits of such an approach. But it will work indeed


>
> Best regards,
> Kristof
>

--000000000000b3b78e05fbea10c3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">=D1=81=D1=80, 17 =D0=BC=D0=B0=D1=8F 2=
023=E2=80=AF=D0=B3. =D0=B2 23:04, Kristof Provost &lt;<a href=3D"mailto:kp@=
...1249...">kp@...1249...</a>&gt;:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">On 17 May 2023, at 16:58, =D0=98=D0=BB=D1=8C=D1=8F =D0=
=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD wrote:<br>
&gt; =D1=81=D1=80, 17 =D0=BC=D0=B0=D1=8F 2023=E2=80=AF=D0=B3. =D0=B2 22:43,=
 Kristof Provost &lt;<a href=3D"mailto:kp@...1249..." target=3D"_blank">kp@=
...1249...</a>&gt;:<br>
&gt;<br>
&gt;&gt; On 17 May 2023, at 16:01, Ilya Shipitsin wrote:<br>
&gt;&gt;&gt; malloc was not checked against NULL, I was able<br>
&gt;&gt;&gt; to get core dump in case of failure<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: Ilya Shipitsin &lt;<a href=3D"mailto:chipitsine=
@...277..." target=3D"_blank">chipitsine@...277...</a>&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;=C2=A0 src/openvpn/dco_freebsd.c | 5 +++++<br>
&gt;&gt;&gt;=C2=A0 1 file changed, 5 insertions(+)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freeb=
sd.c<br>
&gt;&gt;&gt; index 1111abeb..adbd1120 100644<br>
&gt;&gt;&gt; --- a/src/openvpn/dco_freebsd.c<br>
&gt;&gt;&gt; +++ b/src/openvpn/dco_freebsd.c<br>
&gt;&gt;&gt; @@ -594,6 +594,11 @@ dco_available(int msglevel)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 buf =3D malloc(ifcr.ifcr_total * IFNAMSIZ)=
;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 if (buf =3D=3D NULL)<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 {<br>
&gt;&gt;<br>
&gt;&gt; I=E2=80=99d =E2=80=98goto out;=E2=80=99 instead, because that=E2=
=80=99s how we handle other errors in this<br>
&gt;&gt; function.<br>
&gt;&gt; (free(NULL) is guaranteed to be safe, so we can just do that.)<br>
&gt;&gt;<br>
&gt;<br>
&gt; on &quot;goto out&quot; we&#39;ll end with &quot;return available;&quo=
t;<br>
&gt;<br>
=E2=80=98available=E2=80=99 defaults to =E2=80=98false=E2=80=99, so that se=
ems fine to me.<br></blockquote><div><br></div><div>looks fragile :)</div><=
div><br></div><div>I do not see benefits of such an approach. But it will w=
ork indeed</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
<br>
Best regards,<br>
Kristof<br>
</blockquote></div></div>

--000000000000b3b78e05fbea10c3--

