MIME-Version: 1.0
In-Reply-To: <CAFHpkQFj1ATTbGz5Nic2EKQJh2kZxXfVBZPoMvFOUFvfdhBtjg@...278...>
References: <CAFHpkQFj1ATTbGz5Nic2EKQJh2kZxXfVBZPoMvFOUFvfdhBtjg@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 20 Nov 2016 23:02:33 -0500
Message-ID: <CAKuzo_iXDpmNmNH2_ZmJSSRZYTKpRik6o1U744vNLtzhwM6noQ@...278...>
Content-Type: multipart/alternative; boundary=001a1147bc42ea90d20541c7ba2c
Subject: Re: [Openvpn-devel] handle unsupported windows versions in installer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1147bc42ea90d20541c7ba2c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Nov 20, 2016 at 9:22 PM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:

> due to dns filter, 2.4 (and future 2.3.14) requires at least windows vist=
a.


2.3.x will continue to work on WindowsXP -- block-outside-dns in 2.3 branch
is handled using runtime loading of the library so the option is just
ignored with a warning on XP.

As for 2.4 installer, if run on XP, showing a link to the  latest 2.3.x
before bailing out is a nice thing to do. If its not too much work, I would
vote for offering to download the installer as well.

Selva

--001a1147bc42ea90d20541c7ba2c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Sun, Nov 20, 2016 at 9:22 PM, =
=D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:chipitsine@...277..." target=3D"_blank">ch=
ipitsine@...277...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
due to dns filter, 2.4 (and future 2.3.14) requires at least windows vista.=
</blockquote></div><br></div><div class=3D"gmail_extra">2.3.x will continue=
 to work on WindowsXP -- block-outside-dns in 2.3 branch is handled using r=
untime loading of the library so the option is just ignored with a warning =
on XP. <br><br></div><div class=3D"gmail_extra">As for 2.4 installer, if ru=
n on XP, showing a link to the=C2=A0 latest 2.3.x before bailing out is a n=
ice thing to do. If its not too much work, I would vote for offering to dow=
nload the installer as well.<br><br></div><div class=3D"gmail_extra">Selva<=
br></div></div>

--001a1147bc42ea90d20541c7ba2c--

