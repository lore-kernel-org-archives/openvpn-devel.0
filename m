MIME-Version: 1.0
References: <CAFHpkQG4ZiJ0_cG6MRWGQdcajgsuByvu69Q7MfSJxM00FUe2iQ@...278...>
 <20191108090233.GB40538@...1296...>
In-Reply-To: <20191108090233.GB40538@...1296...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 8 Nov 2019 14:25:30 +0500
Message-ID: <CAFHpkQHBRjGHJ_=92YM1zBBH5YhumuCFitk5ONwhPLy=nDm6Hg@...278...>
Content-Type: multipart/alternative; boundary="000000000000a536730596d25dcf"
Subject: Re: [Openvpn-devel] using arm64 on travis ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000a536730596d25dcf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 8 =D0=BD=D0=BE=D1=8F=D0=B1. 2019 =D0=B3. =D0=B2 14:02, Gert D=
oering <gert@...1296...>:

> Hi,
>
> On Fri, Nov 08, 2019 at 12:39:00PM +0500, ???????? ?????????????? wrote:
> > https://docs.travis-ci.com/user/multi-cpu-architectures
> >
> > we can switch some builds to arm64. any suggestions ?
>
> Sounds good.  Right now we only have i386 and amd64 builds (since my
> SPARC machine is going away and my Pi3 slave is still not operational).
>

not as good as it could be :)

travis-ci uses the same cache key for amd64 and arm64 builds, so
(currently) openssl build caches are messed up.
but it is easy to resolve


>
> gert
>
> --
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never
> doubted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh
> Mistress
>
> Gert Doering - Munich, Germany
> gert@...1296...
>

--000000000000a536730596d25dcf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">=D0=BF=D1=82, 8 =D0=BD=D0=BE=D1=8F=D0=
=B1. 2019 =D0=B3. =D0=B2 14:02, Gert Doering &lt;<a href=3D"mailto:gert@...493...=
1296...">gert@...1296...</a>&gt;:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Hi,<br>
<br>
On Fri, Nov 08, 2019 at 12:39:00PM +0500, ???????? ?????????????? wrote:<br>
&gt; <a href=3D"https://docs.travis-ci.com/user/multi-cpu-architectures" re=
l=3D"noreferrer" target=3D"_blank">https://docs.travis-ci.com/user/multi-cp=
u-architectures</a><br>
&gt; <br>
&gt; we can switch some builds to arm64. any suggestions ?<br>
<br>
Sounds good.=C2=A0 Right now we only have i386 and amd64 builds (since my<b=
r>
SPARC machine is going away and my Pi3 slave is still not operational).<br>=
</blockquote><div><br></div><div>not as good as it could be :)</div><div><b=
r></div><div>travis-ci uses the same cache key for amd64 and arm64 builds, =
so (currently) openssl build caches are messed up.</div><div>but it is easy=
 to resolve<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
<br>
gert<br>
<br>
-- <br>
&quot;If was one thing all people took for granted, was conviction that if =
you <br>
=C2=A0feed honest figures into a computer, honest figures come out. Never d=
oubted <br>
=C2=A0it myself till I met a computer with a sense of humor.&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Robert A. Heinlein, The Moon is a Harsh Mist=
ress<br>
<br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296..." target=3D"_blank">gert@...1296...</a><br>
</blockquote></div></div>

--000000000000a536730596d25dcf--

