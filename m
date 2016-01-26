MIME-Version: 1.0
In-Reply-To: <20160126212431.GW24952@...1296...>
References: <2215306.x9ci9DhAZ9@...2001...>
	<1453835508-26119-1-git-send-email-gert@...1296...>
	<20160126191913.GV24952@...1296...> <56A7D1F6.8030805@...515...>
	<20160126212431.GW24952@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 26 Jan 2016 17:54:22 -0500
Message-ID: <CAKuzo_jKX6+KAw3cfPR-VTGe1A_bMh=R93i+4p=eC4BbCqWtAg@...278...>
Content-Type: multipart/alternative; boundary=089e01493abe2ce9e8052a449211
Subject: Re: [Openvpn-devel] [PATCH v3] interactive service v3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--089e01493abe2ce9e8052a449211
Content-Type: text/plain; charset=UTF-8

On Tue, Jan 26, 2016 at 4:24 PM, Gert Doering <gert@...1296...> wrote:

> Since Heiko has reworked the "classic" code (in automatic.c now, as
> he called this "automatic service") maybe we can just use the opportunity
> to get the remaining issues fixed - is there more than "restart openvpn.exe
> when it dies"?
>

Haven't look at the new code, but of  if the "automatic service" logic is
the same as before, it would take some work to make it behave like a
watchdog of openvpn.exe processes. Using NSSM for "automatic" uses and this
one only for interactive start ups by the GUI may be a better option. NSSM
has the added advantage of one service per config which could be
independently stopped and restarted etc.

The original service starts all the configs and then sits there waiting for
the exit event to trigger, at which point the service will just stop. For
one, the exit event will not trigger when openvpn.exe quits and even if we
make the event to trigger, there is only one common event for multiple
configs, and the service just stopping at such an event serves no purpose.

Instead of fixing it why not just use NSSM? Then the interactive service
patch could be decoupled from openvpnserv and provided as a new feature
independent of the original service.

Selva

--089e01493abe2ce9e8052a449211
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Jan 26, 2016 at 4:24 PM, Gert <span class=3D"" id=3D":aii.1" tabind=
ex=3D"-1">Doering</span> <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1711...=
96..." target=3D"_blank"><span class=3D"" id=3D":aii.2" tabindex=3D"-1">ger=
t</span>@<span class=3D"" id=3D":aii.3" tabindex=3D"-1">greenie</span>.<spa=
n class=3D"" id=3D":aii.4" tabindex=3D"-1">muc</span>.<span class=3D"" id=
=3D":aii.5" tabindex=3D"-1">de</span></a>&gt;</span> wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex"><div style=3D"overflow:hidden">Since Heiko has reworked =
the &quot;classic&quot; code (in automatic.c now, as<br>
he called this &quot;automatic service&quot;) maybe we can just use the opp=
ortunity<br>
to get the remaining issues fixed - is there more than &quot;restart openvp=
n.exe<br>
when it dies&quot;?</div></blockquote></div><div class=3D"gmail_extra"><br>=
</div>Haven&#39;t look at the new code, but of =C2=A0if the &quot;automatic=
 service&quot; logic is the same as before, it would take some work to make=
 it behave like a watchdog of <span class=3D"" id=3D":aii.6" tabindex=3D"-1=
">openvpn</span>.<span class=3D"" id=3D":aii.7" tabindex=3D"-1">exe</span> =
processes. Using <span style=3D"background-color:rgb(255,255,0)">NSSM</span=
>=C2=A0for &quot;automatic&quot; uses and this one only for interactive sta=
rt ups by the GUI may be a better option. <span class=3D"" id=3D":aii.9" ta=
bindex=3D"-1">NSSM</span> has the added advantage of one service per <span =
class=3D"" id=3D":aii.10" tabindex=3D"-1">config</span> which could be inde=
pendently stopped and restarted etc. =C2=A0</div><div class=3D"gmail_extra"=
><br>The original service starts all the <span class=3D"" id=3D":aii.11" ta=
bindex=3D"-1">configs</span> and then sits there waiting for the exit event=
 to trigger, at which point the service will just stop. For one, the exit e=
vent will not trigger when <span class=3D"" id=3D":aii.12" tabindex=3D"-1">=
openvpn</span>.<span class=3D"" id=3D":aii.13" tabindex=3D"-1">exe</span> q=
uits and even if we make the event to trigger, there is only one common eve=
nt for multiple <span class=3D"" id=3D":aii.14" tabindex=3D"-1">configs</sp=
an>, and the service just stopping at such an event serves no purpose.=C2=
=A0</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">In=
stead of fixing it why not just use <span class=3D"" id=3D":aii.15" tabinde=
x=3D"-1">NSSM</span>? Then the interactive service patch could be decoupled=
 from <span class=3D"" id=3D":aii.16" tabindex=3D"-1">openvpnserv</span> an=
d provided as a new feature independent of the original service.</div><div =
class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><span class=3D""=
 id=3D":aii.17" tabindex=3D"-1">Selva</span></div></div>

--089e01493abe2ce9e8052a449211--

