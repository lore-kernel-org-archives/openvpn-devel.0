MIME-Version: 1.0
References: <20230517200143.216-1-chipitsine@...277...>
 <a362a6e5-c80b-1473-d503-4e51befd22ee@...2181...>
In-Reply-To: <a362a6e5-c80b-1473-d503-4e51befd22ee@...2181...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 17 May 2023 22:59:41 +0200
Message-ID: <CAFHpkQEn6g42x+QXNMVX6ngb=K=C12Gh+NCHOu-3Erp1syWSiw@...278...>
Content-Type: multipart/alternative; boundary="00000000000019715005fbe9f80f"
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--00000000000019715005fbe9f80f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 17 =D0=BC=D0=B0=D1=8F 2023=E2=80=AF=D0=B3. =D0=B2 22:47, Anto=
nio Quartulli <a@...2181...>:

> Hi,
>
> On 17/05/2023 22:01, Ilya Shipitsin wrote:
> > malloc was not checked against NULL, I was able
> > to get core dump in case of failure
> >
> > Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
> > ---
> >   src/openvpn/dco_freebsd.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
> > index 1111abeb..adbd1120 100644
> > --- a/src/openvpn/dco_freebsd.c
> > +++ b/src/openvpn/dco_freebsd.c
> > @@ -594,6 +594,11 @@ dco_available(int msglevel)
> >       }
> >
> >       buf =3D malloc(ifcr.ifcr_total * IFNAMSIZ);
> > +    if (buf =3D=3D NULL)
>
> as style guideline, we wanted to go for if (!A) rather than if (A =3D=3D
> NULL). Although I am not sure if the whole codebase was cleaned up yet
> or not.
>

I'm fine with either :)


>
> Cheers,
>
> > +    {
> > +        close(fd);
> > +        return false;
> > +    }
> >
> >       ifcr.ifcr_count =3D ifcr.ifcr_total;
> >       ifcr.ifcr_buffer =3D buf;
>
> --
> Antonio Quartulli
>

--00000000000019715005fbe9f80f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">=D1=81=D1=80, 17 =D0=BC=D0=B0=D1=8F 2=
023=E2=80=AF=D0=B3. =D0=B2 22:47, Antonio Quartulli &lt;<a href=3D"mailto:a=
@...2181...">a@...2181...</a>&gt;:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">Hi,<br>
<br>
On 17/05/2023 22:01, Ilya Shipitsin wrote:<br>
&gt; malloc was not checked against NULL, I was able<br>
&gt; to get core dump in case of failure<br>
&gt; <br>
&gt; Signed-off-by: Ilya Shipitsin &lt;<a href=3D"mailto:chipitsine@...1354...=
.." target=3D"_blank">chipitsine@...277...</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0src/openvpn/dco_freebsd.c | 5 +++++<br>
&gt;=C2=A0 =C2=A01 file changed, 5 insertions(+)<br>
&gt; <br>
&gt; diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c<br>
&gt; index 1111abeb..adbd1120 100644<br>
&gt; --- a/src/openvpn/dco_freebsd.c<br>
&gt; +++ b/src/openvpn/dco_freebsd.c<br>
&gt; @@ -594,6 +594,11 @@ dco_available(int msglevel)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0buf =3D malloc(ifcr.ifcr_total * IFNAMSIZ);<=
br>
&gt; +=C2=A0 =C2=A0 if (buf =3D=3D NULL)<br>
<br>
as style guideline, we wanted to go for if (!A) rather than if (A =3D=3D <b=
r>
NULL). Although I am not sure if the whole codebase was cleaned up yet <br>
or not.<br></blockquote><div><br></div><div>I&#39;m fine with either :)</di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Cheers,<br>
<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(fd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ifcr.ifcr_count =3D ifcr.ifcr_total;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ifcr.ifcr_buffer =3D buf;<br>
<br>
-- <br>
Antonio Quartulli<br>
</blockquote></div></div>

--00000000000019715005fbe9f80f--

