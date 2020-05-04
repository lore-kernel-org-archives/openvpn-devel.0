MIME-Version: 1.0
References: <CAFHpkQEvQkC0NokWG-16x-R_zq9qG=2MyO2JV8m1nvNUhwU3Vw@...278...>
 <0de39489-f2a8-514e-763f-c037ba2afbcb@...515...>
In-Reply-To: <0de39489-f2a8-514e-763f-c037ba2afbcb@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 4 May 2020 17:14:59 +0500
Message-ID: <CAFHpkQELzeh5AQYXmQeNMP-9CXPjdGc=BM1qVbOCtH5QByO4iA@...278...>
Content-Type: multipart/alternative; boundary="0000000000007f7def05a4d17b80"
Subject: Re: [Openvpn-devel] is anybody running tests on Fedora ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000007f7def05a4d17b80
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 4 =D0=BC=D0=B0=D1=8F 2020 =D0=B3. =D0=B2 16:41, Samuli Sepp=
=C3=A4nen <samuli@...515...>:

> Hi,
>
> We do have a Fedora 30 buildslave and run fping tests there. It also
> seems to run t_client IPv6 ping tests.
>

can you please run the following


dnf whatprovides fping6

?


>
> Samuli
>
> Il 03/05/20 23:02, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD ha scritto:
> > Hello,
> >
> >
> > t_client.sh requires "fping6" binary, which is not available on Fedora.
> > on Fedora "fping" is capable of running ipv6 pings.
> >
> >
> > shall we adopt test ?
> >
> >
> > Cheers,
> > Ilya Shipitcin
> >
> >
> > _______________________________________________
> > Openvpn-devel mailing list
> > Openvpn-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> >
>
>

--0000000000007f7def05a4d17b80
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">=D0=BF=D0=BD, 4 =D0=BC=D0=B0=D1=8F 20=
20 =D0=B3. =D0=B2 16:41, Samuli Sepp=C3=A4nen &lt;<a href=3D"mailto:samuli@=
...515...">samuli@...515...</a>&gt;:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">Hi,<br>
<br>
We do have a Fedora 30 buildslave and run fping tests there. It also<br>
seems to run t_client IPv6 ping tests.<br></blockquote><div><br></div><div>=
can you please run the following</div><div><br></div><div><br></div><div>dn=
f whatprovides fping6</div><div><br></div><div>?<br></div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Samuli<br>
<br>
Il 03/05/20 23:02, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD ha scritto:<br>
&gt; Hello,<br>
&gt; <br>
&gt; <br>
&gt; t_client.sh requires &quot;fping6&quot; binary, which is not available=
 on Fedora.<br>
&gt; on Fedora &quot;fping&quot; is capable of running ipv6 pings.<br>
&gt; <br>
&gt; <br>
&gt; shall we adopt test ?<br>
&gt; <br>
&gt; <br>
&gt; Cheers,<br>
&gt; Ilya Shipitcin<br>
&gt; <br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; Openvpn-devel mailing list<br>
&gt; <a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blan=
k">Openvpn-devel@lists.sourceforge.net</a><br>
&gt; <a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/l=
istinfo/openvpn-devel</a><br>
&gt; <br>
<br>
</blockquote></div></div>

--0000000000007f7def05a4d17b80--

