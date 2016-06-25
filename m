MIME-Version: 1.0
In-Reply-To: <24448974.0y5P2VU2rm@...1526...>
References: <1466784101-20655-1-git-send-email-heiko.hund@...1489...>
	<20160624173713.GZ79504@...1296...> <24448974.0y5P2VU2rm@...1526...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 25 Jun 2016 09:52:21 -0400
Message-ID: <CAKuzo_g-SzCezTj6XfkJS465HSHcZkbubZfuiv0hYTBT4BbpQw@...278...>
Content-Type: multipart/alternative; boundary=001a1149d7cac7134f05361a99cd
Subject: Re: [Openvpn-devel] [PATCH] Windows: do_ifconfig() after open_tun()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1149d7cac7134f05361a99cd
Content-Type: text/plain; charset=UTF-8

On Sat, Jun 25, 2016 at 3:45 AM, Heiko Hund <heiko.hund@...1489...> wrote:

> On Freitag, 24. Juni 2016 19:37:13 CEST Gert Doering wrote:
> > This patch changes the order to IFCONFIG_AFTER_TUN_OPEN, moves some
> > initialization code to init_tun, where it belongs, and removes duplicate
> > code that is now no longer needed.
>
> Yeah, I was skeptic at first, too. But it seems to work. That said, I've
> only
> tested with the interactive service in place. It's the only option how to
> run
> Openvpn in a sane manner on Windows anyways. =)
>
>
True but not yet practical  in some cases. For example, we do not yet have
way to start openvpn using interactive service without using the GUI -- say
run a client or a server (as from an init script). We should do something
about it, but until then testing without interactive service is important
-- easy to do, just run from the command line.

Also, a test against the old tap driver (NDIS 5.x) is in order..

Selva

--001a1149d7cac7134f05361a99cd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sat, Jun 25, 2016 at 3:45 AM, <span class=3D"" id=3D":1y3.1" tabindex=3D=
"-1">Heiko</span> <span class=3D"" id=3D":1y3.2" tabindex=3D"-1">Hund</span=
> <span dir=3D"ltr">&lt;<a href=3D"mailto:heiko.hund@...1489..." target=3D"=
_blank"><span class=3D"" id=3D":1y3.3" tabindex=3D"-1">heiko</span>.<span c=
lass=3D"" id=3D":1y3.4" tabindex=3D"-1">hund</span>@<span class=3D"" id=3D"=
:1y3.5" tabindex=3D"-1">sophos</span>.com</a>&gt;</span> wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex"><span>On Freitag, 24. Juni 2016 19:37:13 CEST Gert D=
oering wrote:<br>
&gt; This patch changes the order to IFCONFIG_AFTER_TUN_OPEN, moves some<br>
&gt; initialization code to init_tun, where it belongs, and removes duplica=
te<br>
&gt; code that is now no longer needed.<br>
<br>
</span>Yeah, I was skeptic at first, too. But it seems to work. That said, =
I&#39;ve only<br>
tested with the interactive service in place. It&#39;s the only option how =
to run<br>
Openvpn in a sane manner on Windows anyways. =3D)<br><br></blockquote><div>=
=C2=A0</div><div>True but not yet practical =C2=A0in some cases. For exampl=
e, we do not yet have way to start <span class=3D"" id=3D":1y3.6" tabindex=
=3D"-1">openvpn</span> using interactive service without using the GUI -- s=
ay run a client or a server (as from an <span class=3D"" id=3D":1y3.7" tabi=
ndex=3D"-1">init</span> script). We should do something about it, but until=
 then testing without interactive service is important -- easy to do, just =
run from the command line.</div><div><br></div><div>Also, a test against th=
e old tap driver (<span class=3D"" id=3D":1y3.8" tabindex=3D"-1">NDIS</span=
> 5.x) is in order..</div><div><br></div><div><span class=3D"" id=3D":1y3.9=
" tabindex=3D"-1">Selva</span></div><div><br></div><div><br></div></div><br=
><br></div></div>

--001a1149d7cac7134f05361a99cd--

